// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileModelImpl _$$UserProfileModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserProfileModelImpl(
      displayName: json['displayName'] as String? ?? '',
      goals:
          (json['goals'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      barriers: (json['barriers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      conditionTypes: (json['conditionTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      healthyHabits: (json['healthyHabits'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      mealPlanningFrequency: json['mealPlanningFrequency'] as String? ?? '',
      wantsMealPlans: json['wantsMealPlans'] as bool? ?? false,
      activityLevel: json['activityLevel'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      age: (json['age'] as num?)?.toInt() ?? 0,
      country: json['country'] as String? ?? '',
      heightCm: (json['heightCm'] as num?)?.toDouble() ?? 0.0,
      currentWeightKg: (json['currentWeightKg'] as num?)?.toDouble() ?? 0.0,
      startWeightKg: (json['startWeightKg'] as num?)?.toDouble() ?? 0.0,
      goalWeightKg: (json['goalWeightKg'] as num?)?.toDouble() ?? 0.0,
      email: json['email'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      isProfileComplete: json['isProfileComplete'] as bool? ?? false,
      status: json['status'] as String? ?? 'active',
      dailyCalorieTarget: (json['dailyCalorieTarget'] as num?)?.toInt() ?? 0,
      macroCarbsG: (json['macroCarbsG'] as num?)?.toDouble() ?? 0.0,
      macroProteinG: (json['macroProteinG'] as num?)?.toDouble() ?? 0.0,
      macroFatG: (json['macroFatG'] as num?)?.toDouble() ?? 0.0,
      macroCarbsPercent: (json['macroCarbsPercent'] as num?)?.toDouble() ?? 0.0,
      macroProteinPercent:
          (json['macroProteinPercent'] as num?)?.toDouble() ?? 0.0,
      macroFatPercent: (json['macroFatPercent'] as num?)?.toDouble() ?? 0.0,
      nutritionalThresholds: (json['nutritionalThresholds'] as List<dynamic>?)
              ?.map((e) =>
                  UserNutritionalThreshold.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserProfileModelImplToJson(
        _$UserProfileModelImpl instance) =>
    <String, dynamic>{
      'displayName': instance.displayName,
      'goals': instance.goals,
      'barriers': instance.barriers,
      'conditionTypes': instance.conditionTypes,
      'healthyHabits': instance.healthyHabits,
      'mealPlanningFrequency': instance.mealPlanningFrequency,
      'wantsMealPlans': instance.wantsMealPlans,
      'activityLevel': instance.activityLevel,
      'gender': instance.gender,
      'age': instance.age,
      'country': instance.country,
      'heightCm': instance.heightCm,
      'currentWeightKg': instance.currentWeightKg,
      'startWeightKg': instance.startWeightKg,
      'goalWeightKg': instance.goalWeightKg,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'isProfileComplete': instance.isProfileComplete,
      'status': instance.status,
      'dailyCalorieTarget': instance.dailyCalorieTarget,
      'macroCarbsG': instance.macroCarbsG,
      'macroProteinG': instance.macroProteinG,
      'macroFatG': instance.macroFatG,
      'macroCarbsPercent': instance.macroCarbsPercent,
      'macroProteinPercent': instance.macroProteinPercent,
      'macroFatPercent': instance.macroFatPercent,
      'nutritionalThresholds':
          instance.nutritionalThresholds.map((e) => e.toJson()).toList(),
    };
