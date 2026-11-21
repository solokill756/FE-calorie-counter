import { weightChart } from '../api';
import { createExerciseApi } from '../../exercise/api';

test('supports both an empty chart and one recorded weight', () => {
  expect(weightChart([])).toEqual([]);
  const point = { id: 1, recordedAt: '2026-11-20T12:00:00.000Z', weightKg: 70 };
  expect(weightChart([point])).toEqual([{ ...point, relativeHeight: 0.5 }]);
});

test('deletes a workout log through the workout endpoint', async () => {
  const request = jest.fn();
  await createExerciseApi({ request }).removeLog(49);
  expect(request).toHaveBeenCalledWith('api/exercise-logs/49', { method: 'DELETE' });
});
