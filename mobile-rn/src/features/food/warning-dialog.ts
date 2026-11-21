import { Alert } from 'react-native';
import type { UserProfile } from '../account/api';
import type { Diary } from '../diary/api';
import { projectedWarnings, type Additions } from './warnings';

export async function confirmNutritionLog(loadDiary: () => Promise<Diary>, values: Additions, profile?: UserProfile | null) {
  const diary = await loadDiary().catch(() => null);
  if (!diary) return true;
  const warnings = projectedWarnings(diary, values, profile);
  if (!warnings.length) return true;
  return new Promise<boolean>((resolve) => {
    Alert.alert('Daily limits exceeded', warnings.join('\n'), [
      { text: 'Cancel', style: 'cancel', onPress: () => resolve(false) },
      { text: 'Log anyway', onPress: () => resolve(true) },
    ], { cancelable: true, onDismiss: () => resolve(false) });
  });
}
