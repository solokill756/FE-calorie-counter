import { useMutation } from '@tanstack/react-query';
import { router, useLocalSearchParams } from 'expo-router';
import { useState } from 'react';
import { Action, Body, Card, Field, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';

export default function Recover() {
  const { account } = useSession();
  const params = useLocalSearchParams<{ token?: string }>();
  const [email, setEmail] = useState('');
  const [token, setToken] = useState(params.token ?? '');
  const [password, setPassword] = useState('');
  const send = useMutation({ mutationFn: () => account.forgot(email) });
  const reset = useMutation({
    mutationFn: async () => {
      const result = await account.reset(token, password);
      if (!result.success) throw new Error('Password reset failed.');
    },
    onSuccess: () => router.replace('/sign-in'),
  });

  return (
    <Screen title="Reset password">
      <Card>
        <Field label="Email" value={email} onChangeText={setEmail} autoCapitalize="none" keyboardType="email-address" />
        <Action title="Send reset email" disabled={!email.trim() || send.isPending} onPress={() => send.mutate()} />
        {send.isSuccess && <Body>Check your email for reset instructions.</Body>}
        <Message error={send.error} />
      </Card>
      <Card>
        <Field label="Reset token" value={token} onChangeText={setToken} autoCapitalize="none" />
        <Field label="New password" value={password} onChangeText={setPassword} secureTextEntry />
        <Message error={reset.error} />
        <Action title="Set new password" disabled={!token.trim() || password.length < 8 || reset.isPending}
          onPress={() => reset.mutate()} />
      </Card>
    </Screen>
  );
}
