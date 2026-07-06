import 'package:result_dart/result_dart.dart';

import '../../../../core/data/remote/base/api_error.dart';

abstract class OnboardingRepository {
  Future<Result<Map<String, dynamic>, ApiError>> getSnapshot();

  /// Server-side TDEE / macros (same formulas as onboarding complete).
  Future<Result<Map<String, dynamic>, ApiError>> previewNutrition({
    required String gender,
    required int age,
    required double heightCm,
    required double currentWeightKg,
    required String activityLevel,
    required String goalType,
    double? goalWeightKg,
    List<String>? conditionTypes,
  });

  Future<Result<Map<String, dynamic>, ApiError>> patchBasicInfo({
    required String gender,
    required int age,
    required double heightCm,
    required double currentWeightKg,
    String? displayName,
    double? goalWeightKg,
  });

  Future<Result<Map<String, dynamic>, ApiError>> patchHealthProfile({
    required List<String> conditionTypes,
  });

  Future<Result<Map<String, dynamic>, ApiError>> patchGoalPreferences({
    required String goalType,
    required String activityLevel,
    String? mealFrequency,
    List<String>? barriers,
  });

  Future<Result<Map<String, dynamic>, ApiError>> complete();
}
