import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { Stack } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import { useState } from 'react';
import { initialDestination } from '../features/account/api';
import { SessionProvider, useSession } from '../features/account/session';
import { NotificationRuntime } from '../features/notifications/runtime';
import { RecipeJobProvider } from '../features/recipes/jobs';
import { Loading, Message, Screen } from '../components/ui';

function Navigation() {
  const { profile, error, restore } = useSession();
  const destination = initialDestination(profile);

  if (destination === 'loading') {
    return (
      <Screen title="Calorie Counter">
        {error ? <Message error={error} retry={() => void restore()} /> : <Loading />}
      </Screen>
    );
  }

  return (
    <Stack>
      <Stack.Protected guard={destination === 'sign-in'}>
        <Stack.Screen name="(auth)" options={{ headerShown: false }} />
      </Stack.Protected>
      <Stack.Protected guard={destination === 'onboarding'}>
        <Stack.Screen name="onboarding" options={{ title: 'Setup' }} />
      </Stack.Protected>
      <Stack.Protected guard={destination === 'tabs'}>
        <Stack.Screen name="(tabs)" options={{ headerShown: false }} />
        <Stack.Screen name="profile/index" options={{ title: 'Profile' }} />
        <Stack.Screen name="profile/goal" options={{ title: 'Goal' }} />
        <Stack.Screen name="add" options={{ title: 'Add', presentation: 'modal' }} />
        <Stack.Screen name="exercise/index" options={{ title: 'Exercise' }} />
        <Stack.Screen name="exercise/history" options={{ title: 'History' }} />
        <Stack.Screen name="weight/form" options={{ title: 'Weight' }} />
        <Stack.Screen name="recipes/index" options={{ title: 'Recipes' }} />
        <Stack.Screen name="recipes/[id]" options={{ title: 'Recipe' }} />
        <Stack.Screen name="recipes/photo" options={{ title: 'Ingredient photo' }} />
        <Stack.Screen name="pantry" options={{ title: 'Pantry' }} />
        <Stack.Screen name="notifications" options={{ title: 'Notifications' }} />
        <Stack.Screen name="nutrition" options={{ title: 'Nutrition' }} />
        <Stack.Screen name="water" options={{ title: 'Water' }} />
        <Stack.Screen name="food/quick" options={{ title: 'Quick add' }} />
        <Stack.Screen name="food/my" options={{ title: 'My foods' }} />
        <Stack.Screen name="meals/index" options={{ title: 'Saved meals' }} />
        <Stack.Screen name="food/search" options={{ title: 'Find food' }} />
      </Stack.Protected>
    </Stack>
  );
}

export default function Layout() {
  const [queryClient] = useState(() => new QueryClient({
    defaultOptions: { queries: { retry: false, staleTime: 15_000 } },
  }));
  return (
    <QueryClientProvider client={queryClient}>
      <SessionProvider>
        <StatusBar style="dark" />
        <AuthorizedNavigation />
      </SessionProvider>
    </QueryClientProvider>
  );
}

function AuthorizedNavigation() {
  const { profile } = useSession();
  return (
    <RecipeJobProvider key={profile?.id ?? 'signed-out'}>
      <Navigation />
      <NotificationRuntime />
    </RecipeJobProvider>
  );
}
