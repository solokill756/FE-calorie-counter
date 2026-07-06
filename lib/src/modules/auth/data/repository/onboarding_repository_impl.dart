import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/data/remote/base/api_error.dart';
import '../../../../core/data/remote/services/api_service.dart';
import '../../domain/repository/onboarding_repository.dart';

@Injectable(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<Result<Map<String, dynamic>, ApiError>> getSnapshot() {
    return _dio.get<Map<String, dynamic>>('onboarding/me').tryGet((response) {
      final data = response.data;
      if (data == null) return <String, dynamic>{};
      return data;
    });
  }

  @override
  Future<Result<Map<String, dynamic>, ApiError>> previewNutrition({
    required String gender,
    required int age,
    required double heightCm,
    required double currentWeightKg,
    required String activityLevel,
    required String goalType,
    double? goalWeightKg,
    List<String>? conditionTypes,
  }) {
    return _dio
        .post<Map<String, dynamic>>(
          'onboarding/preview-nutrition',
          data: <String, dynamic>{
            'gender': gender,
            'age': age,
            'heightCm': heightCm,
            'currentWeightKg': currentWeightKg,
            'activityLevel': activityLevel,
            'goalType': goalType,
            if (goalWeightKg != null && goalWeightKg > 0)
              'goalWeightKg': goalWeightKg,
            if (conditionTypes != null && conditionTypes.isNotEmpty)
              'conditionTypes': conditionTypes,
          },
        )
        .tryGet((response) => response.data ?? <String, dynamic>{});
  }

  @override
  Future<Result<Map<String, dynamic>, ApiError>> patchBasicInfo({
    required String gender,
    required int age,
    required double heightCm,
    required double currentWeightKg,
    String? displayName,
    double? goalWeightKg,
  }) {
    final data = <String, dynamic>{
      'gender': gender,
      'age': age,
      'heightCm': heightCm,
      'currentWeightKg': currentWeightKg,
      if (displayName != null && displayName.isNotEmpty)
        'displayName': displayName,
      if (goalWeightKg != null && goalWeightKg > 0)
        'goalWeightKg': goalWeightKg,
    };
    return _dio
        .patch<Map<String, dynamic>>('onboarding/basic-info', data: data)
        .tryGet((response) => response.data ?? <String, dynamic>{});
  }

  @override
  Future<Result<Map<String, dynamic>, ApiError>> patchHealthProfile({
    required List<String> conditionTypes,
  }) {
    return _dio
        .patch<Map<String, dynamic>>(
          'onboarding/health-profile',
          data: <String, dynamic>{
            'conditionTypes': conditionTypes,
          },
        )
        .tryGet((response) => response.data ?? <String, dynamic>{});
  }

  @override
  Future<Result<Map<String, dynamic>, ApiError>> patchGoalPreferences({
    required String goalType,
    required String activityLevel,
    String? mealFrequency,
    List<String>? barriers,
  }) {
    final body = <String, dynamic>{
      'goalType': goalType,
      'activityLevel': activityLevel,
      if (mealFrequency != null && mealFrequency.isNotEmpty)
        'mealFrequency': mealFrequency,
      if (barriers != null && barriers.isNotEmpty) 'barriers': barriers,
    };
    return _dio
        .patch<Map<String, dynamic>>('onboarding/goal-preferences', data: body)
        .tryGet((response) => response.data ?? <String, dynamic>{});
  }

  @override
  Future<Result<Map<String, dynamic>, ApiError>> complete() {
    return _dio
        .post<Map<String, dynamic>>(
          'onboarding/complete',
          data: <String, dynamic>{},
        )
        .tryGet((response) => response.data ?? <String, dynamic>{});
  }
}
