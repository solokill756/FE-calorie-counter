import type { ApiClient } from '../../lib/api-client';
import type { GoalType } from '../profile/api';

export type OnboardingData = {
  displayName: string;
  gender: string;
  age: number;
  heightCm: number;
  currentWeightKg: number;
  goalWeightKg?: number;
  conditionTypes: string[];
  activityLevel: string;
  goalType: GoalType;
  mealFrequency?: string;
  barriers?: string[];
};

export const genderOptions = ['male', 'female'] as const;

export const activityOptions = [
  ['sedentary', 'Sedentary'],
  ['light', 'Lightly active'],
  ['moderate', 'Moderately active'],
  ['active', 'Very active'],
  ['very_active', 'Extremely active'],
] as const;

export const conditions = [
  ['hypertension', 'High blood pressure'],
  ['diabetes', 'Diabetes'],
  ['heart_disease', 'Heart disease'],
  ['kidney_disease', 'Kidney disease'],
  ['thyroid', 'Thyroid disorder'],
  ['high_cholesterol', 'High cholesterol'],
] as const;

export function createOnboardingApi(api: ApiClient) {
  return {
    draft: () => api.request<{ draftData: Partial<OnboardingData> }>('onboarding/me'),
    preview: (input: OnboardingData) => api.request<{ nutritionPlan?: { targetCalories: number }; targetCalories?: number }>(
      'onboarding/preview-nutrition', { method: 'POST', body: {
        gender: input.gender, age: input.age, heightCm: input.heightCm,
        currentWeightKg: input.currentWeightKg, goalWeightKg: input.goalWeightKg,
        activityLevel: input.activityLevel, goalType: input.goalType, conditionTypes: input.conditionTypes,
      } },
    ),
    async save({ conditionTypes, goalType, activityLevel, mealFrequency, barriers, ...basic }: OnboardingData) {
      await api.request('onboarding/basic-info', { method: 'PATCH', body: basic });
      await api.request('onboarding/health-profile', { method: 'PATCH', body: { conditionTypes } });
      await api.request('onboarding/goal-preferences', {
        method: 'PATCH', body: { goalType, activityLevel, mealFrequency, barriers },
      });
      await api.request('onboarding/complete', { method: 'POST', body: {} });
    },
  };
}
