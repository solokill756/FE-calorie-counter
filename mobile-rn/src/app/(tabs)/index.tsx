import { useQuery } from '@tanstack/react-query';
import { router } from 'expo-router';
import { Action, Body, Card, Loading, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { createDiaryApi } from '../../features/diary/api';
import { localDateKey } from '../../lib/local-date';

export default function Dashboard() {
  const { api, profile } = useSession();
  const date = localDateKey(new Date());
  const { data, error, isPending, refetch } = useQuery({
    queryKey: ['dashboard', date],
    queryFn: () => createDiaryApi(api).getDashboard(date),
  });

  return (
    <Screen title="Dashboard">
      {profile?.displayName && <Body>{profile.displayName}</Body>}
      {isPending && <Loading />}
      <Message error={error} retry={() => void refetch()} />
      {data && <>
        <Card>
          <Body>{data.calories.consumed} / {data.calories.target} kcal</Body>
          <Body>{data.calories.remaining} kcal remaining · {data.calories.burned} kcal burned</Body>
          {data.macros && <Body>
            Protein {data.macros.protein.current} g · Carbs {data.macros.carbs.current} g · Fat {data.macros.fat.current} g
          </Body>}
        </Card>
        {data.water && <Card><Body>Water · {data.water.currentMl} / {data.water.targetMl} ml</Body></Card>}
        {data.exercise && <Card><Body>Exercise · {data.exercise.minutes} min</Body></Card>}
      </>}
      <Action title="Nutrition" onPress={() => router.push('/nutrition')} />
      <Action title="Water" onPress={() => router.push('/water')} />
      <Action title="Open diary" onPress={() => router.navigate('/diary')} />
      <Action title="Log food" onPress={() => router.push({ pathname: '/food/search', params: { date, meal: 'breakfast' } })} />
    </Screen>
  );
}
