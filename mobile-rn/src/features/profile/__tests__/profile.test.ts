import { createProfileApi, goalOptions } from '../api';

test('sends one of the eight goal slugs and returns the new nutrition targets', async () => {
  const profile = { id: 42, nutritionTargets: { targetCalories: 1850 } };
  const request = jest.fn().mockResolvedValue(profile);
  const api = createProfileApi({ request });
  expect(goalOptions).toHaveLength(8);
  await expect(api.updateGoal('weight_loss')).resolves.toEqual(profile);
  expect(request).toHaveBeenCalledWith('users/goal', { method: 'PATCH', body: { goalType: 'weight_loss' } });
});

test('does not patch the profile when image upload fails', async () => {
  const request = jest.fn();
  const upload = jest.fn().mockRejectedValue(new Error('Upload failed'));
  const api = createProfileApi({ request });
  await expect(api.updateProfileWithPhoto({ displayName: 'Lan' }, upload)).rejects.toThrow('Upload failed');
  expect(request).not.toHaveBeenCalled();
});
