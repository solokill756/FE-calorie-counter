import { createDraftStore } from '../draft-store';
import { recipeFromGeneration } from '../api';

test('turns generation output and warnings into a savable recipe', () => {
  const result = recipeFromGeneration({
    recipe: { name: 'Rice bowl', servings: 2, ingredients: [{ food_id: 5, name: 'Rice', amount_g: 200, servingSizeG: 100 }] },
    safetyWarnings: ['Contains soy'],
  }, '2026-11-21', 'lunch');
  expect(result).toMatchObject({
    name: 'Rice bowl', servings: 2, sourceType: 'ai_recipe_builder', dateKey: '2026-11-21', mealSlot: 'lunch',
    ingredients: [{ foodId: 5, quantity: 2 }], warnings: ['Contains soy'],
  });
});

test('recovers a retryable draft for the account that started the job', async () => {
  const data = new Map<string, string>();
  const store = createDraftStore({
    getItem: async (key) => data.get(key) ?? null,
    setItem: async (key, value) => { data.set(key, value); },
    removeItem: async (key) => { data.delete(key); },
  });
  const draft = recipeFromGeneration({ recipe: { name: 'Test recipe' } }, '2026-11-21', 'dinner');
  await store.write(19, { state: 'draft', jobId: 'test-job', draft });
  expect(await store.read(20)).toBeNull();
  expect(await store.read(19)).toEqual(JSON.parse(JSON.stringify({ state: 'draft', jobId: 'test-job', draft })));
  await store.clear(19);
  expect(await store.read(19)).toBeNull();
});
