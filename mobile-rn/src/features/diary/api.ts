import type { QueryClient } from '@tanstack/react-query';
import type { ApiClient } from '../../lib/api-client';
import type { FoodDetails } from '../food/api';
import type { FoodNutrientFilters } from '../food/nutrient-filters';
import { localDateKey, nextDate } from '../../lib/local-date';

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
  totalSugarsG?: number;
  totalSodiumMg?: number;
  totalSaturatedFatG?: number;
  totalCholesterolMg?: number;
  totalDietaryFibersG?: number;
  totalPotassiumMg?: number;
  note?: string | null;
  isCompleted?: boolean;
  exercises?: { id: string; name: string; duration: number; caloriesBurned: number }[];
  waterLog?: { amountMl: number; targetMl: number };
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


export type FoodPage = { items: FoodDetails[]; total?: number };

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
    getSuggestion: (date: string) => api.request<{ title: string; message: string }>('api/dashboard/today/suggestion', {
      query: { date },
    }),
    async recentFoods(date: string) {
      const { items } = await api.request<{ items: { food?: FoodDetails | null }[] }>('api/LogFood', {
        query: { startDate: nextDate(date, -30), endDate: date, page: 1, pageSize: 30 },
      });
      const recent = new Map<number, FoodDetails>();
      for (const item of items) {
        if (item.food && !recent.has(item.food.id)) recent.set(item.food.id, item.food);
        if (recent.size === 5) break;
      }
      return [...recent.values()];
    },
    searchFoods: (query: string, page: number, filters?: FoodNutrientFilters) => api.request<FoodPage>('api/Food', {
      query: {
        search: query || undefined, includeAll: true, page, pageSize: 20,
        nutrientFilters: filters && JSON.stringify(filters),
      },
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
    updateNote: (date: Date, note: string | null) => api.request<void>('api/Diary/note', {
      method: 'PUT', body: { date: localDateKey(date), note },
    }),
    complete: (date: Date) => api.request<void>('api/Diary/status', {
      method: 'POST', body: { date: localDateKey(date), isCompleted: true },
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
    queryClient.invalidateQueries({ queryKey: ['recent-foods'] }),
  ]);
}

export async function logFoodAndRefresh(api: ReturnType<typeof createDiaryApi>, queryClient: QueryClient, input: FoodLogInput) {
  await api.logFood(input);
  await refreshDiaryViews(queryClient, localDateKey(input.date));
}
