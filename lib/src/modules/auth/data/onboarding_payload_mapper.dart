import 'models/user_profile_model.dart';

/// Maps between signup wizard [UserProfileModel] and NestJS `/onboarding/*` DTOs.
class OnboardingPayloadMapper {
  OnboardingPayloadMapper._();

  static String genderToApi(String uiGender) {
    final s = uiGender.trim().toLowerCase();
    if (s == 'male' || s == 'm') return 'male';
    if (s == 'female' || s == 'f') return 'female';
    if (uiGender == 'Male') return 'male';
    if (uiGender == 'Female') return 'female';
    return 'female';
  }

  static String genderFromApi(String? g) {
    if (g == null || g.isEmpty) return '';
    return switch (g.toLowerCase()) {
      'male' => 'Male',
      'female' => 'Female',
      _ => g,
    };
  }

  static String activityToApi(String feValue) {
    switch (feValue) {
      case 'lightly':
        return 'light';
      case 'moderately':
        return 'moderate';
      case 'very':
        return 'active';
      case 'extra':
        return 'very_active';
      case 'sedentary':
        return 'sedentary';
      default:
        return feValue;
    }
  }

  static String activityFromApi(String? be) {
    switch (be) {
      case 'light':
        return 'lightly';
      case 'moderate':
        return 'moderately';
      case 'active':
        return 'very';
      case 'very_active':
        return 'extra';
      case 'sedentary':
        return 'sedentary';
      default:
        return be ?? '';
    }
  }

  static String goalsToGoalType(List<String> goals) {
    final normalizedGoals = _normalizeGoalsForGoalType(goals);
    if (normalizedGoals.isEmpty) return 'maintenance';
    const ordered = [
      'Lose Weight',
      'Gain Muscle',
      'Gain Weight',
      'Maintain Weight',
      'Modify My Diet',
      'Plan Meals',
      'Manage Stress',
      'Stay Active',
    ];
    for (final label in ordered) {
      if (normalizedGoals.contains(label)) return _goalLabelToSlug(label);
    }
    return _goalLabelToSlug(normalizedGoals.first);
  }

  static List<String> _normalizeGoalsForGoalType(List<String> goals) {
    if (goals.isEmpty) return goals;
    const weightGoals = {'Lose Weight', 'Maintain Weight', 'Gain Weight'};
    final seenWeight = <String>[];
    final result = <String>[];
    for (final g in goals) {
      if (weightGoals.contains(g)) {
        seenWeight.add(g);
      } else {
        result.add(g);
      }
    }
    if (seenWeight.isNotEmpty) {
      result.insert(0, seenWeight.last);
    }
    return result;
  }

  static String _goalLabelToSlug(String g) {
    switch (g) {
      case 'Lose Weight':
        return 'weight_loss';
      case 'Gain Weight':
        return 'weight_gain';
      case 'Gain Muscle':
        return 'muscle_gain';
      case 'Maintain Weight':
        return 'maintenance';
      case 'Modify My Diet':
        return 'modify_diet';
      case 'Plan Meals':
        return 'plan_meals';
      case 'Manage Stress':
        return 'manage_stress';
      case 'Stay Active':
        return 'stay_active';
      default:
        return g.toLowerCase().replaceAll(RegExp(r'\s+'), '_');
    }
  }

  static List<String> goalTypeToGoalsList(String? t) {
    if (t == null || t.isEmpty) return [];
    switch (t) {
      case 'weight_loss':
        return ['Lose Weight'];
      case 'weight_gain':
        return ['Gain Weight'];
      case 'muscle_gain':
        return ['Gain Muscle'];
      case 'maintenance':
        return ['Maintain Weight'];
      case 'modify_diet':
        return ['Modify My Diet'];
      case 'plan_meals':
        return ['Plan Meals'];
      case 'manage_stress':
        return ['Manage Stress'];
      case 'stay_active':
        return ['Stay Active'];
      default:
        return [t.replaceAll('_', ' ')];
    }
  }

  /// Merges `GET /onboarding/me` into local draft for resume.
  static UserProfileModel mergeFromSnapshot(
    UserProfileModel current,
    Map<String, dynamic> json,
  ) {
    final draft = json['draftData'];
    if (draft is! Map<String, dynamic>) return current;

    final conditions = draft['conditionTypes'];
    final barriers = draft['barriers'];
    final draftName = draft['displayName'];
    final draftGoalW = draft['goalWeightKg'];

    return current.copyWith(
      displayName: draftName is String && draftName.isNotEmpty
          ? draftName
          : current.displayName,
      gender: genderFromApi(draft['gender'] as String?),
      age: (draft['age'] as num?)?.toInt() ?? current.age,
      heightCm: (draft['heightCm'] as num?)?.toDouble() ?? current.heightCm,
      currentWeightKg:
          (draft['currentWeightKg'] as num?)?.toDouble() ??
          current.currentWeightKg,
      goalWeightKg: draftGoalW is num
          ? draftGoalW.toDouble()
          : current.goalWeightKg,
      activityLevel: () {
        final v = activityFromApi(draft['activityLevel'] as String?);
        return v.isNotEmpty ? v : current.activityLevel;
      }(),
      goals: goalTypeToGoalsList(draft['goalType'] as String?),
      dailyCalorieTarget:
          (draft['targetCalories'] as num?)?.round() ??
          current.dailyCalorieTarget,
      macroCarbsPercent:
          (draft['carbsPercent'] as num?)?.toDouble() ??
          current.macroCarbsPercent,
      macroProteinPercent:
          (draft['proteinPercent'] as num?)?.toDouble() ??
          current.macroProteinPercent,
      macroFatPercent:
          (draft['fatPercent'] as num?)?.toDouble() ?? current.macroFatPercent,
      conditionTypes: conditions is List
          ? conditions.map((e) => '$e').toList()
          : current.conditionTypes,
      barriers: barriers is List
          ? barriers.map((e) => '$e').toList()
          : current.barriers,
      isProfileComplete:
          json['isProfileComplete'] as bool? ?? current.isProfileComplete,
    );
  }

  /// Applies `POST /onboarding/preview-nutrition` or `nutritionTargets` shape from `auth/me`.
  static UserProfileModel applyNutritionPreview(
    UserProfileModel current,
    Map<String, dynamic> json,
  ) {
    return current.copyWith(
      dailyCalorieTarget: (json['targetCalories'] as num?)?.round() ?? 0,
      macroCarbsG: (json['carbsG'] as num?)?.toDouble() ?? 0,
      macroProteinG: (json['proteinG'] as num?)?.toDouble() ?? 0,
      macroFatG: (json['fatG'] as num?)?.toDouble() ?? 0,
      macroCarbsPercent: (json['carbsPercent'] as num?)?.toDouble() ?? 0,
      macroProteinPercent: (json['proteinPercent'] as num?)?.toDouble() ?? 0,
      macroFatPercent: (json['fatPercent'] as num?)?.toDouble() ?? 0,
    );
  }

  static UserProfileModel mergeNutritionFromAuthMe(
    UserProfileModel current,
    dynamic nutritionRaw,
  ) {
    if (nutritionRaw is! Map<String, dynamic>) return current;
    return applyNutritionPreview(current, nutritionRaw);
  }
}
