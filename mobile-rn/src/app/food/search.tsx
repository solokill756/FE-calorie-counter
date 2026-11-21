import { useInfiniteQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { router, useLocalSearchParams } from 'expo-router';
import { useState } from 'react';
import { Action, Body, Card, Field, Loading, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { createDiaryApi, type FoodPage, logFoodAndRefresh, mealLabels, meals, type Meal } from '../../features/diary/api';
import { localDateKey, parseLocalDate } from '../../lib/local-date';

export default function SearchFood() {
  const { date, meal } = useLocalSearchParams<{ date?: string; meal?: string }>();
  const day = date && parseLocalDate(date);
  const slot = meals.find((value) => value === meal) ?? 'breakfast';

  if (!day) {
    return <Screen title="Find food"><Message error="Choose a day in your diary first." /></Screen>;
  }

  return <FoodPicker date={day} meal={slot} />;
}

function FoodPicker({ date, meal }: { date: Date; meal: Meal }) {
  const { api } = useSession();
  const client = useQueryClient();
  const diary = createDiaryApi(api);
  const [input, setInput] = useState('');
  const [search, setSearch] = useState('');
  const [selected, setSelected] = useState<FoodPage['items'][number]>();
  const [quantity, setQuantity] = useState('1');
  const [selectedSize, setSelectedSize] = useState('1');
  const { data, error, isPending, refetch, fetchNextPage, hasNextPage, isFetchingNextPage } = useInfiniteQuery({
    queryKey: ['foods', search],
    queryFn: ({ pageParam }) => diary.searchFoods(search, pageParam),
    initialPageParam: 1,
    getNextPageParam: (page, pages) => page.items.length === 20 ? pages.length + 1 : undefined,
  });
  const save = useMutation({
    mutationFn: ({ id, amount, size }: { id: number; amount: number; size: number }) =>
      logFoodAndRefresh(diary, client, { foodId: id, meal, date, quantity: amount, servingSize: size }),
    onSuccess: () => router.back(),
  });
  const amount = Number(quantity.trim().replace(',', '.'));
  const size = Number(selectedSize.trim().replace(',', '.'));
  const canSave = Number.isFinite(amount) && amount > 0 && Number.isFinite(size) && size > 0;
  const results = data?.pages.flatMap((page) => page.items) ?? [];

  return (
    <Screen title={mealLabels[meal]}>
      <Field label="Search foods" value={input} onChangeText={setInput}
        returnKeyType="search" onSubmitEditing={() => setSearch(input.trim())} />
      <Action title="Search" onPress={() => setSearch(input.trim())} />
      <Action title="Quick add calories" onPress={() => router.push({
        pathname: '/food/quick', params: { date: localDateKey(date), meal },
      })} />
      {isPending && <Loading />}
      <Message error={error} retry={() => void refetch()} />
      {selected && (
        <Card>
          <Body>{selected.description}</Body>
          <Field label="Number of servings" keyboardType="decimal-pad" value={quantity} onChangeText={setQuantity} />
          <Field label={`Serving size (${selected.servingUnit || 'serving'})`}
            keyboardType="decimal-pad" value={selectedSize} onChangeText={setSelectedSize} />
          <Message error={save.error} />
          <Action title={save.isPending ? 'Saving…' : 'Add to diary'} disabled={!canSave || save.isPending}
            onPress={() => save.mutate({ id: selected.id, amount, size })} />
        </Card>
      )}
      {!isPending && !error && !results.length && <Body>No foods found.</Body>}
      {results.map((food) => (
        <Card key={food.id}>
          <Body>{food.description}{food.brandName ? ` · ${food.brandName}` : ''}</Body>
          {food.calories != null && <Body>{food.calories} kcal</Body>}
          <Action title="Select" disabled={save.isPending} onPress={() => {
            setSelected(food);
            setQuantity('1');
            setSelectedSize(String(Number(food.servingSize) > 0 ? food.servingSize : 1));
            save.reset();
          }} />
        </Card>
      ))}
      {hasNextPage && <Action title="Load more" disabled={isFetchingNextPage} onPress={() => void fetchNextPage()} />}
    </Screen>
  );
}
