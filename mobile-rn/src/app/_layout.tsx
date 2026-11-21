import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { Stack } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import { useState } from 'react';
import { initialDestination } from '../features/account/api';
import { SessionProvider, useSession } from '../features/account/session';
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
        <Stack.Screen name="nutrition" options={{ title: 'Nutrition' }} />
        <Stack.Screen name="water" options={{ title: 'Water' }} />
        <Stack.Screen name="food/quick" options={{ title: 'Quick add' }} />
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
        <Navigation />
      </SessionProvider>
    </QueryClientProvider>
  );
}
