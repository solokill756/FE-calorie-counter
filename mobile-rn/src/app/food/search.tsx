import { useInfiniteQuery, useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { router, useLocalSearchParams } from 'expo-router';
import { useState } from 'react';
import { Action, Body, Card, Field, Loading, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { createDiaryApi, type FoodPage, logFoodAndRefresh, mealLabels, meals, type Meal } from '../../features/diary/api';
import { NutrientFilterForm } from '../../features/food/nutrient-filter-form';
import type { FoodNutrientFilters } from '../../features/food/nutrient-filters';
import { confirmNutritionLog } from '../../features/food/warning-dialog';
import { nutrientFields } from '../../features/nutrition/fields';
import { formatDisplayNumber } from '../../lib/format-display-number';
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
  const { api, profile } = useSession();
  const client = useQueryClient();
  const diary = createDiaryApi(api);
  const [input, setInput] = useState('');
  const [search, setSearch] = useState('');
  const [editingFilters, setEditingFilters] = useState(false);
  const [filters, setFilters] = useState<FoodNutrientFilters>();
  const filterCount = filters ? Object.keys(filters).length : 0;
  const [selected, setSelected] = useState<FoodPage['items'][number]>();
  const [quantity, setQuantity] = useState('1');
  const [selectedSize, setSelectedSize] = useState('1');
  const { data, error, isPending, refetch, fetchNextPage, hasNextPage, isFetchingNextPage } = useInfiniteQuery({
    queryKey: ['foods', search, filters],
    queryFn: ({ pageParam }) => diary.searchFoods(search, pageParam, filters),
    initialPageParam: 1,
    getNextPageParam: (page, pages) => {
      const hasMore = filters && page.total !== undefined
        ? pages.length * 20 < page.total
        : page.items.length === 20;
      return hasMore ? pages.length + 1 : undefined;
    },
  });
  const today = localDateKey(new Date());
  const recent = useQuery({ queryKey: ['recent-foods', today], queryFn: () => diary.recentFoods(today), enabled: !search && !filters });
  const save = useMutation({
    mutationFn: async ({ food, amount, size }: { food: FoodPage['items'][number]; amount: number; size: number }) => {
      const scale = amount * size / (Number(food.servingSize) || 1);
      const projected = Object.fromEntries(nutrientFields.map(([key]) => [key, (Number(food[key]) || 0) * scale]));
      if (!(await confirmNutritionLog(() => diary.getDiary(localDateKey(date)), projected, profile))) return false;
      await logFoodAndRefresh(diary, client, { foodId: food.id, meal, date, quantity: amount, servingSize: size });
      return true;
    },
    onSuccess: (saved) => { if (saved) router.back(); },
  });
  const amount = Number(quantity.trim().replace(',', '.'));
  const size = Number(selectedSize.trim().replace(',', '.'));
  const canSave = Number.isFinite(amount) && amount > 0 && Number.isFinite(size) && size > 0;
  const results = data?.pages.flatMap((page) => page.items) ?? [];

  function select(food: FoodPage['items'][number]) {
    setSelected(food);
    setQuantity('1');
    setSelectedSize(String(Number(food.servingSize) > 0 ? food.servingSize : 1));
    save.reset();
  }

  function applyFilters(next: FoodNutrientFilters) {
    setSearch(input.trim());
    setFilters(Object.keys(next).length ? next : undefined);
    setEditingFilters(false);
    setSelected(undefined);
    save.reset();
  }

  return (
    <Screen title={mealLabels[meal]}>
      <Field label="Search foods" value={input} onChangeText={setInput}
        returnKeyType="search" onSubmitEditing={() => setSearch(input.trim())} />
      <Action title="Search" onPress={() => setSearch(input.trim())} />
      {editingFilters
        ? <NutrientFilterForm filters={filters} onApply={applyFilters} onClose={() => setEditingFilters(false)} />
        : <Action title={filterCount ? `Nutrient filters (${filterCount})` : 'Nutrient filters'}
            disabled={save.isPending} onPress={() => setEditingFilters(true)} />}
      <Action title="Quick add calories" onPress={() => router.push({
        pathname: '/food/quick', params: { date: localDateKey(date), meal },
      })} />
      <Action title="My foods" onPress={() => router.push('/food/my')} />
      <Action title="Saved meals" onPress={() => router.push({
        pathname: '/meals', params: { date: localDateKey(date), meal },
      })} />
      {isPending && <Loading />}
      <Message error={error} retry={() => void refetch()} />
      {selected && (
        <Card>
          <Body>{selected.description}</Body>
          <Field label="Number of servings" keyboardType="decimal-pad" value={quantity} onChangeText={setQuantity} />
          <Field label={`Serving size (${selected.servingUnit || 'serving'})`}
            keyboardType="decimal-pad" value={selectedSize} onChangeText={setSelectedSize} />
          {nutrientFields.map(([key, , label, unit]) => {
            const value = selected[key];
            return value == null ? null : <Body key={key}>{label} · {formatDisplayNumber(value)} {unit}</Body>;
          })}
          <Message error={save.error} />
          <Action title={save.isPending ? 'Saving…' : 'Add to diary'} disabled={!canSave || save.isPending}
            onPress={() => save.mutate({ food: selected, amount, size })} />
        </Card>
      )}
      {!search && !filters && !!recent.data?.length && <Card>
        <Body>Recent foods</Body>
        {recent.data.map((food) => <Action key={food.id} title={food.description}
          disabled={save.isPending} onPress={() => select(food)} />)}
      </Card>}
      {!isPending && !error && !results.length && <Body>No foods found.</Body>}
      {results.map((food) => (
        <Card key={food.id}>
          <Body>{food.description}{food.brandName ? ` · ${food.brandName}` : ''}</Body>
          {food.calories != null && <Body>{formatDisplayNumber(food.calories)} kcal</Body>}
          <Action title="Select" disabled={save.isPending} onPress={() => select(food)} />
        </Card>
      ))}
      {hasNextPage && <Action title="Load more" disabled={isFetchingNextPage} onPress={() => void fetchNextPage()} />}
    </Screen>
  );
}
