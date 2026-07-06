import 'package:caloriecounter/src/core/data/remote/base/api_error.dart';
import 'package:caloriecounter/src/core/data/remote/base/api_response.dart';
import 'package:result_dart/result_dart.dart';

import '../../data/models/food_model.dart';
import '../../data/models/log_food_model.dart';

abstract class LogFoodRepository {
  // Single food logging
  Future<Result<StatusApiResponse, ApiError>> logFood({
    required FoodModel food,
    required String slot,
    required double qty,
    required int unitSelectedIndex,
    DateTime? time,
    bool skipRecentUpdate = false,
  });

  Future<Result<StatusApiResponse, ApiError>> quickAddLogFood({
    required double calories,
    required String slot,
    DateTime? time,
    double? fat,
    double? carbs,
    double? protein,
  });

  /// Log a user-defined meal template (My Meals) as quick-add with [MealId] on the server.
  Future<Result<StatusApiResponse, ApiError>> logSavedMealTemplate({
    required FoodModel meal,
    required String slot,
    DateTime? time,
  });

  // Multiple food logging methods
  Future<Result<StatusApiResponse, ApiError>> logMultipleFoods({
    required List<FoodModel> foods,
    DateTime? time,
    bool skipRecentUpdate = false,
    required int unitSelectedIndex,
    required double qty,
    required String slot,
  });

  Future<Result<StatusApiResponse, ApiError>> logFoodToMultipleDays({
    required FoodModel food,
    required String slot,
    required double qty,
    required List<DateTime> dates,
    required int unitSelectedIndex,
    bool skipRecentUpdate = false,
  });

  Future<Result<StatusApiResponse, ApiError>> logMultipleFoodsToMultipleDays({
    required List<FoodModel> foods,
    required List<DateTime> dates,
    required int unitSelectedIndex,
    required double qty,
    bool skipRecentUpdate = false,
    required String slot,
  });

  Future<Result<List<LogFoodModel>, ApiError>> getLogFoodsByDate(
    DateTime startDate,
    DateTime endDate, {
    bool includeQuickAdd = false,
  });
}
