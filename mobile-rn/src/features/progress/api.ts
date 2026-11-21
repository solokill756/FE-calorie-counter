import type { ApiClient } from '../../lib/api-client';

export type WeightEntry = { id: number; recordedAt: string; weightKg: number; photoUrl?: string | null };

export function weightChart(entries: WeightEntry[]) {
  if (!entries.length) return [];
  const ordered = [...entries].sort((a, b) => a.recordedAt.localeCompare(b.recordedAt));
  const values = ordered.map((item) => item.weightKg);
  const minimum = Math.min(...values);
  const maximum = Math.max(...values);
  return ordered.map((entry) => ({
    ...entry,
    relativeHeight: maximum === minimum ? 0.5 : 0.2 + 0.8 * (entry.weightKg - minimum) / (maximum - minimum),
  }));
}

export function createProgressApi(api: ApiClient) {
  return {
    list: (page: number) => api.request<{ items: WeightEntry[]; total: number }>('api/Weight', {
      query: { page, pageSize: 30 },
    }),
    save: (body: Omit<WeightEntry, 'id'>, id?: number) => api.request<WeightEntry>(
      id ? `api/Weight/${id}` : 'api/Weight', { method: id ? 'PUT' : 'POST', body },
    ),
    trends: (from: string, to: string) => api.request<{
      summary: { adherenceScore: number; currentStreak: number; bestStreak: number };
    }>('api/progress/trends', { query: { from, to } }),

  };
}
