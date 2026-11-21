import type { RecipeDraft } from './api';

export type DraftState =
  | { state: 'generating'; jobId: string }
  | { state: 'draft'; jobId: string; draft: RecipeDraft }
  | { state: 'saved'; jobId: string; recipeId: number; name: string };

type Storage = {
  getItem(key: string): Promise<string | null>;
  setItem(key: string, value: string): Promise<unknown>;
  removeItem(key: string): Promise<unknown>;
};

export function createDraftStore(storage: Storage) {
  const key = (owner: number) => `calorie-counter.recipe-draft.${owner}`;
  return {
    async read(owner: number): Promise<DraftState | null> {
      const raw = await storage.getItem(key(owner));
      if (!raw) return null;
      try {
        const record = JSON.parse(raw) as DraftState;
        return record?.jobId && ['generating', 'draft', 'saved'].includes(record.state) ? record : null;
      } catch {
        return null;
      }
    },
    write: (owner: number, record: DraftState) => storage.setItem(key(owner), JSON.stringify(record)),
    clear: (owner: number) => storage.removeItem(key(owner)),
  };
}
