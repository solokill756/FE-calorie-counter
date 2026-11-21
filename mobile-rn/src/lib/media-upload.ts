import type { ImagePickerAsset } from 'expo-image-picker';
import { getDownloadURL, getStorage, putFile, ref } from '@react-native-firebase/storage';

export async function pickImage(source: 'camera' | 'library') {
  const picker = await import('expo-image-picker');
  if (source === 'camera') {
    const permission = await picker.requestCameraPermissionsAsync();
    if (!permission.granted) throw new Error('Camera access is required to take a photo.');
  }
  const options = { mediaTypes: ['images'] as ['images'], quality: 0.8 };
  const result = source === 'camera' ? await picker.launchCameraAsync(options)
    : await picker.launchImageLibraryAsync(options);
  return result.canceled ? null : result.assets[0];
}

type Destination = 'avatar-images' | 'ingredient-images' | 'recipe-images' | 'meal-images' | 'weight';

export async function uploadImage(asset: ImagePickerAsset, folder: Destination, ownerId: number) {
  const extension = asset.fileName?.match(/\.(jpg|jpeg|png|webp|gif|heic|heif)$/i)?.[1]?.toLowerCase()
    ?? asset.mimeType?.split('/')[1]?.replace('jpeg', 'jpg') ?? 'jpg';
  const object = ref(getStorage(), `${folder}/${ownerId}/${Date.now()}.${extension}`);
  await putFile(object, asset.uri, { contentType: asset.mimeType ?? 'image/jpeg' });
  return getDownloadURL(object);
}
