import { ApiError, type ApiClient, type Session, type SessionStore } from '../../lib/api-client';

export type UserProfile = {
  id: number;
  email?: string;
  displayName: string;
  isProfileComplete: boolean;
  avatarUrl?: string | null;
  goalType?: string;
  age?: number | null;
  heightCm?: number | null;
  currentWeightKg?: number | null;
  goalWeightKg?: number | null;
  activityLevel?: string | null;
  conditionTypes?: string[];
  nutritionalThresholds?: { nutrient: string; minAmount?: number | null; maxAmount?: number | null; unit?: string }[];
  nutritionTargets?: {
    targetCalories: number;
    proteinG: number;
    carbsG: number;
    fatG: number;
  } | null;
};

type Credentials = { email: string; password: string };
type LoginResponse = Session & { user: UserProfile };

export function initialDestination(profile: UserProfile | null | undefined) {
  if (profile === undefined) return 'loading';
  if (profile === null) return 'sign-in';
  return profile.isProfileComplete ? 'tabs' : 'onboarding';
}

export async function restoreProfile(api: ApiClient, read: SessionStore['read']) {
  if (!(await read())) return null;

  try {
    return await api.request<UserProfile>('auth/me');
  } catch (error) {
    if (error instanceof ApiError && [401, 403].includes(error.status) && !(await read())) {
      return null;
    }
    throw error;
  }
}

export function createAccountApi(api: ApiClient, store: SessionStore, isCurrent?: () => boolean) {
  async function saveLogin(response: LoginResponse) {
    const { accessToken, refreshToken, user } = response;
    await store.write({ accessToken, refreshToken });
    if (!user.isProfileComplete) return user;

    try {
      const profile = await restoreProfile(api, store.read);
      if (profile) return profile;
    } catch (error) {
      if (!(error instanceof ApiError) || error.status >= 500) return user;
      throw error;
    }
    throw new ApiError(401, 'The signed-in session could not be restored.');
  }

  return {
    async register(credentials: Credentials, displayName: string) {
      return saveLogin(await api.request<LoginResponse>('auth/register', {
        method: 'POST', public: true,
        body: { ...credentials, email: credentials.email.trim(), displayName: displayName.trim() || undefined },
      }));
    },
    forgot: (email: string) => api.request<{ success: boolean; resetToken?: string }>('auth/forgot-password', {
      method: 'POST', public: true, body: { email: email.trim() },
    }),
    reset: (token: string, newPassword: string) => api.request<{ success: boolean }>('auth/reset-password', {
      method: 'POST', public: true, body: { token: token.trim(), newPassword },
    }),
    async socialSignIn(provider: 'apple' | 'google', idToken: string) {
      return saveLogin(await api.request<LoginResponse>(`auth/oauth/${provider}`, {
        method: 'POST', public: true, body: { idToken, deviceInfo: `mobile-${provider}` },
      }));
    },
    async deleteAccount() {
      await api.request('users/me', { method: 'DELETE' });
      await store.clear(isCurrent);
    },
    async signIn(credentials: Credentials) {
      return saveLogin(await api.request<LoginResponse>('auth/login', {
        method: 'POST',
        public: true,
        body: { email: credentials.email.trim(), password: credentials.password },
      }));
    },
    async signOut() {
      try {
        await api.request('auth/logout-all', { method: 'POST' });
      } finally {
        await store.clear(isCurrent);
      }
    },
    restore: () => restoreProfile(api, store.read),
  };
}
