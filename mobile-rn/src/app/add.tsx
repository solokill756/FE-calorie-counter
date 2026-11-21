import { router } from 'expo-router';
import { Action, Screen } from '../components/ui';
import { localDateKey } from '../lib/local-date';

export default function Add() {
  const date = localDateKey(new Date());
  function open(path: '/water' | '/weight/form' | '/exercise' | '/recipes' | '/recipes/photo') {
    router.replace(path);
  }
  return (
    <Screen title="Add">
      <Action title="Log food" onPress={() => router.replace({ pathname: '/food/search', params: { date, meal: 'breakfast' } })} />
      <Action title="Add water" onPress={() => open('/water')} />
      <Action title="Record weight" onPress={() => open('/weight/form')} />
      <Action title="Log exercise" onPress={() => open('/exercise')} />
      <Action title="Suggest a recipe" onPress={() => open('/recipes')} />
      <Action title="Use an ingredient photo" onPress={() => open('/recipes/photo')} />
    </Screen>
  );
}
