import { useMutation, useQuery } from '@tanstack/react-query';
import { File, Paths } from 'expo-file-system';
import * as Sharing from 'expo-sharing';
import { useState } from 'react';
import { Action, Body, Card, Loading, Message, Screen } from '../components/ui';
import { useSession } from '../features/account/session';
import { createNutritionApi } from '../features/nutrition/api';
import { nutritionCsv } from '../features/nutrition/export';
import { nutrientFields } from '../features/nutrition/fields';
import { localDateKey, nextDate } from '../lib/local-date';

export default function Nutrition() {
  const { api, profile } = useSession();
  const service = createNutritionApi(api);
  const [end, setEnd] = useState(() => localDateKey(new Date()));
  const [week, setWeek] = useState(false);
  const start = week ? nextDate(end, -6) : end;
  const data = useQuery({
    queryKey: ['nutrition', start, end],
    queryFn: async () => {
      if (!week) return [await service.day(end)];
      const range = await service.range(start, end);
      return Array.isArray(range) ? range : range.items;
    },
  });
  const share = useMutation({
    mutationFn: async () => {
      const logs = await service.logs(start, end);
      if (!logs.length) throw new Error('There are no foods to export for this period.');
      if (!(await Sharing.isAvailableAsync())) throw new Error('File sharing is unavailable on this device.');
      const file = new File(Paths.cache, `nutrition-${start}-${end}-${Date.now()}.csv`);
      file.create();
      file.write(nutritionCsv(logs));
      await Sharing.shareAsync(file.uri, { mimeType: 'text/csv', dialogTitle: 'Nutrition export' });
    },
  });
  const targets = profile?.nutritionTargets;

  return (
    <Screen title="Nutrition">
      <Body>{week ? `${start} – ${end}` : end}</Body>
      <Action title={week ? 'Show day' : 'Show week'} onPress={() => setWeek(!week)} />
      <Action title="Previous period" onPress={() => setEnd(nextDate(end, week ? -7 : -1))} />
      <Action title="Next period" onPress={() => setEnd(nextDate(end, week ? 7 : 1))} />
      {targets && <Card>
        <Body>Daily targets · {targets.targetCalories} kcal</Body>
        <Body>Protein {targets.proteinG} g · Carbs {targets.carbsG} g · Fat {targets.fatG} g</Body>
      </Card>}
      {data.isPending && <Loading />}
      <Message error={data.error} retry={() => void data.refetch()} />
      {data.data?.length === 0 && <Body>No nutrition data for this period.</Body>}
      {!!data.data?.length && <Card>
        {nutrientFields.map(([, totalKey, label, unit]) => {
          const total = data.data.reduce((sum, day) => sum + (Number(day[totalKey]) || 0), 0);
          return <Body key={totalKey}>{label} · {Math.round(total * 100) / 100} {unit}</Body>;
        })}
      </Card>}
      <Action title={share.isPending ? 'Exporting…' : 'Export CSV'} disabled={share.isPending} onPress={() => share.mutate()} />
      <Message error={share.error} />
    </Screen>
  );
}
