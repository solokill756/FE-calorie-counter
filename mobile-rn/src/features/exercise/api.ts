import type { ApiClient } from '../../lib/api-client';

export type Exercise = {
  id: number;
  name: string;
  type: 'cardio' | 'strength';
  met?: number | null;
  defaultCalPerMin?: number | null;
  notes?: string | null;
  isOwned?: boolean;
};
type ExerciseLog = {
  id: number; startedAt: string; exerciseName: string; minutesPerformed: number; caloriesBurned: number;
};
type Page<T> = { items: T[]; total: number };

export function createExerciseApi(api: ApiClient) {
  return {
    list: (query: string, page: number, mineOnly: boolean) => api.request<Page<Exercise>>('api/exercises', {
      query: { q: query || undefined, page, limit: 20, mineOnly: mineOnly || undefined },
    }),
    logs: (page: number) => api.request<Page<ExerciseLog>>('api/exercise-logs', { query: { page, limit: 20 } }),
    save: (body: Omit<Exercise, 'id'>, id?: number) =>
      api.request<Exercise>(id ? `api/exercises/${id}` : 'api/exercises', { method: id ? 'PATCH' : 'POST', body }),
    deleteExercise: (id: number) => api.request<void>(`api/exercises/${id}`, { method: 'DELETE' }),
    addLog: (exerciseId: number, minutesPerformed: number, startedAt: string) =>
      api.request('api/exercise-logs', { method: 'POST', body: { exerciseId, minutesPerformed, startedAt, source: 'manual' } }),
    removeLog: (id: number) => api.request<void>(`api/exercise-logs/${id}`, { method: 'DELETE' }),
  };
}
