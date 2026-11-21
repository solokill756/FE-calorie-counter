import type { QueryClient } from '@tanstack/react-query';
import type { ApiClient } from '../../lib/api-client';
import { localDateKey } from '../../lib/local-date';

export const meals = ['breakfast', 'lunch', 'dinner', 'snack'] as const;
export type Meal = (typeof meals)[number];
export const mealLabels: Record<Meal, string> = {
  breakfast: 'Breakfast', lunch: 'Lunch', dinner: 'Dinner', snack: 'Snacks',
};

type FoodLog = {
  id: number;
  calories?: number | string;
  foodName?: string | null;
  food?: { description?: string; brandName?: string };
  loggedMeal?: { name?: string };
  loggedRecipe?: { title?: string };
};

export type Diary = {
  date: string;
  targetCalories?: number;
  totalCalories: number;
  totalProtein?: number;
  totalCarbs?: number;
  totalFat?: number;
  mealGroups?: { mealType: string; logs?: FoodLog[] }[];
};

type Macro = { current: number; target: number };

export type Dashboard = {
  date: string;
  user?: { displayName: string };
  calories: { target: number; consumed: number; remaining: number; burned: number };
  macros?: { protein: Macro; carbs: Macro; fat: Macro };
  water?: { currentMl: number; targetMl: number };
  exercise?: { minutes: number; caloriesBurned: number; workoutCount: number };
  weight?: { currentKg?: number | null; goalKg?: number | null };
};

type Food = {
  id: number;
  description: string;
  brandName?: string | null;
  calories?: number | string;
  servingSize?: number | string;
  servingUnit?: string;
  servingsPerContainer?: number | string;
};

export type FoodPage = { items: Food[]; total?: number };

type FoodLogInput = {
  foodId: number;
  date: Date;
  meal: Meal;
  quantity: number;
  servingSize: number;
};

export function createDiaryApi(api: ApiClient) {
  return {
    getDiary: (dateKey: string) => api.request<Diary>(`api/Diary/${dateKey}`),
    getDashboard: (dateKey: string) => api.request<Dashboard>('api/dashboard/today', { query: { date: dateKey } }),
    searchFoods: (query: string, page: number) => api.request<FoodPage>('api/Food', {
      query: { search: query || undefined, includeAll: true, page, pageSize: 20 },
    }),
    logFood: (input: FoodLogInput) => api.request<void>('api/LogFood', {
      method: 'POST',
      body: {
        foodId: input.foodId,
        meal: input.meal,
        type: 'regular',
        numberOfServings: input.quantity,
        servingSize: input.servingSize,
        loggedOn: localDateKey(input.date),
        LoggedAt: input.date.toISOString(),
      },
    }),
    removeEntry: (id: number) => api.request<void>(`api/LogFood/${id}`, { method: 'DELETE' }),
  };
}

export function entryName(log: FoodLog) {
  return log.food?.description?.trim() || log.foodName?.trim() || log.food?.brandName ||
    log.loggedMeal?.name || log.loggedRecipe?.title || 'Food';
}

export function entriesForMeal(diary: Diary, meal: Meal) {
  const mealTypes = meal === 'snack' ? ['snack', 'snacks'] : [meal];
  return (diary.mealGroups ?? [])
    .filter((group) => mealTypes.includes(group.mealType.toLowerCase()))
    .flatMap((group) => group.logs ?? []);
}

export async function refreshDiaryViews(queryClient: QueryClient, dateKey: string) {
  await Promise.all([
    queryClient.invalidateQueries({ queryKey: ['diary', dateKey] }),
    queryClient.invalidateQueries({ queryKey: ['dashboard', dateKey] }),
    queryClient.invalidateQueries({ queryKey: ['nutrition'] }),
  ]);
}

export async function logFoodAndRefresh(api: ReturnType<typeof createDiaryApi>, queryClient: QueryClient, input: FoodLogInput) {
  await api.logFood(input);
  await refreshDiaryViews(queryClient, localDateKey(input.date));
}
