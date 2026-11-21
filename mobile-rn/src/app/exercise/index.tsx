import { useInfiniteQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { router } from 'expo-router';
import { useState } from 'react';
import { Alert } from 'react-native';
import { Action, Body, Card, Field, Loading, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { refreshDiaryViews } from '../../features/diary/api';
import { createExerciseApi, type Exercise } from '../../features/exercise/api';
import { localDateKey, parseLocalDate } from '../../lib/local-date';

export default function ExerciseCatalog() {
  const { api } = useSession();
  const client = useQueryClient();
  const service = createExerciseApi(api);
  const [text, setText] = useState('');
  const [query, setQuery] = useState('');
  const [mine, setMine] = useState(false);
  const [selection, setSelection] = useState<Exercise>();
  const [date, setDate] = useState(() => localDateKey(new Date()));
  const [minutes, setMinutes] = useState('');
  const [editing, setEditing] = useState<Exercise | 'new'>();
  const listing = useInfiniteQuery({
    queryKey: ['exercises', query, mine], initialPageParam: 1,
    queryFn: ({ pageParam }) => service.list(query, pageParam, mine),
    getNextPageParam: (page, pages) => page.items.length === 20 && pages.length * 20 < page.total ? pages.length + 1 : undefined,
  });
  const remove = useMutation({
    mutationFn: service.deleteExercise,
    onSuccess: () => client.invalidateQueries({ queryKey: ['exercises'] }),
  });
  const log = useMutation({
    mutationFn: ({ id, duration, when }: { id: number; duration: number; when: Date }) =>
      service.addLog(id, duration, when.toISOString()),
    onSuccess: async (_, { when }) => {
      await Promise.all([client.invalidateQueries({ queryKey: ['exercise-logs'] }),
        refreshDiaryViews(client, localDateKey(when))]);
      setSelection(undefined);
      setMinutes('');
    },
  });
  const when = parseLocalDate(date);
  const duration = Number(minutes.trim().replace(',', '.'));
  const entries = listing.data?.pages.flatMap((page) => page.items) ?? [];

  return (
    <Screen title="Exercise">
      <Action title="Workout history" onPress={() => router.push('/exercise/history')} />
      <Action title="Create exercise" onPress={() => setEditing('new')} />
      {editing && <ExerciseEditor key={editing === 'new' ? 'new' : editing.id}
        exercise={editing === 'new' ? undefined : editing} close={() => setEditing(undefined)} />}
      {selection && <Card>
        <Body>{selection.name}</Body>
        <Field label="Date (YYYY-MM-DD)" value={date} onChangeText={setDate} />
        <Field label="Minutes" value={minutes} onChangeText={setMinutes} keyboardType="decimal-pad" />
        <Action title="Log workout" disabled={!when || !Number.isFinite(duration) || duration <= 0 || log.isPending}
          onPress={() => { if (when) log.mutate({ id: selection.id, duration, when }); }} />
        <Action title="Cancel" onPress={() => setSelection(undefined)} />
        <Message error={log.error} />
      </Card>}
      <Field label="Search exercises" value={text} onChangeText={setText} onSubmitEditing={() => setQuery(text.trim())} />
      <Action title="Search" onPress={() => setQuery(text.trim())} />
      <Action title={mine ? 'Show all exercises' : 'Show my exercises'} onPress={() => setMine(!mine)} />
      {listing.isPending && <Loading />}
      {listing.isSuccess && entries.length === 0 && <Body>No exercises found.</Body>}
      <Message error={listing.error} retry={() => void listing.refetch()} />
      <Message error={remove.error} />
      {entries.map((entry) => <Card key={entry.id}>
        <Body>{entry.name} · {entry.type}</Body>
        {entry.notes && <Body>{entry.notes}</Body>}
        <Action title="Log workout" onPress={() => setSelection(entry)} />
        {entry.isOwned && <>
          <Action title="Edit exercise" onPress={() => setEditing(entry)} />
          <Action title="Delete exercise" disabled={remove.isPending} onPress={() => {
            Alert.alert('Delete exercise?', entry.name, [
              { text: 'Cancel', style: 'cancel' },
              { text: 'Delete', style: 'destructive', onPress: () => remove.mutate(entry.id) },
            ]);
          }} />
        </>}
      </Card>)}
      {listing.hasNextPage && <Action title="Load more" disabled={listing.isFetchingNextPage} onPress={() => void listing.fetchNextPage()} />}
    </Screen>
  );
}

function ExerciseEditor({ exercise, close }: { exercise?: Exercise; close(): void }) {
  const { api } = useSession();
  const client = useQueryClient();
  const [name, setName] = useState(exercise?.name ?? '');
  const [type, setType] = useState(exercise?.type ?? 'cardio');
  const [notes, setNotes] = useState(exercise?.notes ?? '');
  const [met, setMet] = useState(exercise?.met == null ? '' : String(exercise.met));
  const [rate, setRate] = useState(exercise?.defaultCalPerMin == null ? '' : String(exercise.defaultCalPerMin));
  const parse = (value: string) => value.trim() ? Number(value.replace(',', '.')) : undefined;
  const valid = [parse(met), parse(rate)].every((value) => value === undefined || (Number.isFinite(value) && value > 0));
  const save = useMutation({
    mutationFn: () => createExerciseApi(api).save({
      name: name.trim(), type, notes, met: parse(met), defaultCalPerMin: parse(rate),
    }, exercise?.id),
    onSuccess: async () => {
      await client.invalidateQueries({ queryKey: ['exercises'] });
      close();
    },
  });
  return (
    <Card>
      <Field label="Exercise name" value={name} onChangeText={setName} />
      <Action title={type === 'cardio' ? '✓ Cardio' : 'Cardio'} onPress={() => setType('cardio')} />
      <Action title={type === 'strength' ? '✓ Strength' : 'Strength'} onPress={() => setType('strength')} />
      <Field label="MET" value={met} onChangeText={setMet} keyboardType="decimal-pad" />
      <Field label="Calories per minute" value={rate} onChangeText={setRate} keyboardType="decimal-pad" />
      <Field label="Notes" value={notes} onChangeText={setNotes} multiline />
      <Message error={save.error} />
      <Action title="Save exercise" disabled={!name.trim() || !valid || save.isPending} onPress={() => save.mutate()} />
      <Action title="Cancel" onPress={close} />
    </Card>
  );
}
