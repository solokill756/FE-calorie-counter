import type { ApiClient } from '../../lib/api-client';
import type { ExportLog } from './export';

type DiaryTotals = { date: string } & Partial<Record<string, string | number>>;

export function createNutritionApi(api: ApiClient) {
  return {
    day: (date: string) => api.request<DiaryTotals>(`api/Diary/${date}`),
    range: (from: string, to: string) => api.request<DiaryTotals[] | { items: DiaryTotals[] }>('api/Diary/range', { query: { from, to } }),
    async logs(startDate: string, endDate: string) {
      const result: ExportLog[] = [];
      const pageSize = 100;
      for (let page = 1; ; page += 1) {
        const { items, total } = await api.request<{ items: ExportLog[]; total?: number }>('api/LogFood', {
          query: { startDate, endDate, page, pageSize, includeQuickAdd: true },
        });
        result.push(...items);
        if (items.length < pageSize || (total !== undefined && result.length >= total)) return result;
      }
    },
  };
}
