import { useQueryClient } from '@tanstack/react-query';
import { createContext, type PropsWithChildren, useContext, useEffect, useMemo, useState } from 'react';
import { bindApiToSession, createApiClient, type ApiClient } from '../../lib/api-client';
import { createSessionStore } from '../../lib/session-store';
import { createAccountApi, type UserProfile } from './api';

type AccountApi = ReturnType<typeof createAccountApi>;

type AccountContext = {
  api: ApiClient;
  account: Pick<AccountApi, 'forgot' | 'reset' | 'deleteAccount'>;
  profile: UserProfile | null | undefined;
  setProfile(profile: UserProfile): void;
  error: string | null;
  restore(): Promise<void>;
  signIn(email: string, password: string): Promise<void>;
  register(email: string, password: string, displayName: string): Promise<void>;
  signInWithProvider(provider: 'apple' | 'google', token: string): Promise<void>;
  signOut(): Promise<void>;
};

const Context = createContext<AccountContext | null>(null);

export function SessionProvider({ children }: PropsWithChildren) {
  const queryClient = useQueryClient();
  const [profile, setProfileState] = useState<UserProfile | null | undefined>(undefined);
  const [error, setError] = useState<string | null>(null);
  const [services] = useState(() => {
    const epoch = { value: 0 };
    const store = createSessionStore(() => {
      epoch.value += 1;
      queryClient.clear();
      setProfileState(null);
    }, () => { epoch.value += 1; });
    const api = createApiClient(process.env.EXPO_PUBLIC_API_URL ?? '', store);
    return { api, store, epoch, busy: false, account: createAccountApi(api, store) };
  });
  const generation = services.epoch.value;
  const scoped = useMemo(() => {
    const isCurrent = () => services.epoch.value === generation;
    const api = bindApiToSession(services.api, isCurrent);
    return { api, isCurrent, account: createAccountApi(api, services.store, isCurrent) };
  }, [services, generation]);

  async function restore() {
    setError(null);
    try {
      const next = await scoped.account.restore();
      if (scoped.isCurrent()) setProfileState(next);
    } catch (cause) {
      if (scoped.isCurrent()) setError(cause instanceof Error ? cause.message : 'The session could not be restored.');
    }
  }

  useEffect(() => {
    void restore();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [services]);

  async function authenticate(attempt: () => Promise<UserProfile>) {
    if (!scoped.isCurrent() || services.busy) return;
    services.busy = true;
    try {
      const current = await attempt();
      if (services.epoch.value !== generation + 1) return;
      queryClient.clear();
      setProfileState(current);
    } finally {
      services.busy = false;
    }
  }

  return (
    <Context.Provider value={{
      api: scoped.api,
      account: scoped.account,
      profile,
      setProfile: (next) => { if (scoped.isCurrent()) setProfileState(next); },
      error,
      restore,
      signIn: (email, password) => authenticate(() => services.account.signIn({ email, password })),
      register: (email, password, name) => authenticate(() => services.account.register({ email, password }, name)),
      signInWithProvider: (provider, token) => authenticate(() => services.account.socialSignIn(provider, token)),
      signOut: scoped.account.signOut,
    }}>
      {children}
    </Context.Provider>
  );
}

export function useSession() {
  const session = useContext(Context);
  if (!session) throw new Error('SessionProvider is missing.');
  return session;
}
