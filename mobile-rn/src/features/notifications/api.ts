import type { ApiClient } from '../../lib/api-client';

type Notice = { id: number; title: string; body: string; type: string; readAt?: string | null; createdAt: string };
type NoticeResponse<T> = { data: T };

export function createNotificationsApi(api: ApiClient) {
  return {
    list: async (beforeId?: number) =>
      (await api.request<NoticeResponse<{ items: Notice[]; hasMore: boolean }>>('api/notifications', {
        query: { limit: 30, beforeId },
      })).data,
    count: async () => (await api.request<NoticeResponse<{ count: number }>>('api/notifications/unread-count')).data.count,
    markRead: (id: number) => api.request<void>(`api/notifications/${id}/read`, { method: 'PATCH' }),
  };
}
