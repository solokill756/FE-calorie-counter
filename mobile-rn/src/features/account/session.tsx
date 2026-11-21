import { useQueryClient } from '@tanstack/react-query';
import { createContext, type PropsWithChildren, useContext, useEffect, useState } from 'react';
import { createApiClient, type ApiClient } from '../../lib/api-client';
import { createSessionStore } from '../../lib/session-store';
import { createAccountApi, type UserProfile } from './api';

type AccountContext = {
  api: ApiClient;
  account: ReturnType<typeof createAccountApi>;
  profile: UserProfile | null | undefined;
  setProfile(profile: UserProfile): void;
  error: string | null;
  restore(): Promise<void>;
  signIn(email: string, password: string): Promise<void>;
  signOut(): Promise<void>;
};

const Context = createContext<AccountContext | null>(null);

export function SessionProvider({ children }: PropsWithChildren) {
  const queryClient = useQueryClient();
  const [profile, setProfile] = useState<UserProfile | null | undefined>(undefined);
  const [error, setError] = useState<string | null>(null);
  const [services] = useState(() => {
    const store = createSessionStore(() => {
      queryClient.clear();
      setProfile(null);
    });
    const api = createApiClient(process.env.EXPO_PUBLIC_API_URL ?? '', store);
    return { api, account: createAccountApi(api, store) };
  });

  async function restore() {
    setError(null);
    try {
      setProfile(await services.account.restore());
    } catch (cause) {
      setError(cause instanceof Error ? cause.message : 'The session could not be restored.');
    }
  }

  useEffect(() => {
    void restore();
    // The service instances belong to this provider for its entire lifetime.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [services]);

  async function signIn(email: string, password: string) {
    const current = await services.account.signIn({ email, password });
    queryClient.clear();
    setProfile(current);
  }

  return (
    <Context.Provider value={{
      api: services.api, account: services.account, profile, setProfile, error, restore, signIn, signOut: services.account.signOut,
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
