import 'package:caloriecounter/src/modules/auth/data/models/user_nutritional_threshold_model.dart';
import 'package:caloriecounter/src/modules/auth/data/models/user_profile_model.dart';
import 'package:caloriecounter/src/modules/auth/data/onboarding_payload_mapper.dart';

/// Maps `GET auth/me` and `PATCH users/profile` JSON to [UserProfileModel].
UserProfileModel userProfileFromAuthMeJson(Map<String, dynamic> data) {
  final age = (data['age'] as num?)?.toInt() ?? 0;
  final heightCm = (data['heightCm'] as num?)?.toDouble() ?? 0.0;
  final currentWeightKg = (data['currentWeightKg'] as num?)?.toDouble() ?? 0.0;
  final startWeightKg = (data['startWeightKg'] as num?)?.toDouble() ?? 0.0;
  final goalWeightKg = (data['goalWeightKg'] as num?)?.toDouble() ?? 0.0;
  var userProfile = UserProfileModel(
    displayName: data['displayName'] as String? ?? '',
    email: data['email'] as String? ?? '',
    avatarUrl: data['avatarUrl'] as String?,
    isProfileComplete: data['isProfileComplete'] as bool? ?? false,
    age: age,
    gender: OnboardingPayloadMapper.genderFromApi(data['gender'] as String?),
    heightCm: heightCm,
    currentWeightKg: currentWeightKg,
    startWeightKg: startWeightKg,
    goalWeightKg: goalWeightKg,
    activityLevel: OnboardingPayloadMapper.activityFromApi(
      data['activityLevel'] as String?,
    ),
    mealPlanningFrequency: data['mealPlanningFrequency'] as String? ?? '',
    barriers: _stringList(data['barriers']),
    conditionTypes: _stringList(data['conditionTypes']),
  );
  userProfile = OnboardingPayloadMapper.mergeNutritionFromAuthMe(
    userProfile,
    data['nutritionTargets'],
  );
  final thresholdsRaw = data['nutritionalThresholds'];
  if (thresholdsRaw is List<dynamic>) {
    final list = thresholdsRaw
        .whereType<Map<String, dynamic>>()
        .map(UserNutritionalThreshold.fromJson)
        .toList();
    userProfile = userProfile.copyWith(nutritionalThresholds: list);
  }
  final goalType = data['goalType'] as String?;
  if (goalType != null && goalType.isNotEmpty) {
    userProfile = userProfile.copyWith(
      goals: OnboardingPayloadMapper.goalTypeToGoalsList(goalType),
    );
  }
  return userProfile;
}

List<String> _stringList(dynamic raw) {
  if (raw is! List) return const [];
  return raw
      .map((value) => '$value'.trim())
      .where((value) => value.isNotEmpty)
      .toList();
}

