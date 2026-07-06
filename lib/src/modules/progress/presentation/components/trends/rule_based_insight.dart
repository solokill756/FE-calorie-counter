import '../../../domain/models/progress_trends_models.dart';

String ruleBasedProgressInsight(ProgressTrendsResponse data) {
  final s = data.summary;
  final hasSignal = data.days.any(
    (d) => d.caloriesIn > 0 || d.waterMl > 0 || d.diaryCompleted || d.weightKg != null,
  );
  if (!hasSignal) {
    return 'Log meals, water, weight, or mark your diary complete to see trends over this period.';
  }
  if (s.adherenceScore >= 80) {
    return 'Strong consistency—diary, hydration, and calories are lining up with your goals.';
  }
  if (s.currentStreak >= 5) {
    return 'Impressive diary streak. Keeping the log complete makes long-term progress easier to see.';
  }
  if (s.adherenceScore < 45) {
    return 'Room to grow: try completing the diary more often and moving water closer to your daily target.';
  }
  return 'Check net calories against your target on the chart and adjust one habit at a time.';
}
