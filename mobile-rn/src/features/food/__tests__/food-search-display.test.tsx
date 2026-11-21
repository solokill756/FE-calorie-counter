import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { fireEvent, render, screen, waitFor } from '@testing-library/react-native';
import SearchFood from '../../../app/food/search';
import { logFoodAndRefresh } from '../../diary/api';

const mockSearchFoods = jest.fn(async (_query: string, page: number, filters?: object) => {
  if (filters) return {
    total: 21,
    items: page === 1
      ? Array.from({ length: 20 }, (_, index) => ({ id: index + 1, description: index === 0 ? 'Oats' : `Oats ${index}` }))
      : [{ id: 21, description: 'Oat bran' }],
  };
  return {
    items: [{ id: 1, description: 'Banana', calories: 12.34567, proteinG: 0.1 + 0.2, servingSize: 120.34567, servingUnit: 'g' }],
  };
});

jest.mock('expo-router', () => ({
  router: { back: jest.fn() },
  useLocalSearchParams: () => ({ date: '2026-11-21', meal: 'breakfast' }),
}));
jest.mock('../../account/session', () => ({ useSession: () => ({ api: {}, profile: {} }) }));
jest.mock('../warning-dialog', () => ({ confirmNutritionLog: jest.fn().mockResolvedValue(true) }));
jest.mock('../../diary/api', () => ({
  ...jest.requireActual('../../diary/api'),
  createDiaryApi: () => ({
    searchFoods: (...args: Parameters<typeof mockSearchFoods>) => mockSearchFoods(...args),
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

test('applies nutrient bounds with text search, retains them on later pages, and clears them', async () => {
  const client = new QueryClient({ defaultOptions: { queries: { gcTime: Infinity } } });
  render(<QueryClientProvider client={client}><SearchFood /></QueryClientProvider>);

  expect(await screen.findByText('Banana')).toBeOnTheScreen();
  fireEvent.changeText(screen.getByLabelText('Search foods'), 'oats');
  fireEvent.press(screen.getByRole('button', { name: 'Nutrient filters' }));
  fireEvent.changeText(screen.getByLabelText('Minimum Protein (g)'), '20');
  fireEvent.changeText(screen.getByLabelText('Maximum Protein (g)'), '10');
  expect(screen.getByRole('button', { name: 'Apply filters' })).toBeDisabled();
  fireEvent.changeText(screen.getByLabelText('Maximum Protein (g)'), '');
  fireEvent.press(screen.getByRole('button', { name: 'Sugars' }));
  fireEvent.changeText(screen.getByLabelText('Maximum Sugars (g)'), '5,5');
  fireEvent.press(screen.getByRole('button', { name: 'Apply filters' }));

  const bounds = { proteinG: { min: 20 }, sugarsG: { max: 5.5 } };
  expect(await screen.findByText('Oats')).toBeOnTheScreen();
  expect(mockSearchFoods).toHaveBeenLastCalledWith('oats', 1, bounds);
  expect(screen.queryByText('Banana')).toBeNull();

  fireEvent.press(screen.getByRole('button', { name: 'Load more' }));
  expect(await screen.findByText('Oat bran')).toBeOnTheScreen();
  expect(mockSearchFoods).toHaveBeenLastCalledWith('oats', 2, bounds);
  expect(screen.queryByRole('button', { name: 'Load more' })).toBeNull();

  fireEvent.press(screen.getByRole('button', { name: 'Nutrient filters (2)' }));
  fireEvent.press(screen.getByRole('button', { name: 'Clear filters' }));
  expect(await screen.findByText('Banana')).toBeOnTheScreen();
  expect(mockSearchFoods).toHaveBeenLastCalledWith('oats', 1, undefined);
});
