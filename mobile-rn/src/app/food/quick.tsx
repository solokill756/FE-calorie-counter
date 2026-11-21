import { useMutation, useQueryClient } from '@tanstack/react-query';
import { router, useLocalSearchParams } from 'expo-router';
import { useState } from 'react';
import { Action, Body, Field, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { createDiaryApi, mealLabels, meals, refreshDiaryViews } from '../../features/diary/api';
import { createFoodApi } from '../../features/food/api';
import { confirmNutritionLog } from '../../features/food/warning-dialog';
import { parseLocalDate } from '../../lib/local-date';

export default function QuickFood() {
  const { api, profile } = useSession();
  const client = useQueryClient();
  const { date = '', meal } = useLocalSearchParams<{ date?: string; meal?: string }>();
  const selectedMeal = meals.find((value) => value === meal) ?? 'breakfast';
  const [calories, setCalories] = useState('');
  const [protein, setProtein] = useState('');
  const [carbs, setCarbs] = useState('');
  const [fat, setFat] = useState('');
  const parse = (value: string) => Number(value.trim().replace(',', '.'));
  const valid = parse(calories) > 0 && [calories, protein, carbs, fat].map(parse).every((value) => Number.isFinite(value) && value >= 0);
  const save = useMutation({
    mutationFn: async () => {
      const values = { calories: parse(calories), proteinG: parse(protein), totalCarbohydratesG: parse(carbs), totalFatG: parse(fat) };
      if (!(await confirmNutritionLog(() => createDiaryApi(api).getDiary(date), values, profile))) return false;
      await createFoodApi(api).quickAdd(date, selectedMeal, values);
      return true;
    },
    onSuccess: async (saved) => {
      if (!saved) return;
      await refreshDiaryViews(client, date);
      router.back();
    },
  });
  return (
    <Screen title="Quick add">
      <Body>{mealLabels[selectedMeal]} · {date}</Body>
      <Field label="Calories" keyboardType="decimal-pad" value={calories} onChangeText={setCalories} />
      <Field label="Protein (g)" keyboardType="decimal-pad" value={protein} onChangeText={setProtein} />
      <Field label="Carbs (g)" keyboardType="decimal-pad" value={carbs} onChangeText={setCarbs} />
      <Field label="Fat (g)" keyboardType="decimal-pad" value={fat} onChangeText={setFat} />
      <Message error={save.error} />
      <Action title="Add to diary" disabled={!valid || !parseLocalDate(date) || save.isPending} onPress={() => save.mutate()} />
    </Screen>
  );
}
