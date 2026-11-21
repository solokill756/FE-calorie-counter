import AsyncStorage from '@react-native-async-storage/async-storage';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { randomUUID } from 'expo-crypto';
import { router } from 'expo-router';
import { useState } from 'react';
import { AppState, Switch } from 'react-native';
import { Action, Body, Card, Field, Loading, Message, Screen } from '../components/ui';
import { useSession } from '../features/account/session';
import { createDiaryApi } from '../features/diary/api';
import { notifyRecipeStatus } from '../features/notifications/native';
import { createRecipeApi } from '../features/recipes/api';
import { localDateKey } from '../lib/local-date';

export default function Pantry() {
  const { api, profile } = useSession();
  const client = useQueryClient();
  const service = createRecipeApi(api);
  const [search, setSearch] = useState('');
  const [query, setQuery] = useState('');
  const prefs = `calorie-counter.auto-create-plan.${profile?.id}`;
  const setting = useQuery({ queryKey: ['pantry-preference', prefs], queryFn: async () => (await AsyncStorage.getItem(prefs)) === 'true' });
  const updateSetting = useMutation({
    mutationFn: (value: boolean) => AsyncStorage.setItem(prefs, String(value)),
    onSuccess: (_, value) => client.setQueryData(['pantry-preference', prefs], value),
  });
  const list = useQuery({ queryKey: ['pantry'], queryFn: service.staples });
  const quota = useQuery({
    queryKey: ['fridge-quota'], queryFn: service.quota,
    refetchInterval: (query) => query.state.data?.inProgress ? 5_000 : false,
  });
  const candidates = useQuery({
    queryKey: ['foods', 'pantry', query], enabled: Boolean(query),
    queryFn: () => createDiaryApi(api).searchFoods(query, 1),
  });
  const change = useMutation({
    mutationFn: ({ action, id }: { action: 'add' | 'remove'; id: number }) =>
      action === 'add' ? service.addStaple(id) : service.removeStaple(id),
    onSuccess: () => client.invalidateQueries({ queryKey: ['pantry'] }),
  });
  const plan = useMutation({
    mutationFn: ({ date }: { date: string; jobId: string }) => service.plan(date),
    onSuccess: async (_, { jobId }) => {
      if (profile && AppState.currentState !== 'active') {
        await notifyRecipeStatus({
          ownerId: profile.id, kind: 'pantry', jobId, title: 'Meal plan ready', body: 'Open your pantry to see today’s plan.',
        }).catch(() => undefined);
      }
    },
    onSettled: () => Promise.all([
      client.invalidateQueries({ queryKey: ['fridge-quota'] }),
      client.invalidateQueries({ queryKey: ['recipes'] }),
    ]),
  });

  return (
    <Screen title="Pantry">
      <Field label="Find pantry foods" value={search} onChangeText={setSearch} onSubmitEditing={() => setQuery(search.trim())} />
      <Action title="Search" onPress={() => setQuery(search.trim())} />
      {candidates.isFetching && <Loading />}
      {candidates.data?.items.map((food) => {
        const inPantry = list.data?.some((item) => item.id === food.id);
        return <Action key={food.id} title={inPantry ? `${food.description} is in your pantry` : `Add ${food.description}`}
          disabled={Boolean(inPantry) || change.isPending} onPress={() => change.mutate({ action: 'add', id: food.id })} />;
      })}
      <Message error={list.error ?? candidates.error ?? change.error} />
      {list.isPending && <Loading />}
      <Card>
        <Body>Your staples</Body>
        {list.data?.length === 0 && <Body>No staples added.</Body>}
        {list.data?.map((food) => <Action key={food.id} title={`Remove ${food.description}`}
          disabled={change.isPending} onPress={() => change.mutate({ action: 'remove', id: food.id })} />)}
      </Card>
      <Card>
        <Body>Auto create plan recipes</Body>
        <Switch accessibilityLabel="Auto create plan recipes" value={setting.data ?? false} disabled={updateSetting.isPending}
          onValueChange={(value) => updateSetting.mutate(value)} />
        <Message error={setting.error ?? updateSetting.error} />
      </Card>
      {!setting.data && <Action title={plan.isPending || quota.data?.inProgress ? 'Generating…' : 'Generate today’s plan'}
        disabled={plan.isPending || quota.data?.inProgress || !list.data?.length} onPress={() => plan.mutate({ date: localDateKey(new Date()), jobId: randomUUID() })} />}
      {plan.data?.slots.map((slot) => <Body key={slot.mealSlot}>
        {slot.mealSlot} · {slot.status}{slot.reason ? ` · ${slot.reason}` : ''}
      </Body>)}
      <Message error={plan.error ?? quota.error} />
      <Action title="View recipes" onPress={() => router.navigate('/recipes')} />
    </Screen>
  );
}
