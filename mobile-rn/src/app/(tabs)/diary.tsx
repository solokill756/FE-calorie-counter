import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { router } from 'expo-router';
import { useState } from 'react';
import { Alert, StyleSheet, View } from 'react-native';
import { Action, Body, Card, Field, Loading, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { createDiaryApi, entriesForMeal, entryName, mealLabels, meals, refreshDiaryViews } from '../../features/diary/api';
import { localDateKey, nextDate, parseLocalDate } from '../../lib/local-date';

export default function Diary() {
  const { api } = useSession();
  const client = useQueryClient();
  const diary = createDiaryApi(api);
  const [date, setDate] = useState(() => localDateKey(new Date()));
  const { data, error, isPending, refetch } = useQuery({
    queryKey: ['diary', date], queryFn: () => diary.getDiary(date),
  });
  const remove = useMutation({
    mutationFn: ({ id }: { id: number; dateKey: string }) => diary.removeEntry(id),
    onSuccess: (_, { dateKey }) => refreshDiaryViews(client, dateKey),
  });

  const update = useMutation({
    mutationFn: ({ dateKey, note }: { dateKey: string; note?: string }) => {
      const day = parseLocalDate(dateKey);
      if (!day) throw new Error('Choose a valid diary date.');
      return note === undefined ? diary.complete(day) : diary.updateNote(day, note.trim() || null);
    },
    onSuccess: (_, { dateKey }) => refreshDiaryViews(client, dateKey),
  });

  function confirmRemoval(id: number, name: string) {
    Alert.alert('Remove food?', name, [
      { text: 'Cancel', style: 'cancel' },
      { text: 'Remove', style: 'destructive', onPress: () => remove.mutate({ id, dateKey: date }) },
    ]);
  }

  return (
    <Screen title="Diary">
      <View style={styles.dates}>
        <Action title="Previous" onPress={() => setDate(nextDate(date, -1))} />
        <Body>{date}</Body>
        <Action title="Next" onPress={() => setDate(nextDate(date, 1))} />
      </View>
      {isPending && <Loading />}
      <Message error={error} retry={() => void refetch()} />
      <Message error={remove.error ?? update.error} />
      {data && <>
        <Body>{data.totalCalories} kcal logged</Body>
        {meals.map((meal) => {
          const entries = entriesForMeal(data, meal);
          return (
            <Card key={meal}>
              <Body>{mealLabels[meal]}</Body>
              {entries.length === 0 && <Body>No foods logged.</Body>}
              {entries.map((entry) => (
                <View key={entry.id} style={styles.entry}>
                  <Body>{entryName(entry)} · {entry.calories ?? 0} kcal</Body>
                  <Action title="Remove" disabled={remove.isPending}
                    onPress={() => confirmRemoval(entry.id, entryName(entry))} />
                </View>
              ))}
              <Action title={`Add to ${mealLabels[meal].toLowerCase()}`} onPress={() => router.push({
                pathname: '/food/search', params: { date, meal },
              })} />
            </Card>
          );
        })}
        <Card>
          <Body>Water · {data.waterLog?.amountMl ?? 0} ml</Body>
          <Action title="Open water log" onPress={() => router.push('/water')} />
        </Card>
        <Card>
          <Body>Exercise</Body>
          {!data.exercises?.length && <Body>No workout logged.</Body>}
          {data.exercises?.map((item) => <Body key={item.id}>
            {item.name} · {item.duration} min · {item.caloriesBurned} kcal
          </Body>)}
          <Action title="Open exercise log" onPress={() => router.push('/exercise')} />
        </Card>
        <DiaryNote key={date} initial={data.note ?? ''} disabled={Boolean(data.isCompleted) || update.isPending}
          save={(note) => update.mutate({ dateKey: date, note })} />
        <Action title={data.isCompleted ? 'Diary completed' : 'Complete diary'}
          disabled={Boolean(data.isCompleted) || update.isPending} onPress={() => update.mutate({ dateKey: date })} />
      </>}
    </Screen>
  );
}

function DiaryNote({ initial, disabled, save }: { initial: string; disabled: boolean; save(note: string): void }) {
  const [note, setNote] = useState(initial);
  return (
    <Card>
      <Field label="Notes" value={note} onChangeText={setNote} editable={!disabled} multiline />
      <Action title="Save note" disabled={disabled || note.trim() === initial} onPress={() => save(note)} />
    </Card>
  );
}

const styles = StyleSheet.create({
  dates: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', gap: 8 },
  entry: { gap: 6, alignItems: 'flex-start' },
});
