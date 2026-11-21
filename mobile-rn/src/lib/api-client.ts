export type Session = {
  accessToken: string;
  refreshToken: string;
};

export type SessionStore = {
  read(): Promise<Session | null>;
  write(session: Session): Promise<void>;
  clear(): Promise<void>;
  replace(previous: Session, next: Session | null): Promise<boolean>;
};

export type RequestOptions = {
  method?: 'GET' | 'POST' | 'PATCH' | 'PUT' | 'DELETE';
  public?: boolean;
  query?: Record<string, string | number | boolean | undefined>;
  body?: unknown;
  signal?: AbortSignal;
};

export class ApiError extends Error {
  constructor(public readonly status: number, message: string) {
    super(message);
    this.name = 'ApiError';
  }
}

export type ApiClient = {
  request<T>(path: string, options?: RequestOptions): Promise<T>;
};

async function readBody(response: Response): Promise<unknown> {
  const body = await response.text();
  if (!body) return undefined;

  try {
    return JSON.parse(body);
  } catch {
    return body;
  }
}

function messageOf(body: unknown, status: number): string {
  const message = (body as { message?: unknown } | null)?.message;
  if (typeof message === 'string' && message.trim()) return message;
  if (Array.isArray(message)) return message.filter((part) => typeof part === 'string').join(' · ');
  return `Request failed (${status}).`;
}

export function createApiClient(
  baseUrl: string,
  store: SessionStore,
  transport: typeof fetch = (...args) => fetch(...args),
): ApiClient {
  let refreshing: { previous: Session; result: Promise<Session | null> } | undefined;
  let lastRotation: { previous: Session; next: Session } | undefined;

  function matches(first: Session | null | undefined, second: Session | null | undefined) {
    return Boolean(first && second && first.accessToken === second.accessToken && first.refreshToken === second.refreshToken);
  }

  async function send(path: string, options: RequestOptions, token?: string) {
    if (!baseUrl) {
      throw new Error('Set EXPO_PUBLIC_API_URL to connect to the Calorie Counter backend.');
    }

    const queryParts = Object.entries(options.query ?? {})
      .filter(([, value]) => value !== undefined)
      .map(([key, value]) => `${encodeURIComponent(key)}=${encodeURIComponent(String(value))}`);
    const relativePath = path.replace(/^\/+/, '');
    const url = `${baseUrl.replace(/\/+$/, '')}/${relativePath}`;
    const query = queryParts.length ? `${relativePath.includes('?') ? '&' : '?'}${queryParts.join('&')}` : '';
    const headers = new Headers({
      Accept: 'application/json',
      'X-Tz-Offset-Minutes': String(-new Date().getTimezoneOffset()),
    });
    if (token) headers.set('Authorization', `Bearer ${token}`);
    const multipart = options.body instanceof FormData;
    if (options.body !== undefined && !multipart) {
      headers.set('Content-Type', 'application/json');
    }

    return transport(url + query, {
      method: options.method ?? 'GET',
      headers,
      signal: options.signal,
      body: multipart ? options.body as FormData : JSON.stringify(options.body),
    });
  }

  async function refresh(previous: Session): Promise<Session | null> {
    const current = await store.read();
    if (!current) return null;
    if (!matches(current, previous)) {
      return matches(lastRotation?.previous, previous) && matches(lastRotation?.next, current) ? current : null;
    }

    const response = await send('auth/refresh', {
      method: 'POST',
      body: { refreshToken: current.refreshToken },
    });
    const body = await readBody(response);

    if ([400, 401, 403].includes(response.status)) {
      await store.replace(current, null);
      return null;
    }
    if (!response.ok) throw new ApiError(response.status, messageOf(body, response.status));

    const data = body as Partial<Session> | undefined;
    if (!data?.accessToken) throw new ApiError(502, 'The server did not return an access token.');

    const updated = {
      accessToken: data.accessToken,
      refreshToken: data.refreshToken || current.refreshToken,
    };
    if (!(await store.replace(current, updated))) return null;
    lastRotation = { previous: current, next: updated };
    return updated;
  }

  return {
    async request<T>(path: string, options: RequestOptions = {}): Promise<T> {
      const previous = options.public ? null : await store.read();
      let response = await send(path, options, previous?.accessToken);
      if (previous && [401, 403].includes(response.status)) {
        if (!refreshing || !matches(refreshing.previous, previous)) {
          const result = refresh(previous).finally(() => {
            if (refreshing?.result === result) refreshing = undefined;
          });
          refreshing = { previous, result };
        }
        const updated = await refreshing.result;
        if (updated && matches(await store.read(), updated)) {
          response = await send(path, options, updated.accessToken);
        }
      }

      const body = await readBody(response);
      if (!response.ok) throw new ApiError(response.status, messageOf(body, response.status));
      return body as T;
    },
  };
}
