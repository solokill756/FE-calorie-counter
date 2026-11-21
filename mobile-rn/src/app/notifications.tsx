import { useInfiniteQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { router } from 'expo-router';
import { Action, Body, Card, Loading, Message, Screen } from '../components/ui';
import { useSession } from '../features/account/session';
import { createNotificationsApi } from '../features/notifications/api';

export default function NotificationsScreen() {
  const { api } = useSession();
  const client = useQueryClient();
  const service = createNotificationsApi(api);
  const notices = useInfiniteQuery({
    queryKey: ['notifications', 'list'],
    initialPageParam: undefined as number | undefined,
    queryFn: ({ pageParam }) => service.list(pageParam),
    getNextPageParam: (last) => last.hasMore ? last.items.at(-1)?.id : undefined,
  });
  const read = useMutation({
    mutationFn: async ({ id, unread }: { id: number; unread: boolean; type: string }) => {
      if (unread) await service.markRead(id);
    },
    onSuccess: async (_, { type }) => {
      await client.invalidateQueries({ queryKey: ['notifications'] });
      if (type === 'threshold_adjusted') router.push('/nutrition');
    },
  });
  const rows = notices.data?.pages.flatMap((page) => page.items) ?? [];
  return (
    <Screen title="Notifications">
      {notices.isPending && <Loading />}
      <Message error={notices.error ?? read.error} retry={() => void notices.refetch()} />
      {notices.isSuccess && rows.length === 0 && <Body>No notifications.</Body>}
      {rows.map((item) => <Card key={item.id}>
        <Body>{!item.readAt ? 'New · ' : ''}{item.title}</Body>
        <Body>{item.body}</Body>
        <Body>{new Date(item.createdAt).toLocaleString()}</Body>
        {(!item.readAt || item.type === 'threshold_adjusted') && <Action
          title={item.type === 'threshold_adjusted' ? 'Open nutrition' : 'Mark as read'}
          disabled={read.isPending} onPress={() => read.mutate({ id: item.id, unread: !item.readAt, type: item.type })} />}
      </Card>)}
      {notices.hasNextPage && <Action title="Load more" disabled={notices.isFetchingNextPage} onPress={() => void notices.fetchNextPage()} />}
    </Screen>
  );
}
