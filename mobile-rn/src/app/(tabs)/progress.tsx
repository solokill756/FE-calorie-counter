import { useInfiniteQuery, useQuery } from '@tanstack/react-query';
import { router } from 'expo-router';
import { StyleSheet, View } from 'react-native';
import { Action, Body, Card, colors, Loading, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { createProgressApi, weightChart } from '../../features/progress/api';
import { localDateKey, nextDate } from '../../lib/local-date';

export default function Progress() {
  const { api } = useSession();
  const service = createProgressApi(api);
  const today = localDateKey(new Date());
  const weights = useInfiniteQuery({
    queryKey: ['progress', 'weights'],
    initialPageParam: 1,
    queryFn: ({ pageParam }) => service.list(pageParam),
    getNextPageParam: (page, pages) => page.items.length === 30 && pages.length * 30 < page.total ? pages.length + 1 : undefined,
  });
  const trends = useQuery({ queryKey: ['progress', 'trends', today], queryFn: () => service.trends(nextDate(today, -29), today) });
  const all = weights.data?.pages.flatMap((page) => page.items) ?? [];
  const points = weightChart(all.slice(0, 20));

  return (
    <Screen title="Progress">
      <Action title="Record weight" onPress={() => router.push('/weight/form')} />
      {trends.data?.summary && <Card>
        <Body>Current streak · {trends.data.summary.currentStreak} days</Body>
        <Body>Best streak · {trends.data.summary.bestStreak} days</Body>
      </Card>}
      <Message error={trends.error} retry={() => void trends.refetch()} />
      {weights.isPending && <Loading />}
      <Message error={weights.error} retry={() => void weights.refetch()} />
      {weights.isSuccess && points.length === 0 && <Body>No weights recorded.</Body>}
      {points.length > 0 && <Card>
        <Body>Recent weight trend</Body>
        <View style={styles.chart} accessibilityLabel={points.map((item) =>
          `${localDateKey(new Date(item.recordedAt))}: ${item.weightKg} kg`).join(', ')}>
          {points.map((point) => <View key={point.id} style={[styles.bar, { height: 98 * point.relativeHeight }]} />)}
        </View>
        <Body>{points[0].weightKg} kg → {points[points.length - 1].weightKg} kg</Body>
      </Card>}
      {all.map((item) => <Card key={item.id}>
        <Body>{localDateKey(new Date(item.recordedAt))} · {item.weightKg} kg</Body>
        <Action title="Edit entry" onPress={() => router.push({ pathname: '/weight/form', params: { id: String(item.id) } })} />
      </Card>)}
      {weights.hasNextPage && <Action title="Load more" disabled={weights.isFetchingNextPage} onPress={() => void weights.fetchNextPage()} />}
    </Screen>
  );
}

const styles = StyleSheet.create({
  chart: { height: 100, flexDirection: 'row', gap: 4, alignItems: 'flex-end' },
  bar: { flex: 1, maxWidth: 24, backgroundColor: colors.action, borderTopLeftRadius: 3, borderTopRightRadius: 3 },
});
