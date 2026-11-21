import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { useState } from 'react';
import { Action, Body, Card, Field, Loading, Message, Screen } from '../components/ui';
import { useSession } from '../features/account/session';
import { refreshDiaryViews } from '../features/diary/api';
import { createWaterApi } from '../features/water/api';
import { localDateKey, nextDate } from '../lib/local-date';

export default function Water() {
  const { api } = useSession();
  const client = useQueryClient();
  const service = createWaterApi(api);
  const date = localDateKey(new Date());
  const mealWater = useQuery({ queryKey: ['water', date], queryFn: service.today });
  const history = useQuery({ queryKey: ['water', 'history', date], queryFn: () => service.history(nextDate(date, -6), date) });
  const [amount, setAmount] = useState('');
  const value = Number(amount);
  const valid = amount.trim().length > 0 && Number.isInteger(value) && value >= 0;
  const save = useMutation({
    mutationFn: ({ action, volume }: { action: 'add' | 'set'; volume: number }) =>
      action === 'add' ? service.add(volume, date) : service.set(volume),
    onSuccess: async () => {
      setAmount('');
      await Promise.all([client.invalidateQueries({ queryKey: ['water'] }), refreshDiaryViews(client, date)]);
    },
  });

  return (
    <Screen title="Water">
      {mealWater.isPending && <Loading />}
      <Message error={mealWater.error} retry={() => void mealWater.refetch()} />
      {mealWater.data && <Card><Body>{mealWater.data.amountMl} / {mealWater.data.targetMl} ml today</Body></Card>}
      <Action title="Add 250 ml" disabled={save.isPending} onPress={() => save.mutate({ action: 'add', volume: 250 })} />
      <Field label="Water (ml)" value={amount} onChangeText={setAmount} keyboardType="number-pad" />
      <Action title="Add amount" disabled={!valid || value === 0 || save.isPending} onPress={() => save.mutate({ action: 'add', volume: value })} />
      <Action title="Set today's total" disabled={!valid || save.isPending} onPress={() => save.mutate({ action: 'set', volume: value })} />
      <Message error={save.error} />
      <Card>
        <Body>Last 7 days</Body>
        {history.isPending && <Loading />}
        {history.data?.length === 0 && <Body>No water logged.</Body>}
        {history.data?.map((item) => <Body key={item.date}>{item.date} · {item.amountMl} ml</Body>)}
        <Message error={history.error} retry={() => void history.refetch()} />
      </Card>
    </Screen>
  );
}
