import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { fireEvent, render, screen, waitFor } from '@testing-library/react-native';
import HealthProfile from '../../../app/profile/health';
import type { UserProfile } from '../../account/api';
import { useSession } from '../../account/session';

jest.mock('../../account/session');

const useSessionMock = jest.mocked(useSession);
const savedProfile: UserProfile = {
  id: 7,
  displayName: 'Lan',
  isProfileComplete: true,
  age: 39,
  gender: 'legacy_value',
  heightCm: 165,
  conditionTypes: ['legacy_condition'],
  barriers: ['mixed nuts, raw'],
  mealSplits: { breakfast: 20, lunch: 40, dinner: 30, snack: 10 },
};

function openEditor(
  updated: UserProfile = savedProfile,
  profile = savedProfile,
  request = jest.fn().mockResolvedValue(updated),
) {
  const setProfile = jest.fn();
  const client = new QueryClient({
    defaultOptions: { queries: { gcTime: Infinity, retry: false }, mutations: { gcTime: Infinity } },
  });
  client.setQueryData(['dashboard', '2026-11-21'], {});
  useSessionMock.mockReturnValue({
    api: { request },
    account: { forgot: jest.fn(), reset: jest.fn(), deleteAccount: jest.fn() },
    error: null,
    profile,
    setProfile,
    restore: jest.fn(),
    signIn: jest.fn(),
    register: jest.fn(),
    signInWithProvider: jest.fn(),
    signOut: jest.fn(),
  });
  render(<QueryClientProvider client={client}><HealthProfile /></QueryClientProvider>);
  return { request, setProfile, client };
}

test('saves edited health fields and retains unknown conditions and opaque allergy text', async () => {
  const updated = {
    ...savedProfile, age: 40, conditionTypes: ['legacy_condition', 'diabetes'], barriers: ['mixed nuts, raw', 'Shellfish'],
  };
  const { request, setProfile, client } = openEditor(updated);

  expect(screen.getByText('Current value · legacy_value')).toBeTruthy();
  fireEvent.changeText(screen.getByLabelText('Age'), '40');
  fireEvent.press(screen.getByRole('button', { name: 'Diabetes' }));
  fireEvent.changeText(screen.getByLabelText('Add food allergy'), 'Shellfish');
  fireEvent.press(screen.getByRole('button', { name: 'Add allergy' }));
  fireEvent.press(screen.getByRole('button', { name: 'Save health profile' }));

  expect(await screen.findByText('Health profile saved.')).toBeTruthy();
  expect(request).toHaveBeenCalledWith('users/health-profile', {
    method: 'PATCH',
    body: { age: 40, conditionTypes: ['legacy_condition', 'diabetes'], allergies: ['mixed nuts, raw', 'Shellfish'] },
  });
  expect(setProfile).toHaveBeenCalledWith(updated);
  expect(client.getQueryState(['dashboard', '2026-11-21'])?.isInvalidated).toBe(true);
});

test('blocks saving meal splits until four whole percents total 100%', async () => {
  const { request } = openEditor();
  fireEvent.changeText(screen.getByLabelText('Breakfast (%)'), '21');
  expect(screen.getByText('Total · 101%')).toBeTruthy();
  fireEvent.press(screen.getByRole('button', { name: 'Save health profile' }));
  expect(request).not.toHaveBeenCalled();

  fireEvent.changeText(screen.getByLabelText('Breakfast (%)'), '20.5');
  fireEvent.changeText(screen.getByLabelText('Lunch (%)'), '39.5');
  fireEvent.press(screen.getByRole('button', { name: 'Save health profile' }));
  expect(request).not.toHaveBeenCalled();

  fireEvent.changeText(screen.getByLabelText('Breakfast (%)'), '30');
  fireEvent.changeText(screen.getByLabelText('Lunch (%)'), '30');
  fireEvent.press(screen.getByRole('button', { name: 'Save health profile' }));
  await waitFor(() => expect(request).toHaveBeenCalledWith('users/health-profile', {
    method: 'PATCH',
    body: { mealSplits: { breakfast: 30, lunch: 30, dinner: 30, snack: 10 } },
  }));
});

test('saves a reset as null and displays the server default splits', async () => {
  const updated = { ...savedProfile, mealSplits: { breakfast: 25, lunch: 35, dinner: 30, snack: 10 } };
  const { request } = openEditor(updated);
  fireEvent.press(screen.getByRole('button', { name: 'Reset meal splits to defaults' }));
  fireEvent.press(screen.getByRole('button', { name: 'Save health profile' }));

  expect(await screen.findByText('Health profile saved.')).toBeTruthy();
  expect(request).toHaveBeenCalledWith('users/health-profile', { method: 'PATCH', body: { mealSplits: null } });
  expect(screen.getByDisplayValue('25')).toBeTruthy();
  expect(screen.getByDisplayValue('35')).toBeTruthy();
});

test('blocks invalid body measurements and saves a valid decimal height', async () => {
  const { request } = openEditor();
  fireEvent.changeText(screen.getByLabelText('Age'), '131');
  expect(screen.getByRole('alert')).toHaveTextContent('Enter an age from 1 to 130 in whole years.');
  fireEvent.press(screen.getByRole('button', { name: 'Save health profile' }));
  expect(request).not.toHaveBeenCalled();

  fireEvent.changeText(screen.getByLabelText('Age'), '39');
  fireEvent.changeText(screen.getByLabelText('Height (cm)'), '301');
  expect(screen.getByRole('alert')).toHaveTextContent('Enter a height from 1 to 300 cm.');
  fireEvent.press(screen.getByRole('button', { name: 'Save health profile' }));
  expect(request).not.toHaveBeenCalled();

  fireEvent.changeText(screen.getByLabelText('Height (cm)'), '167,5');
  fireEvent.press(screen.getByRole('button', { name: 'Save health profile' }));
  await waitFor(() => expect(request).toHaveBeenCalledWith('users/health-profile', {
    method: 'PATCH',
    body: { heightCm: 167.5 },
  }));
});

test('saves an empty allergy or condition list when the last entry is removed', async () => {
  const { request } = openEditor();
  fireEvent.press(screen.getByRole('button', { name: 'Remove mixed nuts, raw' }));
  fireEvent.press(screen.getByRole('button', { name: '✓ legacy condition' }));
  fireEvent.press(screen.getByRole('button', { name: 'Save health profile' }));
  await waitFor(() => expect(request).toHaveBeenCalledWith('users/health-profile', {
    method: 'PATCH',
    body: { conditionTypes: [], allergies: [] },
  }));
});

test('retrieves a full profile after compact login before replacing conditions', async () => {
  const compactProfile = { ...savedProfile, barriers: [], conditionTypes: undefined };
  const updated = { ...savedProfile, conditionTypes: ['legacy_condition', 'diabetes'] };
  const request = jest.fn()
    .mockRejectedValueOnce(new Error('Profile temporarily unavailable'))
    .mockResolvedValueOnce({ ...savedProfile, id: 99 })
    .mockResolvedValueOnce(savedProfile)
    .mockResolvedValue(updated);
  const { setProfile } = openEditor(updated, compactProfile, request);

  expect(screen.queryByRole('button', { name: 'Save health profile' })).toBeNull();
  expect(await screen.findByText('Profile temporarily unavailable')).toBeTruthy();
  fireEvent.press(screen.getByRole('button', { name: 'Try again' }));
  expect(await screen.findByText('The full health profile could not be loaded.')).toBeTruthy();
  expect(screen.queryByRole('button', { name: 'Diabetes' })).toBeNull();
  fireEvent.press(screen.getByRole('button', { name: 'Try again' }));

  expect(await screen.findByRole('button', { name: '✓ legacy condition' })).toBeTruthy();
  expect(screen.getByRole('button', { name: 'Remove mixed nuts, raw' })).toBeTruthy();
  fireEvent.press(screen.getByRole('button', { name: 'Diabetes' }));
  fireEvent.press(screen.getByRole('button', { name: 'Save health profile' }));

  await waitFor(() => expect(setProfile).toHaveBeenCalledWith(updated));
  expect(request.mock.calls.slice(0, 4).map(([path]) => path)).toEqual([
    'auth/me', 'auth/me', 'auth/me', 'users/health-profile',
  ]);
  expect(request).toHaveBeenNthCalledWith(4, 'users/health-profile', {
    method: 'PATCH', body: { conditionTypes: ['legacy_condition', 'diabetes'] },
  });
});
