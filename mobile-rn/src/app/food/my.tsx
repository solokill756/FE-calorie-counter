import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { useState } from 'react';
import { Alert } from 'react-native';
import { Action, Body, Card, Field, Loading, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { createFoodApi, type FoodDetails } from '../../features/food/api';
import { nutrientFields } from '../../features/nutrition/fields';

export default function MyFoods() {
  const { api } = useSession();
  const client = useQueryClient();
  const service = createFoodApi(api);
  const foods = useQuery({ queryKey: ['foods', 'mine'], queryFn: service.listMyFoods });
  const [editing, setEditing] = useState<FoodDetails | 'new'>();
  const remove = useMutation({
    mutationFn: service.deleteFood,
    onSuccess: () => client.invalidateQueries({ queryKey: ['foods'] }),
  });
  return (
    <Screen title="My foods">
      <Action title="Create food" onPress={() => setEditing('new')} />
      {editing && <FoodForm key={editing === 'new' ? 'new' : editing.id}
        value={editing === 'new' ? undefined : editing} close={() => setEditing(undefined)} />}
      {foods.isPending && <Loading />}
      {foods.data?.items.length === 0 && <Body>No saved foods.</Body>}
      <Message error={foods.error} retry={() => void foods.refetch()} />
      <Message error={remove.error} />
      {foods.data?.items.map((food) => (
        <Card key={food.id}>
          <Body>{food.description} · {food.calories ?? 0} kcal</Body>
          <Action title="Edit food" onPress={() => setEditing(food)} />
          <Action title="Delete food" disabled={remove.isPending} onPress={() => {
            Alert.alert('Delete food?', food.description, [
              { text: 'Cancel', style: 'cancel' },
              { text: 'Delete', style: 'destructive', onPress: () => remove.mutate(food.id) },
            ]);
          }} />
        </Card>
      ))}
    </Screen>
  );
}

function FoodForm({ value, close }: { value?: FoodDetails; close(): void }) {
  const { api } = useSession();
  const client = useQueryClient();
  const [draft, setDraft] = useState<Record<string, string>>(() => {
    const record: Record<string, string> = {
      description: value?.description ?? '', brandName: value?.brandName ?? '',
      servingSize: String(value?.servingSize ?? '1'), servingUnit: value?.servingUnit ?? 'serving',
      servingsPerContainer: String(value?.servingsPerContainer ?? '1'),
    };
    for (const [key] of nutrientFields) record[key] = value?.[key] == null ? '' : String(value[key]);
    return record;
  });
  const number = (key: string) => Number(draft[key].trim().replace(',', '.'));
  const set = (key: string) => (text: string) => setDraft((current) => ({ ...current, [key]: text }));
  const valid = draft.description.trim() && draft.servingUnit.trim() &&
    number('servingSize') > 0 && number('servingsPerContainer') > 0 &&
    nutrientFields.every(([key]) => Number.isFinite(number(key)) && number(key) >= 0);
  const save = useMutation({
    mutationFn: () => createFoodApi(api).saveFood({
      description: draft.description.trim(), category: value?.category ?? draft.description.trim(),
      brandName: draft.brandName.trim(), servingUnit: draft.servingUnit.trim(), servingSize: number('servingSize'),
      servingsPerContainer: number('servingsPerContainer'),
      ...Object.fromEntries(nutrientFields.map(([name]) => [name, number(name)])),
    }, value?.id),
    onSuccess: async () => {
      await client.invalidateQueries({ queryKey: ['foods'] });
      close();
    },
  });
  return (
    <Card>
      <Field label="Food name" value={draft.description} onChangeText={set('description')} />
      <Field label="Brand" value={draft.brandName} onChangeText={set('brandName')} />
      <Field label="Serving size" value={draft.servingSize} onChangeText={set('servingSize')} keyboardType="decimal-pad" />
      <Field label="Serving unit" value={draft.servingUnit} onChangeText={set('servingUnit')} />
      <Field label="Servings per container" value={draft.servingsPerContainer}
        onChangeText={set('servingsPerContainer')} keyboardType="decimal-pad" />
      {nutrientFields.map(([key, , label, unit]) => <Field key={key} label={`${label} (${unit})`}
        value={draft[key]} onChangeText={set(key)} keyboardType="decimal-pad" />)}
      <Message error={save.error} />
      <Action title="Save food" disabled={!valid || save.isPending} onPress={() => save.mutate()} />
      <Action title="Cancel" disabled={save.isPending} onPress={close} />
    </Card>
  );
}
