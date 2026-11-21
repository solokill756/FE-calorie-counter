import type { ApiClient } from '../../lib/api-client';
import { parseLocalDate } from '../../lib/local-date';
import type { Meal } from '../diary/api';

type QuickAdd = { calories: number; proteinG?: number; totalCarbohydratesG?: number; totalFatG?: number };
export type FoodDetails = {
  id: number;
  description: string;
  brandName?: string;
  category?: string;
  servingUnit?: string;
  servingSize?: number;
  servingsPerContainer?: number;
} & Partial<Record<string, string | number>>;
type FoodInput = Omit<FoodDetails, 'id'> & { category: string };

const mealNutrients = {
  calories: 'calories', totalCarbohydratesG: 'carbs', proteinG: 'protein', totalFatG: 'fat',
  sodiumMg: 'sodium', dietaryFibersG: 'fiber', sugarsG: 'sugar', saturatedFatG: 'saturatedFat',
  cholesterolMg: 'cholesterol', potassiumMg: 'potassium', calciumMg: 'calcium', ironMg: 'iron',
  magnesiumMg: 'magnesium', phosphorusMg: 'phosphorus', zincMg: 'zinc', vitaminAUg: 'vitaminA',
  vitaminCMg: 'vitaminC', vitaminDUg: 'vitaminD', vitaminEMg: 'vitaminE', vitaminKUg: 'vitaminK',
  vitaminB6Mg: 'vitaminB6', vitaminB12Ug: 'vitaminB12', folateDfeUg: 'folateDfe',
} as const;

type MealNutrition = Partial<Record<(typeof mealNutrients)[keyof typeof mealNutrients], number>>;

export type SavedMeal = {
  id: number;
  name: string;
  directions?: string | null;
  imageUrl?: string | null;
  items: { id: number; foodId: number; quantity: number; unit?: string; food?: FoodDetails | null }[];
  nutritionSummary?: MealNutrition;
};

export function scaledMealNutrients(value: SavedMeal, quantity: number) {
  return Object.fromEntries(Object.entries(mealNutrients).map(([field, key]) => [
    field, (value.nutritionSummary?.[key] ?? 0) * quantity,
  ]));
}

export function createFoodApi(api: ApiClient) {
  return {
    getFood: (id: number) => api.request<FoodDetails>(`api/Food/${id}`),
    listMyFoods: () => api.request<{ items: FoodDetails[] }>('api/Food', {
      query: { mineOnly: true, page: 1, pageSize: 100, includeAll: true },
    }),
    saveFood: (body: FoodInput, id?: number) => api.request<FoodDetails>(id ? `api/Food/${id}` : 'api/Food', {
      method: id ? 'PUT' : 'POST', body,
    }),
    deleteFood: (id: number) => api.request<void>(`api/Food/${id}`, { method: 'DELETE' }),
    listMeals: () => api.request<{ items: SavedMeal[] }>('api/Meal', {
      query: { page: 1, pageSize: 100 },
    }),
    getMeal: (id: number) => api.request<SavedMeal>(`api/Meal/${id}`),
    saveMeal: (body: { name: string; directions?: string; imageUrl?: string }, id?: number) =>
      api.request<SavedMeal>(id ? `api/Meal/${id}` : 'api/Meal', { method: id ? 'PUT' : 'POST', body }),
    deleteMeal: (id: number) => api.request<void>(`api/Meal/${id}`, { method: 'DELETE' }),
    addMealItem: (id: number, foodId: number, quantity: number) =>
      api.request<SavedMeal>(`api/Meal/${id}/items`, { method: 'POST', body: { foodId, quantity } }),
    updateMealItem: (id: number, itemId: number, quantity: number) =>
      api.request<SavedMeal>(`api/Meal/${id}/items/${itemId}`, { method: 'PUT', body: { quantity } }),
    removeMealItem: (id: number, itemId: number) =>
      api.request<SavedMeal>(`api/Meal/${id}/items/${itemId}`, { method: 'DELETE' }),
    quickAdd: (date: string, meal: Meal, input: QuickAdd) =>
      api.request<void>('api/LogFood', { method: 'POST', body: {
        ...input, loggedOn: date, LoggedAt: parseLocalDate(date)?.toISOString(), meal, type: 'quickAdd',
      } }),
    logMeal: (date: string, meal: Meal, value: SavedMeal, quantity: number) =>
      api.request<void>('api/LogFood', { method: 'POST', body: {
        mealId: value.id, meal, loggedOn: date, LoggedAt: parseLocalDate(date)?.toISOString(),
        foodName: value.name, type: 'regular', numberOfServings: quantity, servingSize: 1, unit: 'meal',
        ...scaledMealNutrients(value, quantity),
      } }),
  };
}
