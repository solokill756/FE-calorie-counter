/// API: GET api/progress/trends
class ProgressTrendDay {
  const ProgressTrendDay({
    required this.date,
    required this.weightKg,
    required this.caloriesIn,
    required this.caloriesBurned,
    required this.netCalories,
    required this.waterMl,
    required this.diaryCompleted,
    required this.calorieTarget,
  });

  final String date;
  final double? weightKg;
  final int caloriesIn;
  final int caloriesBurned;
  final int netCalories;
  final int waterMl;
  final bool diaryCompleted;
  final int calorieTarget;

  factory ProgressTrendDay.fromJson(Map<String, dynamic> json) {
    return ProgressTrendDay(
      date: json['date'] as String? ?? '',
      weightKg: (json['weightKg'] as num?)?.toDouble(),
      caloriesIn: (json['caloriesIn'] as num?)?.round() ?? 0,
      caloriesBurned: (json['caloriesBurned'] as num?)?.round() ?? 0,
      netCalories: (json['netCalories'] as num?)?.round() ?? 0,
      waterMl: (json['waterMl'] as num?)?.round() ?? 0,
      diaryCompleted: json['diaryCompleted'] as bool? ?? false,
      calorieTarget: (json['calorieTarget'] as num?)?.round() ?? 0,
    );
  }
}

class ProgressTrendsSummary {
  const ProgressTrendsSummary({
    required this.adherenceScore,
    required this.currentStreak,
    required this.bestStreak,
  });

  final int adherenceScore;
  final int currentStreak;
  final int bestStreak;

  factory ProgressTrendsSummary.fromJson(Map<String, dynamic> json) {
    return ProgressTrendsSummary(
      adherenceScore: (json['adherenceScore'] as num?)?.round() ?? 0,
      currentStreak: (json['currentStreak'] as num?)?.round() ?? 0,
      bestStreak: (json['bestStreak'] as num?)?.round() ?? 0,
    );
  }
}

class ProgressTrendsResponse {
  const ProgressTrendsResponse({
    required this.days,
    required this.summary,
  });

  final List<ProgressTrendDay> days;
  final ProgressTrendsSummary summary;

  factory ProgressTrendsResponse.fromJson(Map<String, dynamic> json) {
    final rawDays = json['days'];
    final days = rawDays is List<dynamic>
        ? rawDays
              .whereType<Map<String, dynamic>>()
              .map(ProgressTrendDay.fromJson)
              .toList()
        : <ProgressTrendDay>[];
    final sum = json['summary'];
    return ProgressTrendsResponse(
      days: days,
      summary: sum is Map<String, dynamic>
          ? ProgressTrendsSummary.fromJson(sum)
          : const ProgressTrendsSummary(
              adherenceScore: 0,
              currentStreak: 0,
              bestStreak: 0,
            ),
    );
  }
}
