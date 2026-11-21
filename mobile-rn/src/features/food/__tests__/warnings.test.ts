import { projectedWarnings } from '../warnings';

test('checks the account-specific nutrient cap before logging', () => {
  expect(projectedWarnings(
    { totalCalories: 1500, totalSodiumMg: 1300 },
    { calories: 150, sodiumMg: 300 },
    {
      id: 7, displayName: 'Lan', isProfileComplete: true,
      nutritionTargets: { targetCalories: 1900, proteinG: 100, carbsG: 200, fatG: 60 },
      nutritionalThresholds: [{ nutrient: 'sodium', maxAmount: 1500, unit: 'mg' }],
    },
  )).toEqual(['Sodium · 1,600 of 1,500 mg']);
});
