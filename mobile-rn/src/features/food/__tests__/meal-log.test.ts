import { createFoodApi } from '../api';
test('logs quick calories for the selected meal and date', async () => {
  const request = jest.fn();
  await createFoodApi({ request }).quickAdd('2026-11-21', 'lunch', { calories: 250, proteinG: 14 });
  expect(request).toHaveBeenCalledWith('api/LogFood', {
    method: 'POST',
    body: expect.objectContaining({ loggedOn: '2026-11-21', meal: 'lunch', type: 'quickAdd', calories: 250, proteinG: 14 }),
  });
});
