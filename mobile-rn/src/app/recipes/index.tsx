import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { router } from 'expo-router';
import { useState } from 'react';
import { Alert } from 'react-native';
import { Action, Body, Card, Field, Loading, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { createDiaryApi, mealLabels, meals, type Meal } from '../../features/diary/api';
import { createRecipeApi, type Recipe } from '../../features/recipes/api';
import { useRecipeJob } from '../../features/recipes/jobs';
import { localDateKey } from '../../lib/local-date';

export default function Recipes() {
  const { api } = useSession();
  const client = useQueryClient();
  const service = createRecipeApi(api);
  const job = useRecipeJob();
  const [meal, setMeal] = useState<Meal>('dinner');
  const [search, setSearch] = useState('');
  const [query, setQuery] = useState('');
  const [selected, setSelected] = useState<Record<number, string>>({});
  const [editing, setEditing] = useState<Recipe>();
  const [name, setName] = useState('');
  const [instructions, setInstructions] = useState('');
  const saved = useQuery({ queryKey: ['recipes'], queryFn: service.list });
  const staples = useQuery({ queryKey: ['pantry'], queryFn: service.staples });
  const available = useQuery({
    queryKey: ['foods', 'recipes', query],
    queryFn: () => createDiaryApi(api).searchFoods(query, 1),
  });
  const edit = useMutation({
    mutationFn: (operation: () => Promise<unknown>) => operation(),
    onSuccess: async () => {
      await Promise.all([client.invalidateQueries({ queryKey: ['recipes'] }), client.invalidateQueries({ queryKey: ['meals'] })]);
      setEditing(undefined);
    },
  });
  const foodIds = Object.keys(selected).map(Number);
  const choices = new Map([...(staples.data ?? []), ...(available.data?.items ?? [])].map((food) => [food.id, food.description]));

  function toggle(id: number, label: string) {
    setSelected((current) => {
      const next = { ...current };
      if (id in next) delete next[id];
      else next[id] = label;
      return next;
    });
  }

  return (
    <Screen title="Recipes">
      <Action title="Use an ingredient photo" onPress={() => router.push('/recipes/photo')} />
      <Action title="Open pantry" onPress={() => router.push('/pantry')} />
      <Card>
        <Body>Generate a recipe from selected foods</Body>
        {meals.map((value) => <Action key={value} title={meal === value ? `✓ ${mealLabels[value]}` : mealLabels[value]}
          onPress={() => setMeal(value)} />)}
        <Field label="Find ingredients" value={search} onChangeText={setSearch} onSubmitEditing={() => setQuery(search.trim())} />
        <Action title="Search" onPress={() => setQuery(search.trim())} />
        {Object.values(selected).length > 0 && <Body>Selected · {Object.values(selected).join(', ')}</Body>}
        {available.isPending && <Loading />}
        <Message error={available.error ?? staples.error} />
        {[...choices].map(([id, label]) => <Action key={id} title={selected[id] ? `✓ ${label}` : label}
          onPress={() => toggle(id, label)} />)}
        <Action title={job.busy ? 'Generating…' : 'Generate recipe'} disabled={!foodIds.length || job.busy}
          onPress={() => job.generate.mutate({ foodIds, meal, date: localDateKey(new Date()) })} />
        <Message error={job.generate.error ?? job.save.error} />
        {job.ready && <Body>Saved · {job.ready}</Body>}
        {job.draft && job.save.isError && <>
          <Body>{job.draft.name}</Body>
          <Action title="Retry saving recipe" onPress={() => { if (job.draft) job.save.mutate(job.draft); }} />
          <Action title="Discard draft" onPress={job.discard} />
        </>}
      </Card>
      <Body>Saved recipes</Body>
      {saved.isPending && <Loading />}
      {saved.data?.length === 0 && <Body>No saved recipes.</Body>}
      <Message error={saved.error ?? edit.error} retry={() => void saved.refetch()} />
      {editing && <Card>
        <Field label="Recipe name" value={name} onChangeText={setName} />
        <Field label="Steps (one per line)" value={instructions} onChangeText={setInstructions} multiline />
        <Action title="Save changes" disabled={!name.trim() || edit.isPending} onPress={() => {
          const { id, ...draft } = editing;
          const lines = instructions.split('\n').map((line) => line.trim()).filter(Boolean);
          const steps = lines.map((instruction, index) => ({ ...draft.steps[index], instruction, order: index + 1 }));
          edit.mutate(() => service.save({ ...draft, name: name.trim(), steps }, id));
        }} />
        <Action title="Cancel" onPress={() => setEditing(undefined)} />
      </Card>}
      {saved.data?.map((recipe) => <Card key={recipe.id}>
        <Body>{recipe.name} · {recipe.servings} servings</Body>
        {recipe.description && <Body>{recipe.description}</Body>}
        {recipe.warnings?.map((text, index) => <Body key={index}>{text}</Body>)}
        {recipe.ingredients?.map((item, index) => (
          <Body key={index}>{item.name} · {item.quantity} {item.unit}</Body>
        ))}
        {recipe.steps?.map((step, index) => <Body key={index}>{index + 1}. {step.instruction}</Body>)}
        <Action title="Edit recipe" onPress={() => {
          setEditing(recipe);
          setName(recipe.name);
          setInstructions(recipe.steps.map((step) => step.instruction).join('\n'));
        }} />
        <Action title="Convert to saved meal" disabled={edit.isPending}
          onPress={() => edit.mutate(() => service.convert(recipe.id))} />
        <Action title="Delete recipe" disabled={edit.isPending} onPress={() => {
          Alert.alert('Delete recipe?', recipe.name, [
            { text: 'Cancel', style: 'cancel' },
            { text: 'Delete', style: 'destructive', onPress: () => edit.mutate(() => service.delete(recipe.id)) },
          ]);
        }} />
      </Card>)}
    </Screen>
  );
}
