import type { ApiClient } from '../../lib/api-client';
import type { MealSplits, UserProfile } from '../account/api';

export const goalOptions = [
  ['weight_loss', 'Lose weight'],
  ['maintenance', 'Maintain weight'],
  ['weight_gain', 'Gain weight'],
  ['muscle_gain', 'Gain muscle'],
  ['modify_diet', 'Modify my diet'],
  ['plan_meals', 'Plan meals'],
  ['manage_stress', 'Manage stress'],
  ['stay_active', 'Stay active'],
] as const;
export type GoalType = (typeof goalOptions)[number][0];

type ProfilePatch = {
  displayName?: string;
  email?: string;
  newPassword?: string;
  avatarUrl?: string;
};

export type HealthProfilePatch = {
  age?: number;
  gender?: string;
  heightCm?: number;
  conditionTypes?: string[];
  allergies?: string[];
  mealSplits?: MealSplits | null;
};

export function createProfileApi(api: ApiClient) {
  const updateProfile = (body: ProfilePatch) =>
    api.request<UserProfile>('users/profile', { method: 'PATCH', body });

  return {
    updateProfile,
    updateProfileWithPhoto: async (body: ProfilePatch, upload: () => Promise<string>) =>
      updateProfile({ ...body, avatarUrl: await upload() }),
    updateHealthProfile: (body: HealthProfilePatch) =>
      api.request<UserProfile>('users/health-profile', { method: 'PATCH', body }),
    updateGoal: (goalType: GoalType) =>
      api.request<UserProfile>('users/goal', { method: 'PATCH', body: { goalType } }),
  };
}
