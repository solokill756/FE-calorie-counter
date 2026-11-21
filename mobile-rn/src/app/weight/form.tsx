import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import type { ImagePickerAsset } from 'expo-image-picker';
import { router, useLocalSearchParams } from 'expo-router';
import { useState } from 'react';
import { Image } from 'react-native';
import { Action, Field, Loading, Message, Screen } from '../../components/ui';
import { useSession } from '../../features/account/session';
import { createProgressApi, type WeightEntry } from '../../features/progress/api';
import { localDateKey, parseLocalDate } from '../../lib/local-date';
import { pickImage, uploadImage } from '../../lib/media-upload';

export default function WeightEditor() {
  const { api } = useSession();
  const { id } = useLocalSearchParams<{ id?: string }>();
  const entry = useQuery({
    queryKey: ['progress', 'weight', id], enabled: Boolean(id),
    queryFn: () => api.request<WeightEntry>(`api/Weight/${Number(id)}`),
  });
  if (id && entry.isPending) return <Screen title="Weight"><Loading /></Screen>;
  if (entry.error) return <Screen title="Weight"><Message error={entry.error} retry={() => void entry.refetch()} /></Screen>;
  return <WeightForm entry={entry.data} />;
}

function WeightForm({ entry }: { entry?: WeightEntry }) {
  const { api, profile, restore } = useSession();
  const client = useQueryClient();
  const [date, setDate] = useState(() => localDateKey(entry ? new Date(entry.recordedAt) : new Date()));
  const [weight, setWeight] = useState(entry ? String(entry.weightKg) : '');
  const [image, setImage] = useState<ImagePickerAsset>();
  const [photoError, setPhotoError] = useState<unknown>();
  const day = parseLocalDate(date);
  const kg = Number(weight.trim().replace(',', '.'));
  const save = useMutation({
    mutationFn: async () => {
      if (!day) throw new Error('Enter a valid date.');
      const photoUrl = image && profile ? await uploadImage(image, 'weight', profile.id) : entry?.photoUrl;
      const recordedAt = entry && localDateKey(new Date(entry.recordedAt)) === date ? entry.recordedAt : day.toISOString();
      return createProgressApi(api).save({ weightKg: kg, recordedAt, photoUrl }, entry?.id);
    },
    onSuccess: async () => {
      await Promise.all([client.invalidateQueries(), restore()]);
      router.back();
    },
  });
  function select(source: 'library' | 'camera') {
    setPhotoError(undefined);
    void pickImage(source).then((asset) => { if (asset) setImage(asset); }).catch(setPhotoError);
  }
  const photoUri = image?.uri ?? entry?.photoUrl;
  return (
    <Screen title={entry ? 'Edit weight' : 'Record weight'}>
      <Field label="Date (YYYY-MM-DD)" value={date} onChangeText={setDate} />
      <Field label="Weight (kg)" value={weight} onChangeText={setWeight} keyboardType="decimal-pad" />
      {photoUri && <Image source={{ uri: photoUri }} style={{ height: 180, borderRadius: 12 }} />}
      <Action title="Take photo" onPress={() => select('camera')} />
      <Action title="Choose photo" onPress={() => select('library')} />
      <Message error={photoError ?? save.error} />
      <Action title="Save weight" disabled={!day || !Number.isFinite(kg) || kg <= 0 || save.isPending} onPress={() => save.mutate()} />
    </Screen>
  );
}
