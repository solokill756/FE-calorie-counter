import { randomUUID } from 'node:crypto';
import { createAccountApi } from '../../features/account/api';
import { createOnboardingApi } from '../../features/account/onboarding';
import { createExerciseApi } from '../../features/exercise/api';
import { createNutritionApi } from '../../features/nutrition/api';
import { createProgressApi } from '../../features/progress/api';
import { createDiaryApi } from '../../features/diary/api';
import { createFoodApi } from '../../features/food/api';
import { createNotificationsApi } from '../../features/notifications/api';
import { createProfileApi } from '../../features/profile/api';
import { createRecipeApi } from '../../features/recipes/api';
import { createWaterApi } from '../../features/water/api';
import { createApiClient, type Session } from '../api-client';
import { localDateKey } from '../local-date';

const base = process.env.CALORIE_TEST_API_URL;
const smoke = base ? test : test.skip;

smoke('a disposable account can onboard, log food and reload dashboard through the local API', async () => {
  if (!base || !['127.0.0.1', 'localhost', '[::1]'].includes(new URL(base).hostname)) {
    throw new Error('The smoke test must target a local backend.');
  }
  let session: Session | null = null;
  const store = {
    read: async () => session,
    write: async (next: Session) => { session = next; },
    clear: async () => { session = null; },
    replace: async (previous: Session, next: Session | null) => {
      if (session !== previous) return false;
      session = next;
      return true;
    },
  };
  const api = createApiClient(base, store, async (request, options) => {
    const response = await fetch(request, options);
    if (!response.ok) {
      const { pathname } = new URL(String(request));
      const body = await response.clone().json();
      console.error(options?.method, pathname, response.status, body.errorKey ?? body.message);
    }
    return response;
  });
  const account = createAccountApi(api, store);
  const diary = createDiaryApi(api);
  const user = randomUUID();
  const date = new Date();
  const day = localDateKey(date);
  const credentials = { email: `rn-test-${user}@example.com`, password: `Temporary-${user}!` };
  const profile = await account.register(credentials, 'RN smoke test');
  const foods = createFoodApi(api);
  let sampleFoodId: number | undefined;

  try {
    expect(profile.isProfileComplete).toBe(false);
    const onboarding = createOnboardingApi(api);
    const draft = {
      displayName: profile.displayName, gender: 'female', age: 30, heightCm: 165,
      currentWeightKg: 65, goalWeightKg: 60, conditionTypes: [],
      goalType: 'maintenance' as const, activityLevel: 'moderate',
    };
    expect((await onboarding.preview(draft)).targetCalories).toBeGreaterThan(0);
    await onboarding.save(draft);
    expect(await account.restore()).toMatchObject({ id: profile.id, isProfileComplete: true });
    await account.signOut();
    expect(await account.signIn(credentials)).toMatchObject({
      id: profile.id,
      goalType: 'maintenance',
      nutritionTargets: { targetCalories: expect.any(Number) },
    });

    const food = await foods.saveFood({
      description: 'RN smoke test meal', category: 'RN smoke test', servingSize: 100, servingUnit: 'g',
      calories: 150, proteinG: 6, totalCarbohydratesG: 30, totalFatG: 1, sodiumMg: 40, ironMg: 2,
    });
    sampleFoodId = food.id;
    const result = await diary.searchFoods(food.description, 1);
    expect(result.items.some((item) => item.id === food.id)).toBe(true);
    await diary.logFood({ foodId: food.id, date, meal: 'lunch', quantity: 1, servingSize: 100 });
    expect((await diary.getDiary(day)).totalCalories).toBe(150);
    expect((await diary.getDashboard(day)).calories.consumed).toBe(150);
    const nutrition = createNutritionApi(api);
    expect((await nutrition.logs(day, day)).some((log) => Number(log.calories) === 150)).toBe(true);
    await diary.updateNote(date, 'Recorded on React Native');
    expect((await diary.getDiary(day)).note).toBe('Recorded on React Native');

    const meal = await foods.saveMeal({ name: 'Disposable saved meal' });
    const withItem = await foods.addMealItem(meal.id, food.id, 1);
    expect(withItem.items).toHaveLength(1);
    await foods.logMeal(day, 'dinner', withItem, 2);
    const dinner = (await nutrition.logs(day, day)).find((item) => item.meal === 'dinner');
    expect(dinner).toMatchObject({ calories: 300, sodiumMg: 80, ironMg: 4, numberOfServings: 2 });
    await foods.deleteMeal(meal.id);

    const water = createWaterApi(api);
    await water.add(250, day);
    expect((await water.today()).amountMl).toBe(250);

    expect(await createProfileApi(api).updateGoal('weight_loss')).toMatchObject({ goalType: 'weight_loss' });
    const progress = createProgressApi(api);
    const weight = await progress.save({ weightKg: 64.1, recordedAt: date.toISOString() });
    expect((await progress.list(1)).items.some((item) => item.id === weight.id)).toBe(true);

    const workouts = createExerciseApi(api);
    const exercise = await workouts.save({ name: 'Disposable walk', type: 'cardio', met: 4 });
    await workouts.addLog(exercise.id, 15, date.toISOString());
    const log = (await workouts.logs(1)).items.find((item) => item.exerciseName === exercise.name);
    expect(log).toBeDefined();
    expect((await diary.getDiary(day)).exercises).toEqual(expect.arrayContaining([
      expect.objectContaining({ name: exercise.name, duration: 15 }),
    ]));
    if (log) await workouts.removeLog(log.id);
    await workouts.deleteExercise(exercise.id);

    const recipes = createRecipeApi(api);
    await recipes.addStaple(food.id);
    expect((await recipes.staples()).some((item) => item.id === food.id)).toBe(true);
    await recipes.removeStaple(food.id);
    const recipe = await recipes.save({
      name: 'Disposable recipe', servings: 1, prepMinutes: 5, cookMinutes: 5,
      difficulty: 'easy', tags: [], shareWith: 1,
      ingredients: [{ foodId: food.id, name: food.description, quantity: 1, unit: 'g' }],
      steps: [{ order: 1, instruction: 'Prepare.' }],
    });
    const updated = await recipes.save({ ...recipe, name: 'Disposable revised recipe' }, recipe.id);
    expect(updated.name).toBe('Disposable revised recipe');
    await recipes.delete(updated.id);
    await diary.complete(date);
    expect((await diary.getDiary(day)).isCompleted).toBe(true);

    expect(Array.isArray((await createNotificationsApi(api).list()).items)).toBe(true);
  } finally {
    if (!session) await account.signIn(credentials);
    try {
      if (sampleFoodId) await foods.deleteFood(sampleFoodId);
    } finally {
      await account.deleteAccount();
    }
  }
}, 30_000);
