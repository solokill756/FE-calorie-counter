import * as SecureStore from 'expo-secure-store';
import type { Session, SessionStore } from './api-client';

const sessionKey = 'calorie-counter.session';

export function createSessionStore(onClear: () => void, onNewSession: () => void): SessionStore {
  let pending = Promise.resolve();

  function run<T>(task: () => Promise<T>): Promise<T> {
    const result = pending.then(task);
    pending = result.then(() => undefined, () => undefined);
    return result;
  }

  async function read() {
    const stored = await SecureStore.getItemAsync(sessionKey);
    if (!stored) return null;
    const session = JSON.parse(stored) as Partial<Session>;
    if (!session.accessToken || !session.refreshToken) return null;
    return { accessToken: session.accessToken, refreshToken: session.refreshToken };
  }

  async function write(session: Session | null) {
    if (session) {
      await SecureStore.setItemAsync(sessionKey, JSON.stringify(session));
    } else {
      await SecureStore.deleteItemAsync(sessionKey);
      onClear();
    }
  }

  return {
    read: () => run(read),
    write: (session) => run(async () => {
      await write(session);
      onNewSession();
    }),
    clear: (allowed) => run(async () => {
      if (!allowed || allowed()) await write(null);
    }),
    replace: (previous, next) => run(async () => {
      const current = await read();
      if (current?.accessToken !== previous.accessToken || current.refreshToken !== previous.refreshToken) return false;
      await write(next);
      return true;
    }),
  };
}
