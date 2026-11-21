import { randomUUID } from 'node:crypto';
import { createAccountApi } from '../../features/account/api';
import { createOnboardingApi } from '../../features/account/onboarding';
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

  try {
    expect(profile.isProfileComplete).toBe(false);
    await createOnboardingApi(api).save({
      displayName: profile.displayName, gender: 'female', age: 30, heightCm: 165,
      currentWeightKg: 65, goalWeightKg: 60, conditionTypes: [],
      goalType: 'maintenance', activityLevel: 'moderate',
    });
    expect(await account.restore()).toMatchObject({ id: profile.id, isProfileComplete: true });
    await account.signOut();
    expect(await account.signIn(credentials)).toMatchObject({ id: profile.id });

    const food = await createFoodApi(api).saveFood({
      description: 'RN smoke test meal', category: 'RN smoke test', servingSize: 100, servingUnit: 'g',
      calories: 150, proteinG: 6, totalCarbohydratesG: 30, totalFatG: 1,
    });
    const result = await diary.searchFoods(food.description, 1);
    expect(result.items.some((item) => item.id === food.id)).toBe(true);
    await diary.logFood({ foodId: food.id, date, meal: 'lunch', quantity: 1, servingSize: 100 });
    expect((await diary.getDiary(day)).totalCalories).toBe(150);
    expect((await diary.getDashboard(day)).calories.consumed).toBe(150);

    const water = createWaterApi(api);
    await water.add(250, day);
    expect((await water.today()).amountMl).toBe(250);

    expect(await createProfileApi(api).updateGoal('weight_loss')).toMatchObject({ goalType: 'weight_loss' });
    const recipes = createRecipeApi(api);
    await recipes.addStaple(food.id);
    expect((await recipes.staples()).some((item) => item.id === food.id)).toBe(true);
    await recipes.removeStaple(food.id);

    expect(Array.isArray((await createNotificationsApi(api).list()).items)).toBe(true);
  } finally {
    if (!session) await account.signIn(credentials);
    await account.deleteAccount();
  }
}, 30_000);
