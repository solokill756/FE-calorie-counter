import { formatDisplayNumber } from '../format-display-number';

test.each([
  [0, '0'],
  [12, '12'],
  [12.3, '12.3'],
  [12.34567, '12.35'],
  [1.005, '1.01'],
  [0.1 + 0.2, '0.3'],
  [1 / 3, '0.33'],
  ['1234.5678', '1234.57'],
])('formats %s with up to two decimal places', (value, expected) => {
  expect(formatDisplayNumber(value)).toBe(expected);
});
