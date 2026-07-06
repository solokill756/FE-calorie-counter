import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';
import '../../domain/repository/calorie_repository.dart';
import '../../domain/entities/calorie_entity.dart';
import '../../../auth/presentation/application/cubit/user_profile_access.dart';
import '../../../logfood/helper/log_food_helper.dart';

@LazySingleton(as: CalorieRepository)
class CalorieRepositoryImpl implements CalorieRepository {
  final Dio _dio;

  CalorieRepositoryImpl(this._dio);

  @override
  Future<Result<CalorieEntity, Exception>> getTodayCalories() async {
    try {
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final logFoodHelper = LogFoodHelper();
      final fromDate = logFoodHelper.dateKeyFrom(startOfDay);
      final toDate = logFoodHelper.dateKeyFrom(startOfDay);

      // Get calorie goal from user profile
      final userProfile = readServerProfile();
      final calorieGoal = userProfile?.resolvedDailyCalorieGoal() ?? 2220;

      int totalCaloriesConsumed = 0;
      int totalCaloriesBurned = 0;

      // Diary range: per-day totals include exerciseCaloriesBurned for the first day in range.
      try {
        final queryParameters = <String, dynamic>{
          'from': fromDate,
          'to': toDate,
        };

        final response = await _dio.get(
          'api/Diary/range',
          options: Options(headers: {'accept': 'text/plain'}),
          queryParameters: queryParameters,
        );

        final raw = response.data;
        final List<dynamic> items;

        if (raw is List<dynamic>) {
          items = raw;
        } else {
          items = const [];
        }

        if (items.isNotEmpty && items.first is Map<String, dynamic>) {
          final first = items.first as Map<String, dynamic>;
          totalCaloriesConsumed =
              (first['totalCalories'] as num?)?.toInt() ?? 0;
          totalCaloriesBurned =
              (first['exerciseCaloriesBurned'] as num?)?.toInt() ?? 0;
        }
      } catch (e) {
        if (kDebugMode) {
          print('CalorieRepository: Error fetching diary range calories: $e');
        }
        // Continue with default values if API fails
      }

      final remaining =
          calorieGoal - totalCaloriesConsumed + totalCaloriesBurned;

      final calories = CalorieEntity(
        goal: calorieGoal,
        consumed: totalCaloriesConsumed,
        burned: totalCaloriesBurned,
        remaining: remaining,
        date: today,
      );
      return Success(calories);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<MacroEntity, Exception>> getTodayMacros() async {
    try {
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final logFoodHelper = LogFoodHelper();
      final dateKey = logFoodHelper.dateKeyFrom(startOfDay);

      double totalCarbsConsumed = 0.0;
      double totalProteinConsumed = 0.0;
      double totalFatConsumed = 0.0;
      double totalFiberConsumed = 0.0;
      double totalSugarConsumed = 0.0;

      // Fetch daily macro summary from Diary API
      try {
        final response = await _dio.get(
          'api/Diary/$dateKey',
          options: Options(headers: {'accept': 'text/plain'}),
        );

        final raw = response.data;
        if (raw is Map<String, dynamic>) {
          totalCarbsConsumed = (raw['totalCarbs'] as num?)?.toDouble() ?? 0.0;
          totalProteinConsumed =
              (raw['totalProtein'] as num?)?.toDouble() ?? 0.0;
          totalFatConsumed = (raw['totalFat'] as num?)?.toDouble() ?? 0.0;
          // This endpoint currently does not include total fiber/sugar.
          totalFiberConsumed = 0.0;
          totalSugarConsumed = 0.0;
        }
      } catch (e) {
        if (kDebugMode) {
          print('CalorieRepository: Error fetching diary macros: $e');
        }
        // Continue with default values if API fails
      }

      final macros = MacroEntity(
        carbs: totalCarbsConsumed,
        protein: totalProteinConsumed,
        fat: totalFatConsumed,
        fiber: totalFiberConsumed,
        sugar: totalSugarConsumed,
      );
      return Success(macros);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<ActivityEntity>, Exception>> getTodayActivities() async {
    try {
      // Mock data
      final activities = <ActivityEntity>[];
      return Success(activities);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<WeightEntity>, Exception>> getWeightHistory() async {
    try {
      // Mock data
      final weights = [
        WeightEntity(
          weight: 56,
          date: DateTime.now().subtract(const Duration(days: 3)),
        ),
        WeightEntity(
          weight: 55,
          date: DateTime.now().subtract(const Duration(days: 2)),
        ),
        WeightEntity(
          weight: 57,
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
        WeightEntity(weight: 58, date: DateTime.now()),
      ];
      return Success(weights);
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<void, Exception>> addCalories(int calories) async {
    try {
      // Mock implementation - in real app this would save to local storage or API
      await Future.delayed(const Duration(milliseconds: 500));
      return Success(());
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<void, Exception>> addActivity(ActivityEntity activity) async {
    try {
      // Mock implementation
      await Future.delayed(const Duration(milliseconds: 500));
      return Success(());
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<void, Exception>> updateWeight(double weight) async {
    try {
      // Mock implementation
      await Future.delayed(const Duration(milliseconds: 500));
      return Success(());
    } catch (e) {
      return Failure(Exception(e.toString()));
    }
  }
}
