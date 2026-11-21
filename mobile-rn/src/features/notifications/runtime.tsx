import * as Notifications from 'expo-notifications';
import { router } from 'expo-router';
import { useEffect, useRef } from 'react';
import { AppState, Platform } from 'react-native';
import { useSession } from '../account/session';
import { syncMealReminders } from './native';

export function NotificationRuntime() {
  const { profile } = useSession();
  const active = profile?.isProfileComplete === true;
  const owner = profile?.id;
  const opened = useRef<string>(undefined);

  useEffect(() => {
    if (profile === undefined) return;
    void syncMealReminders(active, active).catch(() => undefined);
  }, [active, profile]);

  useEffect(() => {
    if (!active || Platform.OS === 'web') return;

    function open(response: Notifications.NotificationResponse | null) {
      if (!response || opened.current === response.notification.request.identifier) return;
      const { data } = response.notification.request.content;
      if (data?.kind !== 'meal' && data?.kind !== 'recipe' && data?.kind !== 'pantry') return;
      opened.current = response.notification.request.identifier;
      Notifications.clearLastNotificationResponse();
      if (data.kind === 'meal') {
        router.navigate('/diary');
      } else if (data.ownerId === owner && data.kind === 'recipe') {
        if (typeof data.recipeId === 'number' && Number.isSafeInteger(data.recipeId) && data.recipeId > 0) {
          router.navigate({ pathname: '/recipes/[id]', params: { id: String(data.recipeId) } });
        } else {
          router.navigate('/recipes');
        }
      } else if (data.ownerId === owner) {
        router.navigate('/pantry');
      }
    }

    const state = AppState.addEventListener('change', (value) => {
      if (value === 'active') void syncMealReminders(true).catch(() => undefined);
    });
    const responses = Notifications.addNotificationResponseReceivedListener(open);
    void Notifications.getLastNotificationResponseAsync().then(open).catch(() => undefined);
    return () => {
      state.remove();
      responses.remove();
    };
  }, [active, owner]);
  return null;
}
