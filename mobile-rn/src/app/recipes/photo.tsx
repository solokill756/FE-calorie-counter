import { useMutation } from '@tanstack/react-query';
import type { ImagePickerAsset } from 'expo-image-picker';
import { useState } from 'react';
import { Image } from 'react-native';
import { Action, Body, Card, Loading, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { mealLabels, meals, type Meal } from '../../features/diary/api';
import { createRecipeApi } from '../../features/recipes/api';
import { useRecipeJob } from '../../features/recipes/jobs';
import { localDateKey } from '../../lib/local-date';
import { pickImage, uploadImage } from '../../lib/media-upload';

export default function PhotoRecipe() {
  const { api, profile } = useSession();
  const job = useRecipeJob();
  const [image, setImage] = useState<ImagePickerAsset>();
  const [pickError, setPickError] = useState<unknown>();
  const [meal, setMeal] = useState<Meal>('dinner');
  const [selected, setSelected] = useState<Record<string, number>>({});
  const recognize = useMutation({
    mutationFn: async (asset: ImagePickerAsset) => {
      if (!profile) throw new Error('Sign in before recognizing ingredients.');
      return createRecipeApi(api).recognize(await uploadImage(asset, 'ingredient-images', profile.id));
    },
    onSuccess: ({ ingredients }) => {
      setSelected(Object.fromEntries(ingredients.flatMap((item) => {
        const top = item.candidates[0];
        return top ? [[item.clientIngredientId, top.foodId]] : [];
      })));
    },
  });
  const ids = [...new Set(Object.values(selected))];

  function choose(source: 'camera' | 'library') {
    setPickError(undefined);
    void pickImage(source).then((asset) => {
      if (!asset) return;
      setImage(asset);
      setSelected({});
      recognize.mutate(asset);
    }).catch(setPickError);
  }

  return (
    <Screen title="Ingredient photo">
      <Action title="Take photo" disabled={recognize.isPending} onPress={() => choose('camera')} />
      <Action title="Choose photo" disabled={recognize.isPending} onPress={() => choose('library')} />
      {image && <Image accessibilityLabel="Selected ingredients" source={{ uri: image.uri }} style={{ height: 200, borderRadius: 14 }} />}
      {recognize.isPending && <Loading />}
      <Message error={pickError ?? recognize.error} />
      {recognize.data?.ingredients.length === 0 && <Body>No ingredients were recognized.</Body>}
      {recognize.data?.ingredients.map((item) => (
        <Card key={item.clientIngredientId}>
          <Body>{item.detectedName}</Body>
          {item.candidates.length === 0 && <Body>No matching foods.</Body>}
          {item.candidates.map((food) => <Action key={food.foodId}
            title={selected[item.clientIngredientId] === food.foodId ? `✓ ${food.foodName}` : food.foodName}
            onPress={() => setSelected((values) => ({ ...values, [item.clientIngredientId]: food.foodId }))} />)}
          {!!selected[item.clientIngredientId] && <Action title="Skip this ingredient" onPress={() => {
            setSelected((values) => {
              const next = { ...values };
              delete next[item.clientIngredientId];
              return next;
            });
          }} />}
        </Card>
      ))}
      {ids.length > 0 && <Card>
        {meals.map((value) => <Action key={value} title={meal === value ? `✓ ${mealLabels[value]}` : mealLabels[value]}
          onPress={() => setMeal(value)} />)}
        <Action title={job.busy ? 'Generating…' : 'Generate recipe'} disabled={job.busy}
          onPress={() => job.generate.mutate({ foodIds: ids, meal, date: localDateKey(new Date()) })} />
        {job.ready && <Body>Saved · {job.ready}</Body>}
        <Message error={job.generate.error ?? job.save.error} />
        {job.draft && job.save.isError && <Action title="Retry saving recipe"
          onPress={() => { if (job.draft) job.save.mutate(job.draft); }} />}
      </Card>}
    </Screen>
  );
}
