import { router } from 'expo-router';
import { useState } from 'react';
import { Platform } from 'react-native';
import { appleToken, googleToken } from '../../features/account/social';
import { Action, Field, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';

export default function SignIn() {
  const { account, setProfile, signIn } = useSession();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<unknown>();

  async function submit() {
    setBusy(true);
    setError(undefined);
    try {
      await signIn(email, password);
    } catch (cause) {
      setError(cause);
    } finally {
      setBusy(false);
    }
  }

  async function socialSignIn(provider: 'apple' | 'google') {
    setBusy(true);
    setError(undefined);
    try {
      const token = await (provider === 'google' ? googleToken() : appleToken());
      if (token) setProfile(await account.socialSignIn(provider, token));
    } catch (cause) {
      setError(cause);
    } finally {
      setBusy(false);
    }
  }

  return (
    <Screen title="Sign in">
      <Field label="Email" value={email} onChangeText={setEmail} autoCapitalize="none"
        keyboardType="email-address" autoComplete="email" />
      <Field label="Password" value={password} onChangeText={setPassword} secureTextEntry
        autoComplete="current-password" onSubmitEditing={() => {
          if (!busy && email.trim() && password) void submit();
        }} />
      <Message error={error} />
      <Action title={busy ? 'Signing in…' : 'Sign in'}
        disabled={busy || !email.trim() || !password} onPress={() => void submit()} />
      {process.env.EXPO_PUBLIC_GOOGLE_WEB_CLIENT_ID && <Action title="Continue with Google"
        disabled={busy} onPress={() => void socialSignIn('google')} />}
      {Platform.OS === 'ios' && process.env.EXPO_PUBLIC_APPLE_SIGN_IN === '1' &&
        <Action title="Continue with Apple" disabled={busy} onPress={() => void socialSignIn('apple')} />}
      <Action title="Create account" disabled={busy} onPress={() => router.push('/register')} />
      <Action title="Forgot password?" disabled={busy} onPress={() => router.push('/recover')} />
    </Screen>
  );
}
