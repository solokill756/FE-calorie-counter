import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_nutritional_threshold_model.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
class UserProfileModel with _$UserProfileModel {
  const factory UserProfileModel({
    @Default('') String? displayName,
    @Default([]) List<String> goals,
    @Default([]) List<String> barriers,
    @Default([]) List<String> conditionTypes,
    @Default([]) List<String> healthyHabits,
    @Default('') String mealPlanningFrequency,
    @Default(false) bool wantsMealPlans,
    @Default('') String activityLevel,
    @Default('') String gender,
    @Default(0) int age,
    @Default('') String country,
    @Default(0.0) double heightCm, // in cm
    @Default(0.0) double currentWeightKg, // in kg
    @Default(0.0) double startWeightKg, // in kg
    @Default(0.0) double goalWeightKg, // in kg
    @Default('') String email,
    String? avatarUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    @Default(false) bool isProfileComplete,
    @Default('active') String status,

    /// From BE: `auth/me` nutritionTargets.targetCalories or onboarding preview.
    @Default(0) int dailyCalorieTarget,
    @Default(0.0) double macroCarbsG,
    @Default(0.0) double macroProteinG,
    @Default(0.0) double macroFatG,
    @Default(0.0) double macroCarbsPercent,
    @Default(0.0) double macroProteinPercent,
    @Default(0.0) double macroFatPercent,

    /// From `auth/me` `nutritionalThresholds` (min/max bands per nutrient).
    @Default([]) List<UserNutritionalThreshold> nutritionalThresholds,
  }) = _UserProfileModel;

  const UserProfileModel._();

  double get bmi {
    if (heightCm <= 0 || currentWeightKg <= 0) return 0;
    final heightInM = heightCm / 100;
    return currentWeightKg / (heightInM * heightInM);
  }

  String get bmiCategory {
    final bmiValue = bmi;
    if (bmiValue < 18.5) return 'Underweight';
    if (bmiValue < 25) return 'Normal';
    if (bmiValue < 30) return 'Overweight';
    return 'Obese';
  }

  double get weightToLose => currentWeightKg - goalWeightKg;
  double get weightProgressKg => startWeightKg > 0 ? currentWeightKg - startWeightKg : 0;

  bool get hasGoalWeight => goalWeightKg > 0;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  bool get hasBasicInfo {
    return displayName?.isNotEmpty == true &&
        age > 0 &&
        heightCm > 0 &&
        currentWeightKg > 0 &&
        gender.isNotEmpty;
  }

  /// Shape expected by diary / nutrition widgets (values from server only).
  Map<String, dynamic> get macroGoals => {
    'carbsG': macroCarbsG,
    'proteinG': macroProteinG,
    'fatG': macroFatG,
    'carbsPercent': macroCarbsPercent,
    'proteinPercent': macroProteinPercent,
    'fatPercent': macroFatPercent,
  };

  double get proteinGoalG => macroProteinG;

  double get carbsGoalG => macroCarbsG;

  double get fatGoalG => macroFatG;

  /// kcal from server; [fallback] when profile not yet loaded from `auth/me`.
  int resolvedDailyCalorieGoal([int fallback = 2300]) =>
      dailyCalorieTarget > 0 ? dailyCalorieTarget : fallback;

  /// Computed macro percentages from grams, fallback to server values.
  double get computedCarbsPercent => _macroPercent(macroCarbsG, 4);
  double get computedProteinPercent => _macroPercent(macroProteinG, 4);
  double get computedFatPercent => _macroPercent(macroFatG, 9);

  double _macroPercent(double grams, double calPerG) {
    final totalCal = (macroCarbsG * 4) + (macroProteinG * 4) + (macroFatG * 9);
    if (totalCal <= 0) return 0;
    return ((grams * calPerG / totalCal) * 100).roundToDouble();
  }
}
