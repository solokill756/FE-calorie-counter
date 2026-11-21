import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { useState } from 'react';
import { Action, Body, Card, Field, Loading, Message, Screen } from '../../components/ui';
import type { MealSplits, UserProfile } from '../../features/account/api';
import { conditions, genderOptions } from '../../features/account/onboarding';
import { useSession } from '../../features/account/session';
import { createProfileApi, type HealthProfilePatch } from '../../features/profile/api';

const mealSlots = [
  ['breakfast', 'Breakfast'],
  ['lunch', 'Lunch'],
  ['dinner', 'Dinner'],
  ['snack', 'Snack'],
] as const;
const defaultSplits: MealSplits = { breakfast: 25, lunch: 35, dinner: 30, snack: 10 };
type SplitInputs = Record<keyof MealSplits, string>;
type HealthEdits = {
  age?: string;
  gender?: string;
  heightCm?: string;
  conditionTypes?: string[];
  allergies?: string[];
  mealSplits?: SplitInputs | null;
};

function splitInputs(values: MealSplits): SplitInputs {
  return {
    breakfast: String(values.breakfast),
    lunch: String(values.lunch),
    dinner: String(values.dinner),
    snack: String(values.snack),
  };
}

function sameValues(first: string[], second: string[]) {
  return first.length === second.length && first.every((value) => second.includes(value));
}

export default function HealthProfile() {
  const { api, profile } = useSession();
  const needsHydration = Boolean(profile && !hasHealthLists(profile));
  const fullProfile = useQuery({
    queryKey: ['health-profile', profile?.id],
    enabled: needsHydration,
    queryFn: async ({ signal }) => {
      const current = await api.request<UserProfile>('auth/me', { signal });
      if (current.id !== profile?.id || !hasHealthLists(current)) {
        throw new Error('The full health profile could not be loaded.');
      }
      return current;
    },
  });
  if (!profile) return null;

  const initialProfile = needsHydration ? fullProfile.data : profile;
  if (!initialProfile) {
    return (
      <Screen title="Health profile">
        {fullProfile.isError && !fullProfile.isFetching
          ? <Message error={fullProfile.error} retry={() => void fullProfile.refetch()} />
          : <Loading />}
      </Screen>
    );
  }
  return <HealthForm key={profile.id} profile={initialProfile} />;
}

function hasHealthLists(profile: UserProfile) {
  return Array.isArray(profile.conditionTypes) && Array.isArray(profile.barriers);
}

function HealthForm({ profile }: { profile: UserProfile }) {
  const { api, setProfile } = useSession();
  const client = useQueryClient();
  const [saved, setSaved] = useState(profile);
  const [edits, setEdits] = useState<HealthEdits>({});
  const [newAllergy, setNewAllergy] = useState('');
  const save = useMutation({
    mutationFn: (patch: HealthProfilePatch) => createProfileApi(api).updateHealthProfile(patch),
    onSuccess: async (updated) => {
      setProfile(updated);
      setSaved(updated);
      setEdits({});
      setNewAllergy('');
      await client.invalidateQueries();
    },
  });

  function edit(change: HealthEdits) {
    save.reset();
    setEdits((previous) => ({ ...previous, ...change }));
  }

  const age = edits.age ?? String(saved.age ?? '');
  const height = edits.heightCm ?? String(saved.heightCm ?? '');
  const gender = edits.gender ?? saved.gender;
  const savedConditions = saved.conditionTypes ?? [];
  const selectedConditions = edits.conditionTypes ?? savedConditions;
  const savedAllergies = saved.barriers ?? [];
  const allergies = edits.allergies ?? savedAllergies;
  const conditionOptions = [
    ...conditions,
    ...savedConditions.filter((value) => !conditions.some(([key]) => key === value.toLowerCase()))
      .map((value) => [value, value.replaceAll('_', ' ')] as const),
  ];

  const mealSplits = edits.mealSplits === null
    ? splitInputs(defaultSplits)
    : edits.mealSplits ?? splitInputs(saved.mealSplits ?? defaultSplits);
  const parsedSplits = {
    breakfast: Number(mealSplits.breakfast),
    lunch: Number(mealSplits.lunch),
    dinner: Number(mealSplits.dinner),
    snack: Number(mealSplits.snack),
  };
  const total = mealSlots.reduce((sum, [slot]) => sum + parsedSplits[slot], 0);
  const validSplits = mealSlots.every(([slot]) => /^\d+$/.test(mealSplits[slot]) && parsedSplits[slot] <= 100)
    && total === 100;

  const parsedAge = Number(age.trim());
  const invalidAge = edits.age !== undefined
    && (!/^\d+$/.test(age.trim()) || parsedAge < 1 || parsedAge > 130);
  const normalizedHeight = height.trim().replace(',', '.');
  const parsedHeight = Number(normalizedHeight);
  const invalidHeight = edits.heightCm !== undefined
    && (!/^\d+(\.\d+)?$/.test(normalizedHeight) || parsedHeight < 1 || parsedHeight > 300);
  const allergy = newAllergy.trim();
  const duplicateAllergy = allergies.some((value) => value.toLowerCase() === allergy.toLowerCase());

  const validation = invalidAge ? 'Enter an age from 1 to 130 in whole years.'
    : invalidHeight ? 'Enter a height from 1 to 300 cm.'
    : edits.mealSplits && !validSplits ? 'Enter four whole percentages that add up to 100%.'
    : undefined;
  const patch: HealthProfilePatch = {};
  if (edits.age !== undefined && parsedAge !== saved.age) patch.age = parsedAge;
  if (edits.heightCm !== undefined && parsedHeight !== saved.heightCm) patch.heightCm = parsedHeight;
  if (edits.gender && gender !== saved.gender) patch.gender = edits.gender;
  if (!sameValues(selectedConditions, savedConditions)) patch.conditionTypes = selectedConditions;
  if (!sameValues(allergies, savedAllergies)) patch.allergies = allergies;
  if (edits.mealSplits === null) patch.mealSplits = null;
  else if (edits.mealSplits && mealSlots.some(([slot]) => parsedSplits[slot] !== (saved.mealSplits ?? defaultSplits)[slot])) {
    patch.mealSplits = parsedSplits;
  }

  return (
    <Screen title="Health profile">
      <Card>
        <Field label="Age" value={age} onChangeText={(value) => edit({ age: value })}
          keyboardType="number-pad" editable={!save.isPending} />
        <Field label="Height (cm)" value={height} onChangeText={(value) => edit({ heightCm: value })}
          keyboardType="decimal-pad" editable={!save.isPending} />
        <Body>Sex for nutrition calculation</Body>
        {gender && !genderOptions.some((option) => option === gender) && <Body>Current value · {gender}</Body>}
        {genderOptions.map((value) => <Action key={value} title={value === gender ? `✓ ${value}` : value}
          disabled={save.isPending} onPress={() => edit({ gender: value })} />)}
      </Card>
      <Card>
        <Body>Health conditions</Body>
        {conditionOptions.map(([value, label]) => {
          const isSelected = selectedConditions.some((item) => item.toLowerCase() === value.toLowerCase());
          return <Action key={value} title={isSelected ? `✓ ${label}` : label} disabled={save.isPending}
            onPress={() => edit({
              conditionTypes: isSelected
                ? selectedConditions.filter((item) => item.toLowerCase() !== value.toLowerCase())
                : [...selectedConditions, value],
            })} />;
        })}
        <Body>Food allergies</Body>
        {allergies.map((value) => <Action key={value} title={`Remove ${value}`} disabled={save.isPending}
          onPress={() => edit({ allergies: allergies.filter((item) => item !== value) })} />)}
        <Field label="Add food allergy" value={newAllergy} onChangeText={setNewAllergy} editable={!save.isPending} />
        <Action title="Add allergy" disabled={!allergy || duplicateAllergy || save.isPending} onPress={() => {
          edit({ allergies: [...allergies, allergy] });
          setNewAllergy('');
        }} />
        {allergy && duplicateAllergy && <Body>This allergy is already listed.</Body>}
      </Card>
      <Card>
        <Body>Daily calories by meal</Body>
        {mealSlots.map(([slot, label]) => <Field key={slot} label={`${label} (%)`} value={mealSplits[slot]}
          keyboardType="number-pad" editable={!save.isPending}
          onChangeText={(value) => edit({ mealSplits: { ...mealSplits, [slot]: value } })} />)}
        <Body>{Number.isFinite(total) ? `Total · ${total}%` : 'Total · —'}</Body>
        <Action title="Reset meal splits to defaults" onPress={() => edit({ mealSplits: null })} disabled={save.isPending} />
        {edits.mealSplits === null && <Body>Save to apply the default meal splits.</Body>}
      </Card>
      <Message error={validation ?? save.error} />
      {save.isSuccess && <Body>Health profile saved.</Body>}
      <Action title={save.isPending ? 'Saving…' : 'Save health profile'}
        disabled={Boolean(validation || !Object.keys(patch).length || newAllergy.trim() || save.isPending)}
        onPress={() => save.mutate(patch)} />
    </Screen>
  );
}
