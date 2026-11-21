import * as Notifications from 'expo-notifications';
import { Platform } from 'react-native';
import { reconcileMealReminders } from './reminders';

const channel = 'meal_log_reminders';

if (Platform.OS !== 'web') {
  Notifications.setNotificationHandler({
    handleNotification: async () => ({
      shouldShowBanner: true, shouldShowList: true, shouldPlaySound: true, shouldSetBadge: false,
    }),
  });
}
let pending = Promise.resolve();

async function permission(request: boolean) {
  if (Platform.OS === 'web') return false;
  if (Platform.OS === 'android') {
    await Notifications.setNotificationChannelAsync(channel, {
      name: 'Meal reminders', importance: Notifications.AndroidImportance.DEFAULT,
    });
  }
  const status = await Notifications.getPermissionsAsync();
  if (status.granted || status.ios?.status === Notifications.IosAuthorizationStatus.PROVISIONAL) return true;
  return request && status.canAskAgain && (await Notifications.requestPermissionsAsync()).granted;
}

export function syncMealReminders(signedIn: boolean, requestPermission = false) {
  const result = pending.then(async () => {
    if (Platform.OS === 'web') return;
    const scheduled = (await Notifications.getAllScheduledNotificationsAsync())
      .filter((item) => item.content.data?.kind === 'meal');
    if (!signedIn) {
      await Promise.all(scheduled.map((item) => Notifications.cancelScheduledNotificationAsync(item.identifier)));
      return;
    }
    if (!(await permission(requestPermission))) return;
    const next = reconcileMealReminders(new Date(), scheduled.map((item) => ({
      identifier: item.identifier, time: Number(item.content.data?.time),
    })));
    await Promise.all(next.remove.map((identifier) => Notifications.cancelScheduledNotificationAsync(identifier)));
    for (const time of next.add) {
      await Notifications.scheduleNotificationAsync({
        identifier: `meal-${time}`,
        content: { title: 'Log your meals', body: 'Start the day by logging what you eat.', data: { kind: 'meal', time } },
        trigger: { type: Notifications.SchedulableTriggerInputTypes.DATE, date: time, channelId: channel },
      });
    }
  });
  pending = result.catch(() => undefined);
  return result;
}

export async function notifyRecipeStatus({
  ownerId, kind, jobId, title, body, recipeId,
}: {
  ownerId: number; kind: 'recipe' | 'pantry'; jobId: string;
  title: string; body: string; recipeId?: number;
}) {
  if (!(await permission(false))) return;
  await Notifications.scheduleNotificationAsync({
    identifier: `calorie-${kind}-${jobId}`,
    content: { title, body, data: { kind, ownerId, recipeId: recipeId ?? null } },
    trigger: null,
  });
}
