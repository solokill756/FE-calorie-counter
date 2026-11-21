import { useMutation, useQueryClient } from '@tanstack/react-query';
import { useState } from 'react';
import { Action, Body, Card, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { createProfileApi, goalOptions, type GoalType } from '../../features/profile/api';

export default function Goal() {
  const { api, profile, setProfile } = useSession();
  const client = useQueryClient();
  const [goal, setGoal] = useState<GoalType | undefined>(
    goalOptions.find(([value]) => value === profile?.goalType)?.[0],
  );
  const update = useMutation({
    mutationFn: (value: GoalType) => createProfileApi(api).updateGoal(value),
    onSuccess: async (next) => {
      setProfile(next);
      await client.invalidateQueries();
    },
  });
  const targets = profile?.nutritionTargets;

  return (
    <Screen title="Your goal">
      {targets && <Card>
        <Body>{targets.targetCalories} kcal/day</Body>
        <Body>Protein {targets.proteinG} g · Carbs {targets.carbsG} g · Fat {targets.fatG} g</Body>
      </Card>}
      {goalOptions.map(([value, label]) => (
        <Action key={value} title={goal === value ? `✓ ${label}` : label} onPress={() => setGoal(value)} />
      ))}
      <Message error={update.error} />
      {update.isSuccess && <Body>Goal saved.</Body>}
      <Action title="Save goal" disabled={!goal || update.isPending}
        onPress={() => { if (goal) update.mutate(goal); }} />
    </Screen>
  );
}
