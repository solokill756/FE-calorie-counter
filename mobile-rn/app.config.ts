import type { ExpoConfig } from 'expo/config';

const androidFirebase = process.env.RN_ANDROID_GOOGLE_SERVICES;
const iosFirebase = process.env.RN_IOS_GOOGLE_SERVICES;
const iosScheme = process.env.RN_IOS_GOOGLE_URL_SCHEME;
const appleSignIn = process.env.EXPO_PUBLIC_APPLE_SIGN_IN === '1';

const config: ExpoConfig = {
  name: 'Calorie Counter RN',
  slug: 'calorie-counter-rn',
  version: '1.0.0',
  orientation: 'portrait',
  scheme: 'calorie-counter-rn',
  icon: './assets/icon.png',
  userInterfaceStyle: 'light',
  ios: {
    bundleIdentifier: 'com.trietngan.caloriecounter.rn',
    supportsTablet: true,
    usesAppleSignIn: appleSignIn,
    ...(iosFirebase ? { googleServicesFile: iosFirebase } : {}),
  },
  android: {
    package: 'com.trietngan.caloriecounter.rn',
    ...(androidFirebase ? { googleServicesFile: androidFirebase } : {}),
  },
  plugins: [
    'expo-router',
    'expo-font',
    'expo-secure-store',
    ['expo-image-picker', { microphonePermission: false }],
    'expo-notifications',
    'expo-sharing',
    ['expo-build-properties', { android: { minSdkVersion: 24 }, ios: { deploymentTarget: '15.1', useFrameworks: 'static' } }],
    ...(appleSignIn ? ['expo-apple-authentication'] : []),
    ...(androidFirebase || iosFirebase ? ['@react-native-firebase/app', '@react-native-firebase/auth'] : []),
    ...(iosScheme ? [['@react-native-google-signin/google-signin', { iosUrlScheme: iosScheme }] as [string, object]] : []),
  ],
};

export default config;
