import { useQuery } from '@tanstack/react-query';
import { useLocalSearchParams } from 'expo-router';
import { Image } from 'react-native';
import { Body, Card, Loading, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { createRecipeApi } from '../../features/recipes/api';

export default function RecipeDetail() {
  const { api } = useSession();
  const { id } = useLocalSearchParams<{ id?: string }>();
  const recipeId = Number(id);
  const valid = Number.isSafeInteger(recipeId) && recipeId > 0;
  const recipe = useQuery({
    queryKey: ['recipes', recipeId], enabled: valid,
    queryFn: () => createRecipeApi(api).detail(recipeId),
  });
  const item = recipe.data;

  return (
    <Screen title={item?.name ?? 'Recipe'}>
      {!valid && <Message error="Recipe not found." />}
      {valid && recipe.isPending && <Loading />}
      <Message error={recipe.error} retry={() => void recipe.refetch()} />
      {item && <>
        {item.imageUrl && <Image source={{ uri: item.imageUrl }} style={{ height: 180, borderRadius: 12 }} />}
        <Card>
          <Body>{item.servings} servings · {item.prepMinutes + item.cookMinutes} min</Body>
          {item.description && <Body>{item.description}</Body>}
          {item.warnings?.map((warning, index) => <Body key={index}>{warning}</Body>)}
        </Card>
        <Card>
          <Body>Ingredients</Body>
          {item.ingredients.map((ingredient, index) => <Body key={index}>
            {ingredient.name} · {ingredient.quantity} {ingredient.unit}
          </Body>)}
        </Card>
        <Card>
          <Body>Instructions</Body>
          {item.steps.map((step, index) => <Body key={index}>{index + 1}. {step.instruction}</Body>)}
        </Card>
      </>}
    </Screen>
  );
}
