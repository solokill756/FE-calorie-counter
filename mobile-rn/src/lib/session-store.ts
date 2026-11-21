import * as SecureStore from 'expo-secure-store';
import type { Session, SessionStore } from './api-client';

const sessionKey = 'calorie-counter.session';

export function createSessionStore(onClear: () => void): SessionStore {
  let pending = Promise.resolve();

  function run<T>(task: () => Promise<T>): Promise<T> {
    const result = pending.then(task);
    pending = result.then(() => undefined, () => undefined);
    return result;
  }

  return {
    read: () => run(async () => {
      const stored = await SecureStore.getItemAsync(sessionKey);
      if (!stored) return null;
      const session = JSON.parse(stored) as Partial<Session>;
      if (!session.accessToken || !session.refreshToken) return null;
      return { accessToken: session.accessToken, refreshToken: session.refreshToken };
    }),
    write: (session) => run(() => SecureStore.setItemAsync(sessionKey, JSON.stringify(session))),
    clear: () => run(async () => {
      await SecureStore.deleteItemAsync(sessionKey);
      onClear();
    }),
  };
}
