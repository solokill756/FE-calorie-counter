import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import type { ImagePickerAsset } from 'expo-image-picker';
import { useState } from 'react';
import { Alert, Image } from 'react-native';
import { useLocalSearchParams, router } from 'expo-router';
import { Action, Body, Card, Field, Loading, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { createDiaryApi, meals, refreshDiaryViews } from '../../features/diary/api';
import { createFoodApi, scaledMealNutrients, type SavedMeal } from '../../features/food/api';
import { confirmNutritionLog } from '../../features/food/warning-dialog';
import { formatDisplayNumber } from '../../lib/format-display-number';
import { parseLocalDate } from '../../lib/local-date';
import { pickImage, uploadImage } from '../../lib/media-upload';

export default function SavedMeals() {
  const { api, profile } = useSession();
  const client = useQueryClient();
  const { date, meal } = useLocalSearchParams<{ date?: string; meal?: string }>();
  const slot = meals.find((value) => value === meal);
  const [editing, setEditing] = useState<SavedMeal | 'new'>();
  const [name, setName] = useState('');
  const [directions, setDirections] = useState('');
  const [image, setImage] = useState<ImagePickerAsset>();
  const [photoError, setPhotoError] = useState<unknown>();
  const [search, setSearch] = useState('');
  const [query, setQuery] = useState('');
  const [amount, setAmount] = useState('1');
  const [portions, setPortions] = useState('1');
  const servingCount = Number(portions.trim().replace(',', '.'));
  const service = createFoodApi(api);
  const saved = useQuery({ queryKey: ['meals'], queryFn: service.listMeals });
  const foods = useQuery({ queryKey: ['foods', 'meal-search', query], enabled: Boolean(query && editing && editing !== 'new'),
    queryFn: () => createDiaryApi(api).searchFoods(query, 1),
  });

  const update = useMutation({
    mutationFn: async () => {
      const imageUrl = image && profile ? await uploadImage(image, 'meal-images', profile.id) : undefined;
      return service.saveMeal({ name: name.trim(), directions, imageUrl }, editing !== 'new' ? editing?.id : undefined);
    },
    onSuccess: async (item) => {
      setEditing(item);
      setImage(undefined);
      await client.invalidateQueries({ queryKey: ['meals'] });
    },
  });
  const modifyItem = useMutation({
    mutationFn: (operation: () => Promise<SavedMeal>) => operation(),
    onSuccess: async (updated) => {
      setEditing(updated);
      await client.invalidateQueries({ queryKey: ['meals'] });
    },
  });
  const deleteMeal = useMutation({
    mutationFn: service.deleteMeal,
    onSuccess: async () => {
      setEditing(undefined);
      await client.invalidateQueries({ queryKey: ['meals'] });
    },
  });
  const addToDiary = useMutation({
    mutationFn: async (value: SavedMeal) => {
      if (!date || !parseLocalDate(date) || !slot) throw new Error('Select a diary date and meal first.');
      const values = scaledMealNutrients(value, servingCount);
      if (!(await confirmNutritionLog(() => createDiaryApi(api).getDiary(date), values, profile))) return false;
      await service.logMeal(date, slot, value, servingCount);
      return true;
    },
    onSuccess: async (logged) => {
      if (!logged) return;
      if (date) await refreshDiaryViews(client, date);
      router.back();
    },
  });
  const mealId = editing && editing !== 'new' ? editing.id : undefined;
  const quantity = Number(amount.replace(',', '.'));
  const photo = image?.uri ?? (editing && editing !== 'new' ? editing.imageUrl : undefined);

  function start(value: SavedMeal | 'new') {
    setEditing(value);
    setName(value === 'new' ? '' : value.name);
    setDirections(value === 'new' ? '' : value.directions ?? '');
    setImage(undefined);
  }

  return (
    <Screen title="Saved meals">
      {date && slot && <Field label="Number of portions to log" value={portions} onChangeText={setPortions}
        keyboardType="decimal-pad" />}
      <Action title="Create meal" onPress={() => start('new')} />
      {editing && <Card>
        <Field label="Meal name" value={name} onChangeText={setName} />
        <Field label="Directions" value={directions} onChangeText={setDirections} multiline />
        {photo && <Image source={{ uri: photo }} style={{ height: 160, borderRadius: 8 }} />}
        <Action title="Choose meal photo" onPress={() => {
          setPhotoError(undefined);
          void pickImage('library').then((asset) => { if (asset) setImage(asset); }).catch(setPhotoError);
        }} />
        <Action title="Save meal" disabled={!name.trim() || update.isPending} onPress={() => update.mutate()} />
        <Message error={photoError ?? update.error ?? modifyItem.error} />
        {mealId && editing !== 'new' && <>
          <Field label="Quantity for next add or update" value={amount} onChangeText={setAmount} keyboardType="decimal-pad" />
          {editing.items.map((item) => <Card key={item.id}>
            <Body>{item.food?.description ?? 'Food'} · {formatDisplayNumber(item.quantity)} {item.unit}</Body>
            <Action title="Update quantity" disabled={modifyItem.isPending || !Number.isFinite(quantity) || quantity <= 0}
              onPress={() => modifyItem.mutate(() => service.updateMealItem(mealId, item.id, quantity))} />
            <Action title="Remove from meal" disabled={modifyItem.isPending}
              onPress={() => modifyItem.mutate(() => service.removeMealItem(mealId, item.id))} />
          </Card>)}
          <Field label="Find an ingredient" value={search} onChangeText={setSearch} onSubmitEditing={() => setQuery(search.trim())} />
          <Action title="Search ingredients" onPress={() => setQuery(search.trim())} />
          {foods.isFetching && <Loading />}
          <Message error={foods.error} />
          {foods.data?.items.map((item) => <Action key={item.id} title={`Add ${item.description}`}
            disabled={modifyItem.isPending || !Number.isFinite(quantity) || quantity <= 0}
            onPress={() => modifyItem.mutate(() => service.addMealItem(mealId, item.id, quantity))} />)}
        </>}
        <Action title="Close editor" onPress={() => setEditing(undefined)} />
      </Card>}
      {saved.isPending && <Loading />}
      <Message error={saved.error} retry={() => void saved.refetch()} />
      <Message error={deleteMeal.error ?? addToDiary.error} />
      {saved.data?.items.length === 0 && <Body>No saved meals.</Body>}
      {saved.data?.items.map((item) => <Card key={item.id}>
        <Body>{item.name} · {formatDisplayNumber(item.nutritionSummary?.calories ?? 0)} kcal</Body>
        {date && slot && <Action title="Log meal" disabled={addToDiary.isPending || !item.items.length || !Number.isFinite(servingCount) || servingCount <= 0}
          onPress={() => addToDiary.mutate(item)} />}
        <Action title="Edit meal" onPress={() => start(item)} />
        <Action title="Delete meal" disabled={deleteMeal.isPending} onPress={() => {
          Alert.alert('Delete meal?', item.name, [
            { text: 'Cancel', style: 'cancel' },
            { text: 'Delete', style: 'destructive', onPress: () => deleteMeal.mutate(item.id) },
          ]);
        }} />
      </Card>)}
    </Screen>
  );
}
