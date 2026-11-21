import type { ApiClient } from '../../lib/api-client';
import type { Meal } from '../diary/api';
import type { FoodDetails } from '../food/api';

type Ingredient = {
  foodId?: number; name: string; quantity: number; unit: string;
} & Partial<Record<'calories' | 'protein' | 'carbs' | 'fat' | 'fiber' | 'sodium' | 'sugar' |
  'saturatedFat' | 'cholesterol' | 'potassium' | 'calciumMg' | 'ironMg' | 'magnesiumMg' |
  'phosphorusMg' | 'zincMg' | 'vitaminAUg' | 'vitaminCMg' | 'vitaminDUg' | 'vitaminEMg' |
  'vitaminKUg' | 'vitaminB6Mg' | 'vitaminB12Ug' | 'folateDfeUg', number>>;
type Step = { order: number; instruction: string; duration?: number; tips?: string };

export type RecipeDraft = {
  name: string; description?: string | null; imageUrl?: string; servings: number;
  prepMinutes: number; cookMinutes: number; difficulty: string; tags: string[];
  ingredients: Ingredient[]; steps: Step[]; shareWith: number;
  sourceType?: string; dateKey?: string; mealSlot?: Meal; score?: number; warnings?: string[];
};
export type Recipe = RecipeDraft & { id: number };

type Generated = {
  recipe: Partial<Omit<RecipeDraft, 'ingredients'>> & {
    preparationTime?: number; cookingTime?: number;
    ingredients?: (Partial<Ingredient> & { food_id?: number; amount?: number; amount_g?: number; servingSizeG?: number; serving_size_g?: number })[];
  };
  recommendation?: string;
  safetyWarnings?: string[];
  generationWarnings?: string[];
  scoreWarnings?: string[];
  score?: number;
};

type StapleFood = Omit<FoodDetails, 'id' | 'description'> & {
  id: number | string;
  description?: string;
  foodName?: string;
};

type Detection = {
  clientIngredientId: string; detectedName: string;
  candidates: { foodId: number; foodName: string; brandName?: string }[];
};

export function recipeFromGeneration(result: Generated, dateKey: string, mealSlot: Meal): RecipeDraft {
  const recipe = result.recipe;
  if (!recipe) throw new Error('Recipe generation returned no recipe.');
  const warnings = [...new Set([...(result.safetyWarnings ?? []), ...(result.generationWarnings ?? []), ...(result.scoreWarnings ?? [])])];
  return {
    name: recipe.name?.trim() || 'Suggested recipe',
    description: [recipe.description, result.recommendation].filter(Boolean).join('\n\n') || undefined,
    servings: Math.max(1, Number(recipe.servings) || 1),
    prepMinutes: recipe.prepMinutes ?? recipe.preparationTime ?? 0,
    cookMinutes: recipe.cookMinutes ?? recipe.cookingTime ?? 0,
    difficulty: ['easy', 'medium', 'hard'].includes(recipe.difficulty ?? '') ? recipe.difficulty! : 'easy',
    tags: recipe.tags ?? [],
    ingredients: (recipe.ingredients ?? []).map(({ food_id, amount, amount_g, servingSizeG, serving_size_g, ...item }) => ({
      ...item, name: item.name ?? 'Ingredient', foodId: item.foodId ?? food_id,
      quantity: Number(amount) || Number(item.quantity) || (Number(amount_g) || 0) / (Number(servingSizeG ?? serving_size_g) || 100),
      unit: item.unit ?? 'g',
    })),
    steps: (recipe.steps ?? []).map(({ order, instruction, duration, tips }, index) => ({
      order: order || index + 1, instruction, duration, tips,
    })),
    shareWith: 1,
    sourceType: 'ai_recipe_builder',
    dateKey,
    mealSlot,
    score: result.score,
    warnings,
  };
}

const ingredientFields = [
  'foodId', 'name', 'quantity', 'unit', 'calories', 'protein', 'carbs', 'fat', 'fiber', 'sodium', 'sugar',
  'saturatedFat', 'cholesterol', 'potassium', 'calciumMg', 'ironMg', 'magnesiumMg', 'phosphorusMg', 'zincMg',
  'vitaminAUg', 'vitaminCMg', 'vitaminDUg', 'vitaminEMg', 'vitaminKUg', 'vitaminB6Mg', 'vitaminB12Ug', 'folateDfeUg',
] as const satisfies readonly (keyof Ingredient)[];

function recipePayload(recipe: RecipeDraft): RecipeDraft {
  return {
    name: recipe.name, description: recipe.description ?? undefined, imageUrl: recipe.imageUrl ?? undefined,
    shareWith: recipe.shareWith, servings: recipe.servings, prepMinutes: recipe.prepMinutes, cookMinutes: recipe.cookMinutes,
    difficulty: recipe.difficulty, tags: recipe.tags, sourceType: recipe.sourceType ?? undefined,
    dateKey: recipe.dateKey ?? undefined, mealSlot: recipe.mealSlot ?? undefined, score: recipe.score ?? undefined,
    warnings: recipe.warnings,
    ingredients: recipe.ingredients.map((value) => Object.fromEntries(ingredientFields
      .filter((field) => value[field] != null).map((field) => [field, value[field]])) as Ingredient),
    steps: recipe.steps.map(({ order, instruction, duration, tips }) => ({ order, instruction, duration, tips })),
  };
}

export function createRecipeApi(api: ApiClient) {
  return {
    async staples(): Promise<FoodDetails[]> {
      const items = await api.request<StapleFood[]>('recipe-builder/staples');
      return items.map((item) => ({
        ...item, id: Number(item.id), description: item.description ?? item.foodName ?? 'Food',
      }));
    },
    addStaple: (foodId: number) => api.request<void>('recipe-builder/staples', { method: 'POST', body: { foodId } }),
    removeStaple: (id: number) => api.request<void>(`recipe-builder/staples/${id}`, { method: 'DELETE' }),
    quota: () => api.request<{ inProgress: boolean }>('fridge-meal-plans/manual-quota'),
    plan: (date: string, replace = false) => api.request<{
      slots: { mealSlot: string; status: string; reason?: string }[];
    }>('fridge-meal-plans/generate', { method: 'POST', body: { date, ...(replace ? { replace } : {}) } }),
    recognize: (imageUrl: string) => api.request<{ ingredients: Detection[] }>('recipe-builder/vision/recognize', {
      method: 'POST', body: { imageUrl, topK: 5 },
    }),
    generate: (foodIds: number[], mealSlot: Meal, date: string, constraints?: { maxTimeMinutes?: number }, signal?: AbortSignal) =>
      api.request<Generated>('recipe-builder/generate', { method: 'POST', signal, body: { foodIds, mealSlot, date, constraints } }),
    list: () => api.request<Recipe[]>('recipe-builder/recipes'),
    save: (body: RecipeDraft, id?: number, signal?: AbortSignal) => api.request<Recipe>(
      id ? `recipe-builder/recipes/${id}` : 'recipe-builder/recipes', { method: id ? 'PUT' : 'POST', body: recipePayload(body), signal },
    ),
    delete: (id: number) => api.request<void>(`recipe-builder/recipes/${id}`, { method: 'DELETE' }),
    convert: (id: number) => api.request(`recipe-builder/recipes/${id}/convert-to-meal`, { method: 'POST' }),
  };
}
