import type { UserProfile } from '../account/api';

const options = [
  ['calories', 'totalCalories', 'calories', 'Calories', 'kcal'],
  ['carbs', 'totalCarbs', 'totalCarbohydratesG', 'Carbs', 'g'],
  ['fat', 'totalFat', 'totalFatG', 'Fat', 'g'],
  ['sugars', 'totalSugarsG', 'sugarsG', 'Sugars', 'g'],
  ['sodium', 'totalSodiumMg', 'sodiumMg', 'Sodium', 'mg'],
  ['saturatedfat', 'totalSaturatedFatG', 'saturatedFatG', 'Saturated fat', 'g'],
  ['cholesterol', 'totalCholesterolMg', 'cholesterolMg', 'Cholesterol', 'mg'],
  ['protein', 'totalProtein', 'proteinG', 'Protein', 'g'],
  ['fiber', 'totalDietaryFibersG', 'dietaryFibersG', 'Fiber', 'g'],
  ['potassium', 'totalPotassiumMg', 'potassiumMg', 'Potassium', 'mg'],
] as const;

type Totals = Partial<Record<(typeof options)[number][1], number>>;
export type Additions = Partial<Record<(typeof options)[number][2], number>>;

export function projectedWarnings(totals: Totals, added: Additions, profile?: UserProfile | null) {
  const calories = profile?.nutritionTargets?.targetCalories || 2220;
  const defaults: Record<string, number | undefined> = {
    calories,
    carbs: profile?.nutritionTargets?.carbsG,
    fat: profile?.nutritionTargets?.fatG,
    sugars: calories * 0.1 / 4,
    sodium: 2000,
    saturatedfat: calories * 0.1 / 9,
  };
  const format = new Intl.NumberFormat('en-US', { maximumFractionDigits: 1 });
  return options.flatMap(([key, totalKey, addKey, label, unit]) => {
    const custom = profile?.nutritionalThresholds?.find((item) =>
      item.nutrient.toLowerCase().replace(/[^a-z0-9]/g, '') === key && Number(item.maxAmount) > 0);
    const max = custom ? Number(custom.maxAmount) : defaults[key];
    const projected = (Number(totals[totalKey]) || 0) + (Number(added[addKey]) || 0);
    return max && projected > max ? [`${label} · ${format.format(projected)} of ${format.format(max)} ${custom?.unit || unit}`] : [];
  });
}
