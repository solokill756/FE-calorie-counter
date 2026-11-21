import { useInfiniteQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { Alert } from 'react-native';
import { Action, Body, Card, Loading, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { refreshDiaryViews } from '../../features/diary/api';
import { createExerciseApi } from '../../features/exercise/api';
import { localDateKey } from '../../lib/local-date';

export default function WorkoutHistory() {
  const { api } = useSession();
  const client = useQueryClient();
  const service = createExerciseApi(api);
  const history = useInfiniteQuery({
    queryKey: ['exercise-logs'], initialPageParam: 1,
    queryFn: ({ pageParam }) => service.logs(pageParam),
    getNextPageParam: (page, pages) => page.items.length === 20 && pages.length * 20 < page.total ? pages.length + 1 : undefined,
  });
  const remove = useMutation({
    mutationFn: ({ id }: { id: number; date: string }) => service.removeLog(id),
    onSuccess: (_, { date }) => Promise.all([
      client.invalidateQueries({ queryKey: ['exercise-logs'] }), refreshDiaryViews(client, date),
    ]),
  });
  const items = history.data?.pages.flatMap((page) => page.items) ?? [];
  return (
    <Screen title="Workout history">
      {history.isPending && <Loading />}
      {history.isSuccess && items.length === 0 && <Body>No workouts logged.</Body>}
      <Message error={history.error} retry={() => void history.refetch()} />
      <Message error={remove.error} />
      {items.map((item) => {
        const date = localDateKey(new Date(item.startedAt));
        return <Card key={item.id}>
          <Body>{item.exerciseName} · {date}</Body>
          <Body>{item.minutesPerformed} min · {item.caloriesBurned} kcal</Body>
          <Action title="Remove workout" disabled={remove.isPending} onPress={() => {
            Alert.alert('Remove this workout?', item.exerciseName, [
              { text: 'Cancel', style: 'cancel' },
              { text: 'Remove', style: 'destructive', onPress: () => remove.mutate({ id: item.id, date }) },
            ]);
          }} />
        </Card>;
      })}
      {history.hasNextPage && <Action title="Load more" disabled={history.isFetchingNextPage} onPress={() => void history.fetchNextPage()} />}
    </Screen>
  );
}
