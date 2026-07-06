DateTime _parseApiDateTimeLocal(Object? value) {
  return DateTime.parse((value ?? '').toString()).toLocal();
}

class ExerciseItem {
  const ExerciseItem({
    required this.id,
    required this.name,
    required this.type,
    this.met,
    this.defaultCalPerMin,
    this.notes,
    this.isVerified = false,
    this.isOwned = false,
  });

  final int id;
  final String name;
  final String type;
  final double? met;
  final double? defaultCalPerMin;
  final String? notes;
  final bool isVerified;
  final bool isOwned;

  factory ExerciseItem.fromJson(Map<String, dynamic> json) {
    return ExerciseItem(
      id: (json['id'] as num).toInt(),
      name: (json['name'] as String?) ?? '',
      type: (json['type'] as String?) ?? 'cardio',
      met: (json['met'] as num?)?.toDouble(),
      defaultCalPerMin: (json['defaultCalPerMin'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      isVerified: json['isVerified'] == true,
      isOwned: json['isOwned'] == true,
    );
  }
}

class ExerciseListPage {
  const ExerciseListPage({
    required this.items,
    required this.page,
    required this.limit,
    required this.total,
  });

  final List<ExerciseItem> items;
  final int page;
  final int limit;
  final int total;

  factory ExerciseListPage.fromJson(Map<String, dynamic> json) {
    final raw = json['items'] as List<dynamic>? ?? [];
    return ExerciseListPage(
      items: raw
          .map((e) => ExerciseItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
      total: (json['total'] as num?)?.toInt() ?? 0,
    );
  }
}

class ExerciseSummaryToday {
  const ExerciseSummaryToday({
    required this.date,
    required this.totalCaloriesBurned,
    required this.totalMinutes,
    required this.totalLogs,
    this.items = const [],
  });

  final String date;
  final double totalCaloriesBurned;
  final double totalMinutes;
  final int totalLogs;
  final List<ExerciseLogListItem> items;

  factory ExerciseSummaryToday.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List<dynamic>? ?? [];
    return ExerciseSummaryToday(
      date: (json['date'] as String?) ?? '',
      totalCaloriesBurned:
          (json['totalCaloriesBurned'] as num?)?.toDouble() ?? 0,
      totalMinutes: (json['totalMinutes'] as num?)?.toDouble() ?? 0,
      totalLogs: (json['totalLogs'] as num?)?.toInt() ?? 0,
      items: rawItems
          .map((e) => ExerciseLogListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ExerciseLogListItem {
  const ExerciseLogListItem({
    required this.id,
    required this.exerciseId,
    required this.exerciseName,
    required this.exerciseType,
    required this.startedAt,
    required this.minutesPerformed,
    required this.caloriesBurned,
    required this.source,
  });

  final int id;
  final int exerciseId;
  final String exerciseName;
  final String? exerciseType;
  final DateTime startedAt;
  final double minutesPerformed;
  final double caloriesBurned;
  final String source;

  factory ExerciseLogListItem.fromJson(Map<String, dynamic> json) {
    return ExerciseLogListItem(
      id: (json['id'] as num).toInt(),
      exerciseId: (json['exerciseId'] as num).toInt(),
      exerciseName: (json['exerciseName'] as String?) ?? '',
      exerciseType: json['exerciseType'] as String?,
      startedAt: _parseApiDateTimeLocal(json['startedAt']),
      minutesPerformed: (json['minutesPerformed'] as num?)?.toDouble() ?? 0,
      caloriesBurned: (json['caloriesBurned'] as num?)?.toDouble() ?? 0,
      source: (json['source'] as String?) ?? 'manual',
    );
  }
}

class ExerciseLogListPage {
  const ExerciseLogListPage({
    required this.items,
    required this.page,
    required this.limit,
    required this.total,
  });

  final List<ExerciseLogListItem> items;
  final int page;
  final int limit;
  final int total;

  factory ExerciseLogListPage.fromJson(Map<String, dynamic> json) {
    final raw = json['items'] as List<dynamic>? ?? [];
    return ExerciseLogListPage(
      items: raw
          .map((e) => ExerciseLogListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      page: (json['page'] as num?)?.toInt() ?? 1,
      limit: (json['limit'] as num?)?.toInt() ?? 20,
      total: (json['total'] as num?)?.toInt() ?? 0,
    );
  }
}

class ExerciseLogCreated {
  const ExerciseLogCreated({
    required this.id,
    required this.userId,
    required this.exercise,
    required this.startedAt,
    required this.minutesPerformed,
    required this.caloriesBurned,
    required this.source,
    required this.capturedAt,
  });

  final int id;
  final int userId;
  final ExerciseItem exercise;
  final DateTime startedAt;
  final double minutesPerformed;
  final double caloriesBurned;
  final String source;
  final DateTime capturedAt;

  factory ExerciseLogCreated.fromJson(Map<String, dynamic> json) {
    final ex = json['exercise'] as Map<String, dynamic>? ?? {};
    return ExerciseLogCreated(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      exercise: ExerciseItem.fromJson(ex),
      startedAt: _parseApiDateTimeLocal(json['startedAt']),
      minutesPerformed: (json['minutesPerformed'] as num?)?.toDouble() ?? 0,
      caloriesBurned: (json['caloriesBurned'] as num?)?.toDouble() ?? 0,
      source: (json['source'] as String?) ?? 'manual',
      capturedAt: _parseApiDateTimeLocal(json['capturedAt']),
    );
  }
}
