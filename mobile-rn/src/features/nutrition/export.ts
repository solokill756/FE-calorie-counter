import { nutrientFields } from './fields';

export type ExportLog = {
  loggedOn?: string;
  loggedAt?: string;
  LoggedAt?: string;
  date?: string;
  meal?: string;
  mealType?: string;
  foodName?: string;
  food?: { description?: string };
  servingSize?: number;
  numberOfServings?: number;
} & Partial<Record<(typeof nutrientFields)[number][0], number | string>>;

function escapeCell(value: unknown) {
  const raw = String(value ?? '');
  const text = typeof value === 'string' && /^[\t\r\n ]*[=+@-]/.test(raw) ? `'${raw}` : raw;
  return /[,"\n\r]/.test(text) ? `"${text.replaceAll('"', '""')}"` : text;
}

function day(log: ExportLog) {
  return (log.loggedOn ?? log.date ?? log.loggedAt ?? log.LoggedAt ?? '').slice(0, 10);
}

export function nutritionCsv(items: ExportLog[]) {
  const headings = ['Date', 'Meal', 'Food Name', ...nutrientFields.map(([, , label, unit]) => `${label} (${unit})`),
    'Serving Size', 'Servings'];
  const logs = [...items].sort((first, second) => day(first).localeCompare(day(second)));
  const rows = logs.map((log) => [
    day(log), log.meal ?? log.mealType, log.foodName ?? log.food?.description,
    ...nutrientFields.map(([key]) => log[key] ?? 0), log.servingSize ?? 0, log.numberOfServings ?? 0,
  ]);
  return [headings, ...rows].map((row) => row.map(escapeCell).join(',')).join('\r\n') + '\r\n';
}
