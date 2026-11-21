import { Stack } from 'expo-router';

export const unstable_settings = { initialRouteName: 'sign-in' };

export default function AuthLayout() {
  return (
    <Stack screenOptions={{ title: 'Calorie Counter' }}>
      <Stack.Screen name="sign-in" />
      <Stack.Screen name="register" options={{ title: 'Create account' }} />
      <Stack.Screen name="recover" options={{ title: 'Reset password' }} />
    </Stack>
  );
}
