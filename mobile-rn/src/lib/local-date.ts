const dateFormat = /^\d{4}-\d{2}-\d{2}$/;

export function localDateKey(date: Date): string {
  const year = String(date.getFullYear()).padStart(4, '0');
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
}

export function parseLocalDate(key: string): Date | undefined {
  if (!dateFormat.test(key)) return undefined;
  const [year, month, day] = key.split('-').map(Number);
  const date = new Date();
  date.setFullYear(year, month - 1, day);
  return localDateKey(date) === key ? date : undefined;
}

export function nextDate(key: string, offset: number) {
  const date = parseLocalDate(key) ?? new Date();
  date.setDate(date.getDate() + offset);
  return localDateKey(date);
}
