import { useMutation } from '@tanstack/react-query';
import { router } from 'expo-router';
import { Alert } from 'react-native';
import { Action, Body, Card, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';

export default function More() {
  const { account, profile, signOut } = useSession();
  const remove = useMutation({ mutationFn: account.deleteAccount });

  function confirmDelete() {
    Alert.alert('Delete your account?', 'Your account and its data will be permanently deleted.', [
      { text: 'Cancel', style: 'cancel' },
      { text: 'Delete account', style: 'destructive', onPress: () => remove.mutate() },
    ]);
  }

  return (
    <Screen title="More">
      <Card>
        <Body>{profile?.displayName}</Body>
        <Body>{profile?.email}</Body>
      </Card>
      <Action title="Profile" onPress={() => router.push('/profile')} />
      <Action title="Goal" onPress={() => router.push('/profile/goal')} />
      <Action title="Exercise" onPress={() => router.push('/exercise')} />
      <Action title="Pantry" onPress={() => router.push('/pantry')} />
      <Action title="Recipes" onPress={() => router.push('/recipes')} />
      <Action title="Sign out" onPress={() => void signOut().catch(() => undefined)} />
      <Action title="Delete account" disabled={remove.isPending} onPress={confirmDelete} />
      <Message error={remove.error} />
    </Screen>
  );
}
