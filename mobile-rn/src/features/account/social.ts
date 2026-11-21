import * as AppleAuthentication from 'expo-apple-authentication';
import { CryptoDigestAlgorithm, digestStringAsync, randomUUID } from 'expo-crypto';
import { GoogleSignin, isSuccessResponse } from '@react-native-google-signin/google-signin';
import { AppleAuthProvider, GoogleAuthProvider, getAuth, getIdToken, signInWithCredential } from '@react-native-firebase/auth';

export async function googleToken(): Promise<string | null> {
  const webClientId = process.env.EXPO_PUBLIC_GOOGLE_WEB_CLIENT_ID;
  if (!webClientId) throw new Error('Google sign-in has not been configured for this build.');

  GoogleSignin.configure({ webClientId });
  await GoogleSignin.hasPlayServices();
  const result = await GoogleSignin.signIn();
  if (!isSuccessResponse(result)) return null;
  if (!result.data.idToken) throw new Error('Google did not return an ID token.');
  const { user } = await signInWithCredential(getAuth(), GoogleAuthProvider.credential(result.data.idToken));
  return getIdToken(user);
}

export async function appleToken(): Promise<string | null> {
  const nonce = randomUUID();
  const hashed = await digestStringAsync(CryptoDigestAlgorithm.SHA256, nonce);
  try {
    const result = await AppleAuthentication.signInAsync({ nonce: hashed });
    if (!result.identityToken) throw new Error('Apple did not return an identity token.');
    const credential = AppleAuthProvider.credential(result.identityToken, nonce);
    const { user } = await signInWithCredential(getAuth(), credential);
    return getIdToken(user);
  } catch (error) {
    if ((error as { code?: string }).code === 'ERR_REQUEST_CANCELED') return null;
    throw error;
  }
}
