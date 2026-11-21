import { nutritionCsv } from '../export';
import { createWaterApi } from '../../water/api';

test('exports escaped food names on their recorded local date', () => {
  expect(nutritionCsv([{ foodName: 'Soup, "spicy"', loggedOn: '2026-11-21', loggedAt: '2026-11-22T01:00:00.000Z', meal: 'dinner' }]))
    .toContain('2026-11-21,dinner,"Soup, ""spicy"""');
});

test('uses additive and absolute water endpoints independently', async () => {
  const request = jest.fn();
  const api = createWaterApi({ request });
  await api.add(250, '2026-11-21');
  await api.set(0);
  expect(request.mock.calls).toEqual([
    ['api/water-log/add', { method: 'POST', body: { amountMl: 250, date: '2026-11-21' } }],
    ['api/water-log/today', { method: 'PUT', body: { amountMl: 0 } }],
  ]);
});
