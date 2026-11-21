type ScheduledMeal = { identifier: string; time: number };

export function reconcileMealReminders(now: Date, scheduled: ScheduledMeal[]) {
  const wanted = Array.from({ length: 6 }, (_, index) => {
    const next = new Date(now.getFullYear(), now.getMonth(), now.getDate() + index + 1);
    return next.getTime();
  });
  const kept = new Set<number>();
  const remove: string[] = [];
  for (const reminder of scheduled) {
    if (!wanted.includes(reminder.time) || kept.has(reminder.time)) {
      remove.push(reminder.identifier);
    } else {
      kept.add(reminder.time);
    }
  }
  return { remove, add: wanted.filter((time) => !kept.has(time)) };
}
