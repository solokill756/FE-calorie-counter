/// Aggregated dashboard payload from `GET api/dashboard/today`.
class DashboardTodayResponse {
  const DashboardTodayResponse({
    required this.date,
    required this.user,
    required this.calories,
    required this.macros,
    required this.exercise,
    required this.water,
    required this.weight,
    required this.alerts,
    required this.aiSuggestion,
    required this.checklist,
    this.micronutrients = const {},
  });

  final String date;
  final DashboardUserSummary user;
  final DashboardCaloriesSection calories;
  final DashboardMacrosSection macros;
  final DashboardExerciseSection exercise;
  final DashboardWaterSection water;
  final DashboardWeightSection weight;
  final List<DashboardAlertItem> alerts;
  final DashboardAiSuggestion aiSuggestion;
  final DashboardChecklist checklist;
  final Map<String, num> micronutrients;

  DashboardTodayResponse copyWith({DashboardAiSuggestion? aiSuggestion}) {
    return DashboardTodayResponse(
      date: date,
      user: user,
      calories: calories,
      macros: macros,
      exercise: exercise,
      water: water,
      weight: weight,
      alerts: alerts,
      aiSuggestion: aiSuggestion ?? this.aiSuggestion,
      checklist: checklist,
      micronutrients: micronutrients,
    );
  }

  factory DashboardTodayResponse.fromJson(Map<String, dynamic> json) {
    final rawMicro = json['micronutrients'] as Map<String, dynamic>? ?? const {};
    return DashboardTodayResponse(
      date: json['date'] as String? ?? '',
      user: DashboardUserSummary.fromJson(
        json['user'] as Map<String, dynamic>? ?? const {},
      ),
      calories: DashboardCaloriesSection.fromJson(
        json['calories'] as Map<String, dynamic>? ?? const {},
      ),
      macros: DashboardMacrosSection.fromJson(
        json['macros'] as Map<String, dynamic>? ?? const {},
      ),
      exercise: DashboardExerciseSection.fromJson(
        json['exercise'] as Map<String, dynamic>? ?? const {},
      ),
      water: DashboardWaterSection.fromJson(
        json['water'] as Map<String, dynamic>? ?? const {},
      ),
      weight: DashboardWeightSection.fromJson(
        json['weight'] as Map<String, dynamic>? ?? const {},
      ),
      alerts: (json['alerts'] as List<dynamic>? ?? const [])
          .map((e) => DashboardAlertItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      aiSuggestion: DashboardAiSuggestion.fromJson(
        json['aiSuggestion'] as Map<String, dynamic>? ?? const {},
      ),
      checklist: DashboardChecklist.fromJson(
        json['checklist'] as Map<String, dynamic>? ?? const {},
      ),
      micronutrients: rawMicro.map((k, v) => MapEntry(k, (v as num?) ?? 0)),
    );
  }
}

class DashboardUserSummary {
  const DashboardUserSummary({
    required this.id,
    required this.displayName,
    this.avatarUrl,
  });

  final int id;
  final String displayName;
  final String? avatarUrl;

  factory DashboardUserSummary.fromJson(Map<String, dynamic> json) {
    return DashboardUserSummary(
      id: (json['id'] as num?)?.toInt() ?? 0,
      displayName: json['displayName'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String?,
    );
  }
}

class DashboardCaloriesSection {
  const DashboardCaloriesSection({
    required this.target,
    required this.consumed,
    required this.burned,
    required this.net,
    required this.remaining,
    required this.status,
  });

  final int target;
  final int consumed;
  final int burned;
  final int net;
  final int remaining;
  final String status;

  factory DashboardCaloriesSection.fromJson(Map<String, dynamic> json) {
    return DashboardCaloriesSection(
      target: (json['target'] as num?)?.round() ?? 0,
      consumed: (json['consumed'] as num?)?.round() ?? 0,
      burned: (json['burned'] as num?)?.round() ?? 0,
      net: (json['net'] as num?)?.round() ?? 0,
      remaining: (json['remaining'] as num?)?.round() ?? 0,
      status: json['status'] as String? ?? 'on_track',
    );
  }
}

class DashboardMacroPair {
  const DashboardMacroPair({required this.current, required this.target});

  final double current;
  final double target;

  factory DashboardMacroPair.fromJson(Map<String, dynamic> json) {
    return DashboardMacroPair(
      current: (json['current'] as num?)?.toDouble() ?? 0,
      target: (json['target'] as num?)?.toDouble() ?? 0,
    );
  }
}

class DashboardMacrosSection {
  const DashboardMacrosSection({
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  final DashboardMacroPair protein;
  final DashboardMacroPair carbs;
  final DashboardMacroPair fat;

  factory DashboardMacrosSection.fromJson(Map<String, dynamic> json) {
    return DashboardMacrosSection(
      protein: DashboardMacroPair.fromJson(
        json['protein'] as Map<String, dynamic>? ?? const {},
      ),
      carbs: DashboardMacroPair.fromJson(
        json['carbs'] as Map<String, dynamic>? ?? const {},
      ),
      fat: DashboardMacroPair.fromJson(
        json['fat'] as Map<String, dynamic>? ?? const {},
      ),
    );
  }
}

class DashboardExerciseSection {
  const DashboardExerciseSection({
    required this.caloriesBurned,
    required this.minutes,
    required this.workoutCount,
  });

  final int caloriesBurned;
  final int minutes;
  final int workoutCount;

  factory DashboardExerciseSection.fromJson(Map<String, dynamic> json) {
    return DashboardExerciseSection(
      caloriesBurned: (json['caloriesBurned'] as num?)?.round() ?? 0,
      minutes: (json['minutes'] as num?)?.round() ?? 0,
      workoutCount: (json['workoutCount'] as num?)?.toInt() ?? 0,
    );
  }
}

class DashboardWaterSection {
  const DashboardWaterSection({
    required this.currentMl,
    required this.targetMl,
  });

  final int currentMl;
  final int targetMl;

  factory DashboardWaterSection.fromJson(Map<String, dynamic> json) {
    return DashboardWaterSection(
      currentMl: (json['currentMl'] as num?)?.round() ?? 0,
      targetMl: (json['targetMl'] as num?)?.round() ?? 2500,
    );
  }
}

class DashboardWeightPoint {
  const DashboardWeightPoint({required this.date, required this.weightKg});

  final String date;
  final double weightKg;

  factory DashboardWeightPoint.fromJson(Map<String, dynamic> json) {
    return DashboardWeightPoint(
      date: json['date'] as String? ?? '',
      weightKg: (json['weightKg'] as num?)?.toDouble() ?? 0,
    );
  }
}

class DashboardWeightSection {
  const DashboardWeightSection({
    this.startKg,
    this.currentKg,
    this.goalKg,
    required this.totalChangeKg,
    required this.weeklyChangeKg,
    required this.history,
  });

  final double? startKg;
  final double? currentKg;
  final double? goalKg;
  final double totalChangeKg;
  final double weeklyChangeKg;
  final List<DashboardWeightPoint> history;

  factory DashboardWeightSection.fromJson(Map<String, dynamic> json) {
    return DashboardWeightSection(
      startKg: (json['startKg'] as num?)?.toDouble(),
      currentKg: (json['currentKg'] as num?)?.toDouble(),
      goalKg: (json['goalKg'] as num?)?.toDouble(),
      totalChangeKg: (json['totalChangeKg'] as num?)?.toDouble() ?? 0,
      weeklyChangeKg: (json['weeklyChangeKg'] as num?)?.toDouble() ?? 0,
      history: (json['history'] as List<dynamic>? ?? const [])
          .map((e) => DashboardWeightPoint.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class DashboardAlertItem {
  const DashboardAlertItem({
    required this.id,
    required this.type,
    required this.severity,
    required this.nutrientType,
    required this.title,
    required this.message,
    required this.current,
    required this.limit,
    required this.unit,
    required this.percent,
    required this.isRead,
  });

  final String id;
  final String type;
  final String severity;
  final String nutrientType;
  final String title;
  final String message;
  final double? current;
  final double? limit;
  final String unit;
  final int? percent;
  final bool isRead;

  factory DashboardAlertItem.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String? ?? 'yellow';
    final severity =
        json['severity'] as String? ?? (type == 'red' ? 'critical' : 'warning');
    return DashboardAlertItem(
      id: json['id']?.toString() ?? '',
      type: type,
      severity: severity,
      nutrientType: json['nutrientType'] as String? ?? '',
      title: json['title'] as String? ?? '',
      message: json['message'] as String? ?? '',
      current: (json['current'] as num?)?.toDouble(),
      limit: (json['limit'] as num?)?.toDouble(),
      unit: json['unit'] as String? ?? '',
      percent: (json['percent'] as num?)?.round(),
      isRead: json['isRead'] as bool? ?? false,
    );
  }
}

class DashboardAiSuggestion {
  const DashboardAiSuggestion({required this.title, required this.message});

  final String title;
  final String message;

  factory DashboardAiSuggestion.fromJson(Map<String, dynamic> json) {
    return DashboardAiSuggestion(
      title: json['title'] as String? ?? '',
      message: json['message'] as String? ?? '',
    );
  }
}

class DashboardChecklist {
  const DashboardChecklist({
    required this.foodLogged,
    required this.waterLogged,
    required this.exerciseLogged,
    required this.weightLogged,
    required this.isCompleted,
  });

  final bool foodLogged;
  final bool waterLogged;
  final bool exerciseLogged;
  final bool weightLogged;
  final bool isCompleted;

  factory DashboardChecklist.fromJson(Map<String, dynamic> json) {
    return DashboardChecklist(
      foodLogged: json['foodLogged'] as bool? ?? false,
      waterLogged: json['waterLogged'] as bool? ?? false,
      exerciseLogged: json['exerciseLogged'] as bool? ?? false,
      weightLogged: json['weightLogged'] as bool? ?? false,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}
