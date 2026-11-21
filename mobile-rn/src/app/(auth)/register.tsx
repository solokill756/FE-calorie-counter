import { useMutation } from '@tanstack/react-query';
import { useState } from 'react';
import { Action, Field, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';

export default function Register() {
  const { account, setProfile } = useSession();
  const [displayName, setDisplayName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const register = useMutation({
    mutationFn: () => account.register({ email, password }, displayName),
    onSuccess: setProfile,
  });

  return (
    <Screen title="Create an account">
      <Field label="Display name" value={displayName} onChangeText={setDisplayName} />
      <Field label="Email" value={email} onChangeText={setEmail} autoCapitalize="none" keyboardType="email-address" />
      <Field label="Password" value={password} onChangeText={setPassword} secureTextEntry autoComplete="new-password" />
      <Message error={register.error} />
      <Action title="Create account" disabled={!email.trim() || password.length < 8 || register.isPending}
        onPress={() => register.mutate()} />
    </Screen>
  );
}
