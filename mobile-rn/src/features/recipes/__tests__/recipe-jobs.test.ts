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
