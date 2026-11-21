export const foodFilterNutrients = [
  { key: 'proteinG', label: 'Protein', unit: 'g' },
  { key: 'totalCarbohydratesG', label: 'Carbs', unit: 'g' },
  { key: 'totalFatG', label: 'Fat', unit: 'g' },
  { key: 'dietaryFibersG', label: 'Fiber', unit: 'g' },
  { key: 'sugarsG', label: 'Sugars', unit: 'g' },
  { key: 'saturatedFatG', label: 'Saturated fat', unit: 'g' },
  { key: 'sodiumMg', label: 'Sodium', unit: 'mg' },
] as const;

export type FoodFilterNutrient = (typeof foodFilterNutrients)[number]['key'];
export type FoodNutrientFilters = Partial<Record<FoodFilterNutrient, { min?: number; max?: number }>>;
export type NutrientFilterDraft = Partial<Record<FoodFilterNutrient, { min?: string; max?: string }>>;

function parseBound(input?: string) {
  const value = input?.trim();
  if (!value) return undefined;
  if (!/^(?:\d+(?:[.,]\d*)?|[.,]\d+)(?:e[+-]?\d+)?$/i.test(value)) return NaN;
  const amount = Number(value.replace(',', '.'));
  return Number.isFinite(amount) ? amount : NaN;
}

export function toNutrientFilterDraft(filters?: FoodNutrientFilters): NutrientFilterDraft {
  const draft: NutrientFilterDraft = {};
  for (const { key } of foodFilterNutrients) {
    const bounds = filters?.[key];
    if (bounds) {
      draft[key] = {
        min: bounds.min?.toString(),
        max: bounds.max?.toString(),
      };
    }
  }
  return draft;
}

export function parseNutrientFilterDraft(draft: NutrientFilterDraft):
  { filters: FoodNutrientFilters; error?: never } | { error: string; filters?: never } {
  const filters: FoodNutrientFilters = {};
  for (const { key, label } of foodFilterNutrients) {
    const min = parseBound(draft[key]?.min);
    const max = parseBound(draft[key]?.max);
    if (Number.isNaN(min) || Number.isNaN(max)) {
      return { error: `${label} limits must be non-negative numbers.` };
    }
    if (min !== undefined && max !== undefined && min > max) {
      return { error: `${label} minimum must be at most the maximum.` };
    }
    if (min !== undefined || max !== undefined) filters[key] = { min, max };
  }
  return { filters };
}
