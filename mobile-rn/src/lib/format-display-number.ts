const displayNumberFormat = new Intl.NumberFormat('en', {
  maximumFractionDigits: 2,
  useGrouping: false,
});

export function formatDisplayNumber(value: number | string): string {
  return displayNumberFormat.format(Number(value));
}
