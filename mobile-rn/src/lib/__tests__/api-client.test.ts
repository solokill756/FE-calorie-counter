import { createApiClient } from '../api-client';
import { initialDestination, restoreProfile } from '../../features/account/api';

const expired = { accessToken: 'old', refreshToken: 'refresh' };
const renewed = { accessToken: 'new', refreshToken: 'rotated' };

function response(status: number, body: unknown) {
  return new Response(JSON.stringify(body), { status });
}

function setup(transport: typeof fetch) {
  let session: typeof expired | null = expired;
  const read = jest.fn(async () => session);
  const write = jest.fn(async (value: typeof expired) => { session = value; });
  const clear = jest.fn(async () => { session = null; });
  const api = createApiClient('https://test.invalid/', { read, write, clear }, transport);
  return { api, read, write, clear };
}

test('refreshes once for concurrent requests and stores the rotated token', async () => {
  const transport: typeof fetch = jest.fn(async (url, init) => {
    if (String(url).endsWith('auth/refresh')) {
      expect(JSON.parse(String(init?.body))).toEqual({ refreshToken: 'refresh' });
      return response(200, renewed);
    }
    const token = new Headers(init?.headers).get('authorization');
    return token === 'Bearer new' ? response(200, { ok: true }) : response(401, {});
  });
  const { api, read } = setup(transport);
  await expect(Promise.all([api.request('api/Diary'), api.request('api/Today')]))
    .resolves.toEqual([{ ok: true }, { ok: true }]);
  expect(transport).toHaveBeenCalledTimes(5);
  await expect(read()).resolves.toEqual(renewed);
});

test('stops after rejected refresh and clears invalid credentials', async () => {
  const transport: typeof fetch = jest.fn(async () => response(401, { message: 'Expired' }));
  const { api, read } = setup(transport);
  await expect(api.request('api/Diary')).rejects.toMatchObject({ status: 401 });
  expect(transport).toHaveBeenCalledTimes(2);
  await expect(read()).resolves.toBeNull();
});

test('keeps the stored session during a temporary refresh outage', async () => {
  const { api, read } = setup(async (url) =>
    String(url).endsWith('auth/refresh') ? response(503, {}) : response(401, {}));
  await expect(api.request('api/Diary')).rejects.toMatchObject({ status: 503 });
  await expect(read()).resolves.toEqual(expired);
});

test('does not refresh public sign-in failures', async () => {
  const transport: typeof fetch = jest.fn(async () => response(401, { message: 'Invalid login' }));
  const { api } = setup(transport);
  await expect(api.request('auth/login', { method: 'POST', public: true }))
    .rejects.toMatchObject({ message: 'Invalid login' });
  expect(transport).toHaveBeenCalledTimes(1);
});

test('restores the backend profile before deciding which screen to show', async () => {
  const profile = { id: 25, displayName: 'Lan', isProfileComplete: true };
  const { api, read } = setup(async () => response(200, profile));
  expect(initialDestination(undefined)).toBe('loading');
  expect(initialDestination(await restoreProfile(api, read))).toBe('tabs');
  expect(initialDestination({ ...profile, isProfileComplete: false })).toBe('onboarding');
  expect(initialDestination(null)).toBe('sign-in');
});
