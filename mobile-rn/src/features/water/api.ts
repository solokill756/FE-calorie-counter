import type { ApiClient } from '../../lib/api-client';

type WaterLog = { date: string; amountMl: number; targetMl: number };

export function createWaterApi(api: ApiClient) {
  return {
    today: () => api.request<WaterLog>('api/water-log/today'),
    history: (from: string, to: string) => api.request<WaterLog[]>('api/water-log/history', { query: { from, to } }),
    add: (amountMl: number, date: string) => api.request('api/water-log/add', { method: 'POST', body: { amountMl, date } }),
    set: (amountMl: number) => api.request('api/water-log/today', { method: 'PUT', body: { amountMl } }),
  };
}
