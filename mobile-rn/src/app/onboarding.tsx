import { useMutation, useQuery } from '@tanstack/react-query';
import { useState } from 'react';
import { Action, Body, Card, Field, Loading, Message, Screen } from '../components/ui';
import { activityOptions, conditions, createOnboardingApi, genderOptions, type OnboardingData } from '../features/account/onboarding';
import { useSession } from '../features/account/session';
import { goalOptions, type GoalType } from '../features/profile/api';

export default function Onboarding() {
  const { api, profile } = useSession();
  const draft = useQuery({
    queryKey: ['onboarding', profile?.id],
    queryFn: () => createOnboardingApi(api).draft(),
  });
  if (draft.isPending) return <Screen title="Set up your profile"><Loading /></Screen>;
  if (draft.error) {
    return <Screen title="Set up your profile"><Message error={draft.error} retry={() => void draft.refetch()} /></Screen>;
  }
  return <OnboardingForm draft={draft.data?.draftData} />;
}

function OnboardingForm({ draft }: { draft?: Partial<OnboardingData> }) {
  const { api, profile, restore, signOut } = useSession();
  const [name, setName] = useState(draft?.displayName ?? profile?.displayName ?? '');
  const [gender, setGender] = useState(draft?.gender ?? '');
  const [age, setAge] = useState(draft?.age ? String(draft.age) : '');
  const [height, setHeight] = useState(draft?.heightCm ? String(draft.heightCm) : '');
  const [weight, setWeight] = useState(draft?.currentWeightKg ? String(draft.currentWeightKg) : '');
  const [goalWeight, setGoalWeight] = useState(draft?.goalWeightKg ? String(draft.goalWeightKg) : '');
  const [activityLevel, setActivityLevel] = useState(draft?.activityLevel ?? '');
  const [goalType, setGoal] = useState<GoalType>(draft?.goalType ?? 'maintenance');
  const [selectedConditions, setConditions] = useState<string[]>(draft?.conditionTypes ?? []);
  const [mealFrequency, setFrequency] = useState(draft?.mealFrequency ?? '');
  const [allergies, setAllergies] = useState(draft?.barriers?.join(', ') ?? '');
  const parse = (value: string) => Number(value.trim().replace(',', '.'));
  const data: OnboardingData = {
    displayName: name.trim(), gender, age: parse(age), heightCm: parse(height), currentWeightKg: parse(weight),
    goalWeightKg: goalWeight.trim() ? parse(goalWeight) : undefined,
    goalType, activityLevel, conditionTypes: selectedConditions, mealFrequency: mealFrequency || undefined,
    barriers: [...new Set(allergies.split(',').map((value) => value.trim()).filter(Boolean))],
  };
  const valid = Boolean(data.displayName && data.gender && data.activityLevel &&
    [data.age, data.heightCm, data.currentWeightKg, data.goalWeightKg ?? 1].every((value) => Number.isFinite(value) && value > 0));
  const service = createOnboardingApi(api);
  const preview = useMutation({ mutationFn: () => service.preview(data) });
  const save = useMutation({ mutationFn: () => service.save(data), onSuccess: restore });
  const estimatedCalories = preview.data?.nutritionPlan?.targetCalories ?? preview.data?.targetCalories;

  return (
    <Screen title="Set up your profile">
      <Card>
        <Field label="Name" value={name} onChangeText={setName} />
        <Field label="Age" value={age} onChangeText={setAge} keyboardType="number-pad" />
        <Field label="Height (cm)" value={height} onChangeText={setHeight} keyboardType="decimal-pad" />
        <Field label="Current weight (kg)" value={weight} onChangeText={setWeight} keyboardType="decimal-pad" />
        <Field label="Goal weight (kg)" value={goalWeight} onChangeText={setGoalWeight} keyboardType="decimal-pad" />
        <Body>Sex for nutrition calculation</Body>
        {genderOptions.map((value) => <Action key={value} title={gender === value ? `✓ ${value}` : value}
          onPress={() => setGender(value)} />)}
      </Card>
      <Card>
        <Body>Primary goal</Body>
        {goalOptions.map(([value, label]) => <Action key={value} title={goalType === value ? `✓ ${label}` : label}
          onPress={() => setGoal(value)} />)}
      </Card>
      <Card>
        <Body>Activity level</Body>
        {activityOptions.map(([value, label]) => <Action key={value} title={activityLevel === value ? `✓ ${label}` : label}
          onPress={() => setActivityLevel(value)} />)}
      </Card>
      <Card>
        <Body>Health conditions</Body>
        {conditions.map(([value, label]) => <Action key={value}
          title={selectedConditions.includes(value) ? `✓ ${label}` : label}
          onPress={() => setConditions((current) => current.includes(value)
            ? current.filter((condition) => condition !== value) : [...current, value])} />)}
        <Field label="Food allergies (comma-separated)" value={allergies} onChangeText={setAllergies} />
      </Card>
      <Card>
        <Body>Meal planning frequency</Body>
        {['never', 'rarely', 'occasionally', 'frequently', 'always'].map((value) => <Action key={value}
          title={mealFrequency === value ? `✓ ${value}` : value} onPress={() => setFrequency(value)} />)}
      </Card>
      <Message error={preview.error ?? save.error} />
      {estimatedCalories != null && <Body>Estimated target · {estimatedCalories} kcal/day</Body>}
      <Action title="Preview nutrition goals" disabled={!valid || preview.isPending} onPress={() => preview.mutate()} />
      <Action title="Save profile" disabled={!valid || save.isPending} onPress={() => save.mutate()} />
      <Action title="Sign out" onPress={() => void signOut().catch(() => undefined)} />
    </Screen>
  );
}
