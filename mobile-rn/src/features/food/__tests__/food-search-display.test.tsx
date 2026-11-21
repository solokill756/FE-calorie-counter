import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { fireEvent, render, screen, waitFor } from '@testing-library/react-native';
import SearchFood from '../../../app/food/search';
import { logFoodAndRefresh } from '../../diary/api';

jest.mock('expo-router', () => ({
  router: { back: jest.fn() },
  useLocalSearchParams: () => ({ date: '2026-11-21', meal: 'breakfast' }),
}));
jest.mock('../../account/session', () => ({ useSession: () => ({ api: {}, profile: {} }) }));
jest.mock('../warning-dialog', () => ({ confirmNutritionLog: jest.fn().mockResolvedValue(true) }));
jest.mock('../../diary/api', () => ({
  ...jest.requireActual('../../diary/api'),
  createDiaryApi: () => ({
    searchFoods: async () => ({
      items: [{ id: 1, description: 'Banana', calories: 12.34567, proteinG: 0.1 + 0.2, servingSize: 120.34567, servingUnit: 'g' }],
    }),
    recentFoods: async () => [],
  }),
  logFoodAndRefresh: jest.fn().mockResolvedValue(undefined),
}));

test('rounds food labels while keeping full serving precision in the diary request', async () => {
  const client = new QueryClient({ defaultOptions: { queries: { gcTime: Infinity }, mutations: { gcTime: Infinity } } });
  render(<QueryClientProvider client={client}><SearchFood /></QueryClientProvider>);

  expect(await screen.findByText('12.35 kcal')).toBeOnTheScreen();
  fireEvent.press(screen.getByRole('button', { name: 'Select' }));
  expect(screen.getByText('Protein · 0.3 g')).toBeOnTheScreen();
  fireEvent.press(screen.getByRole('button', { name: 'Add to diary' }));
  await waitFor(() => expect(logFoodAndRefresh).toHaveBeenCalledWith(expect.anything(), client,
    expect.objectContaining({ foodId: 1, servingSize: 120.34567 })));
});
