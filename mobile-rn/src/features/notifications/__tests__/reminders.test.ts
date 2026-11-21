import { reconcileMealReminders } from '../reminders';

test('keeps an existing reminder and removes stale or duplicate times', () => {
  const now = new Date(2026, 10, 21, 10, 0);
  const next = new Date(2026, 10, 22, 0, 0).getTime();
  const plan = reconcileMealReminders(now, [
    { identifier: 'meal-1', time: next },
    { identifier: 'meal-duplicate', time: next },
    { identifier: 'meal-old', time: now.getTime() - 60_000 },
  ]);
  expect(plan.remove).toEqual(['meal-duplicate', 'meal-old']);
  expect(plan.add).toHaveLength(5);
  expect(plan.add).not.toContain(next);
});
