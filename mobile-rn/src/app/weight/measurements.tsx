import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { useState } from 'react';
import { Action, Body, Card, Field, Loading, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { createProgressApi, measurements, type Measurement } from '../../features/progress/api';
import { localDateKey, parseLocalDate } from '../../lib/local-date';

export default function Measurements() {
  const { api } = useSession();
  const client = useQueryClient();
  const [type, setType] = useState<Measurement>(measurements[0]);
  const [date, setDate] = useState(() => localDateKey(new Date()));
  const [size, setSize] = useState('');
  const localDate = parseLocalDate(date);
  const value = Number(size.replace(',', '.'));
  const service = createProgressApi(api);
  const data = useQuery({ queryKey: ['progress', type[0]], queryFn: () => service.measurements(type) });
  const add = useMutation({
    mutationFn: ({ forType, timestamp }: { forType: Measurement; timestamp: string }) =>
      service.addMeasurement(forType, value, timestamp),
    onSuccess: async (_, { forType }) => {
      setSize('');
      await client.invalidateQueries({ queryKey: ['progress', forType[0]] });
    },
  });

  return (
    <Screen title="Measurements">
      {measurements.map((option) => <Action key={option[0]} onPress={() => setType(option)}
        title={type[0] === option[0] ? `✓ ${option[0]}` : option[0]} />)}
      <Field label="Date (YYYY-MM-DD)" value={date} onChangeText={setDate} />
      <Field label={`${type[0]} (cm)`} value={size} onChangeText={setSize} keyboardType="decimal-pad" />
      <Action title="Save measurement" disabled={!localDate || !Number.isFinite(value) || value <= 0 || add.isPending}
        onPress={() => { if (localDate) add.mutate({ forType: type, timestamp: localDate.toISOString() }); }} />
      {data.isPending && <Loading />}
      <Message error={data.error ?? add.error} />
      <Card>
        <Body>{type[0]} history</Body>
        {data.data?.items.length === 0 && <Body>No measurements logged.</Body>}
        {data.data?.items.map((item) => <Body key={item.id}>
          {localDateKey(new Date(item.recordedAt))} · {item[type[1]]} cm
        </Body>)}
      </Card>
    </Screen>
  );
}
