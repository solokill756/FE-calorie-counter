import { useMutation } from '@tanstack/react-query';
import type { ImagePickerAsset } from 'expo-image-picker';
import { useState } from 'react';
import { Image } from 'react-native';
import { Action, Body, Card, Field, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { createProfileApi } from '../../features/profile/api';
import { pickImage, uploadImage } from '../../lib/media-upload';

export default function Profile() {
  const { api, profile, setProfile } = useSession();
  const [name, setName] = useState(profile?.displayName ?? '');
  const [email, setEmail] = useState(profile?.email ?? '');
  const [password, setPassword] = useState('');
  const [image, setImage] = useState<ImagePickerAsset | null>(null);
  const [pickError, setPickError] = useState<unknown>();
  const save = useMutation({
    mutationFn: () => {
      const service = createProfileApi(api);
      const patch = {
        displayName: name.trim(),
        ...(email.trim() && email.trim() !== profile?.email ? { email: email.trim() } : {}),
        ...(password ? { newPassword: password } : {}),
      };
      return image && profile
        ? service.updateProfileWithPhoto(patch, () => uploadImage(image, 'avatar-images', profile.id))
        : service.updateProfile(patch);
    },
    onSuccess: (updated) => {
      setProfile(updated);
      setPassword('');
      setImage(null);
    },
  });
  const imageUri = image?.uri ?? profile?.avatarUrl;

  function selectImage() {
    setPickError(undefined);
    void pickImage('library').then((picked) => { if (picked) setImage(picked); }).catch(setPickError);
  }

  return (
    <Screen title="Profile">
      {imageUri && <Image source={{ uri: imageUri }} accessibilityLabel="Profile photo"
        style={{ width: 86, height: 86, borderRadius: 43 }} />}
      {profile && <Card>
        {profile.age != null && <Body>Age · {profile.age}</Body>}
        {profile.heightCm != null && <Body>Height · {profile.heightCm} cm</Body>}
        {profile.currentWeightKg != null && <Body>Current weight · {profile.currentWeightKg} kg</Body>}
        {profile.goalWeightKg != null && <Body>Goal weight · {profile.goalWeightKg} kg</Body>}
        {profile.activityLevel && <Body>Activity level · {profile.activityLevel.replaceAll('_', ' ')}</Body>}
        {!!profile.conditionTypes?.length && <Body>Health conditions · {profile.conditionTypes.map((item) =>
          item.replaceAll('_', ' ')).join(', ')}</Body>}
      </Card>}
      <Action title="Choose photo" onPress={selectImage} />
      <Field label="Display name" value={name} onChangeText={setName} />
      <Field label="Email" value={email} onChangeText={setEmail} autoCapitalize="none" keyboardType="email-address" />
      <Field label="New password" value={password} onChangeText={setPassword} secureTextEntry />
      <Message error={pickError ?? save.error} />
      <Action title={save.isPending ? 'Saving…' : 'Save profile'} disabled={!name.trim() || save.isPending}
        onPress={() => save.mutate()} />
    </Screen>
  );
}
