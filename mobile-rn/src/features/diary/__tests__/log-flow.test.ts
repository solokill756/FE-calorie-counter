import { QueryClient } from '@tanstack/react-query';
import { localDateKey } from '../../../lib/local-date';
import { createDiaryApi, logFoodAndRefresh } from '../api';

test('preserves selected local day instead of slicing the UTC timestamp', () => {
  expect(localDateKey(new Date(2026, 10, 21, 0, 5))).toBe('2026-11-21');
  expect(localDateKey(new Date(2026, 10, 21, 23, 55))).toBe('2026-11-21');
});

test('records the selected food portion and invalidates both views after saving', async () => {
  const queryClient = new QueryClient({ defaultOptions: { queries: { gcTime: Infinity } } });
  queryClient.setQueryData(['diary', '2026-11-21'], { totalCalories: 0 });
  queryClient.setQueryData(['dashboard', '2026-11-21'], { calories: { consumed: 0 } });
  const request = jest.fn().mockResolvedValue(undefined);
  const api = createDiaryApi({ request });

  await logFoodAndRefresh(api, queryClient, {
    foodId: 27,
    meal: 'lunch',
    quantity: 1.5,
    servingSize: 30,
    date: new Date(2026, 10, 21, 12, 0),
  });

  expect(request).toHaveBeenCalledWith('api/LogFood', {
    method: 'POST',
    body: {
      foodId: 27,
      meal: 'lunch',
      type: 'regular',
      numberOfServings: 1.5,
      servingSize: 30,
      loggedOn: '2026-11-21',
      LoggedAt: new Date(2026, 10, 21, 12, 0).toISOString(),
    },
  });
  expect(queryClient.getQueryState(['diary', '2026-11-21'])?.isInvalidated).toBe(true);
  expect(queryClient.getQueryState(['dashboard', '2026-11-21'])?.isInvalidated).toBe(true);
});

test('writes notes and completion using the selected day key', async () => {
  const request = jest.fn();
  const api = createDiaryApi({ request });
  const date = new Date(2026, 10, 21, 22, 0);
  await api.updateNote(date, 'A note');
  await api.complete(date);
  expect(request.mock.calls).toEqual([
    ['api/Diary/note', { method: 'PUT', body: { date: '2026-11-21', note: 'A note' } }],
    ['api/Diary/status', { method: 'POST', body: { date: '2026-11-21', isCompleted: true } }],
  ]);
});
