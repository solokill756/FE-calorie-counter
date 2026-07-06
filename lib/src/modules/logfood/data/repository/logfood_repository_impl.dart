import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/data/remote/base/api_error.dart';
import '../../../../core/data/remote/base/api_response.dart';
import '../../../../core/data/remote/services/api_service.dart';
import '../../../nutrition/data/helpers/date_helper.dart';
import '../../domain/repository/logfood_repo.dart';
import '../../helper/log_food_helper.dart';
import '../models/food_model.dart';
import '../models/log_food_model.dart';

@LazySingleton(as: LogFoodRepository)
class LogFoodRepositoryImpl implements LogFoodRepository {
  final Dio _dio;

  LogFoodRepositoryImpl(this._dio);

  /// Helper: build payload for POST /api/LogFood from a [FoodModel] and context.
  Map<String, dynamic> _buildLogFoodPayload({
    required FoodModel food,
    required String slot,
    required double qty,
    required int unitSelectedIndex,
    DateTime? time,
  }) {
    final DateTime ts = time ?? DateTime.now();
    final String loggedOn =
        '${ts.year.toString().padLeft(4, '0')}-${ts.month.toString().padLeft(2, '0')}-${ts.day.toString().padLeft(2, '0')}';

    final double servingSize = food.unitSizes[unitSelectedIndex];

    final payload = <String, dynamic>{
      'loggedOn': loggedOn,
      'LoggedAt': ts.toUtc().toIso8601String(),
      'numberOfServings': qty,
      'servingSize': servingSize,
      'meal': slot,
      'type': 'regular',
    };
    final foodId = food.id;
    if (foodId != null && foodId > 0) {
      payload['foodId'] = foodId;
    }
    return payload;
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> logFood({
    required FoodModel food,
    required String slot,
    required double qty,
    required int unitSelectedIndex,
    DateTime? time,
    bool skipRecentUpdate = false,
  }) {
    final payload = _buildLogFoodPayload(
      food: food,
      slot: slot,
      qty: qty,
      unitSelectedIndex: unitSelectedIndex,
      time: time,
    );

    return _dio.post('api/LogFood', data: payload).tryGet((response) {
      return StatusApiResponse(
        message: 'Food logged successfully',
        statusCode: 200,
      );
    });
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> logMultipleFoods({
    required List<FoodModel> foods,
    DateTime? time,
    bool skipRecentUpdate = false,
    required int unitSelectedIndex,
    required String slot,
    required double qty,
  }) async {
    final futures = foods.map(
      (food) => logFood(
        food: food,
        slot: slot,
        qty: qty,
        unitSelectedIndex: unitSelectedIndex,
        time: time,
        skipRecentUpdate: skipRecentUpdate,
      ),
    );

    final results = await Future.wait(futures);

    for (final r in results) {
      if (r.isError()) {
        return r;
      }
    }

    return const StatusApiResponse(
      message: 'Logged multiple foods successfully',
      statusCode: 200,
    ).toSuccess();
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> logFoodToMultipleDays({
    required FoodModel food,
    required String slot,
    required double qty,
    required List<DateTime> dates,
    required int unitSelectedIndex,
    bool skipRecentUpdate = false,
  }) async {
    final futures = dates.map(
      (date) => logFood(
        food: food,
        slot: slot,
        qty: qty,
        unitSelectedIndex: unitSelectedIndex,
        time: date,
        skipRecentUpdate: skipRecentUpdate,
      ),
    );

    final results = await Future.wait(futures);

    for (final r in results) {
      if (r.isError()) {
        return r;
      }
    }

    return const StatusApiResponse(
      message: 'Logged food to multiple days successfully',
      statusCode: 200,
    ).toSuccess();
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> logMultipleFoodsToMultipleDays({
    required List<FoodModel> foods,
    required List<DateTime> dates,
    required int unitSelectedIndex,
    required double qty,
    bool skipRecentUpdate = false,
    required String slot,
  }) async {
    final futures = dates.map(
      (date) => logMultipleFoods(
        foods: foods,
        time: date,
        unitSelectedIndex: unitSelectedIndex,
        qty: qty,
        skipRecentUpdate: skipRecentUpdate,
        slot: slot,
      ),
    );

    final results = await Future.wait(futures);

    for (final r in results) {
      if (r.isError()) {
        return r;
      }
    }

    return const StatusApiResponse(
      message: 'Logged multiple foods to multiple days successfully',
      statusCode: 200,
    ).toSuccess();
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> quickAddLogFood({
    required double calories,
    required String slot,
    DateTime? time,
    double? fat,
    double? carbs,
    double? protein,
  }) {
    final DateTime ts = time ?? DateTime.now();
    final String loggedOn =
        '${ts.year.toString().padLeft(4, '0')}-${ts.month.toString().padLeft(2, '0')}-${ts.day.toString().padLeft(2, '0')}';
    final payload = {
      'calories': calories,
      'meal': slot,
      'loggedOn': loggedOn,
      'LoggedAt': ts.toUtc().toIso8601String(),
      'totalFatG': fat,
      'totalCarbohydratesG': carbs,
      'proteinG': protein,
      'type': 'quickAdd',
    };
    return _dio.post('api/LogFood', data: payload).tryGet((response) {
      return StatusApiResponse(
        message: 'Quick Log Food Successfully',
        statusCode: 200,
      );
    });
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> logSavedMealTemplate({
    required FoodModel meal,
    required String slot,
    DateTime? time,
  }) {
    final mealId = meal.id;
    if (mealId == null || mealId <= 0) {
      return Future.value(ApiError(400, 'Invalid meal').toFailure());
    }
    final ts = time ?? DateTime.now();
    final loggedOn =
        '${ts.year.toString().padLeft(4, '0')}-${ts.month.toString().padLeft(2, '0')}-${ts.day.toString().padLeft(2, '0')}';
    final qty = meal.quantity > 0 ? meal.quantity : 1.0;
    final sizeIdx = meal.unitSizes.isNotEmpty
        ? meal.unitShowIndex.clamp(0, meal.unitSizes.length - 1)
        : 0;
    final servingSize = meal.unitSizes.isNotEmpty
        ? meal.unitSizes[sizeIdx]
        : 1.0;

    final payload = <String, dynamic>{
      'type': 'regular',
      'meal': slot,
      'foodName': meal.name,
      'mealId': mealId,
      'loggedOn': loggedOn,
      'LoggedAt': ts.toUtc().toIso8601String(),
      'numberOfServings': qty,
      'servingSize': servingSize > 0 ? servingSize : 1.0,
      // Word only; UI builds "1 meal" from servingSize + servingUnit (not "1 1 meal").
      'unit': 'meal',
      'calories': meal.calories,
      'totalFatG': meal.fat ?? 0,
      'totalCarbohydratesG': meal.carbs ?? 0,
      'proteinG': meal.protein ?? 0,
      'sodiumMg': meal.sodium ?? 0,
      'dietaryFibersG': meal.fiber ?? 0,
      'sugarsG': meal.nutrients[NutrientKeys.sugarsG] ?? 0,
      'saturatedFatG': meal.nutrients[NutrientKeys.fatSaturatedG] ?? 0,
      'cholesterolMg': meal.nutrients[NutrientKeys.cholesterolMg] ?? 0,
      'potassiumMg': meal.nutrients[NutrientKeys.potassiumMg] ?? 0,
      for (final field in AppNutrients.micronutrients)
        field.apiKey: meal.nutrients[field.key] ?? 0,
    };
    return _dio.post('api/LogFood', data: payload).tryGet((response) {
      return StatusApiResponse(
        message: 'Meal logged successfully',
        statusCode: 200,
      );
    });
  }

  @override
  Future<Result<List<LogFoodModel>, ApiError>> getLogFoodsByDate(
    DateTime startDate,
    DateTime endDate, {
    bool includeQuickAdd = false,
  }) {
    final queryParameters = <String, dynamic>{
      'startDate': DateHelper.formatDateForApi(startDate),
      'endDate': DateHelper.formatDateForApi(endDate),
      'includeQuickAdd': includeQuickAdd,
    };
    return _dio.get('api/LogFood', queryParameters: queryParameters).tryGet((
      response,
    ) {
      final data = response.data as Map<String, dynamic>;
      final items = (data['items'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();

      return items.map((item) {
        // Map food field từ API response
        final foodModel = LogFoodHelper.mapLogFoodToModel(item);

        // Parse time
        DateTime time;
        try {
          if (item['loggedAt'] != null) {
            time = DateTime.parse(item['loggedAt'] as String).toLocal();
          } else if (item['LoggedAt'] != null) {
            time = DateTime.parse(item['LoggedAt'] as String).toLocal();
          } else {
            time = DateTime.now();
          }
        } catch (e) {
          time = DateTime.now();
        }

        // Parse slot/meal
        final slot =
            (item['meal'] as String?) ??
            (item['slot'] as String?) ??
            'breakfast';

        // Parse foodId
        final foodId =
            (item['foodId'] as int?) ??
            (item['food']?['id'] as int?) ??
            foodModel.id ??
            0;

        // Parse nutrients và serving từ foodModel hoặc item
        final nutrients = foodModel.nutrients.map(
          (key, value) => MapEntry(key, value as dynamic),
        );

        final serving = <String, dynamic>{
          'servingSize':
              item['servingSize'] ?? foodModel.unitSizes.firstOrNull ?? 1.0,
          'numberOfServings': item['numberOfServings'] ?? 1.0,
        };

        return LogFoodModel(
          id: item['id'] as int?,
          brandName: item['brandName'] as String?,
          nameFood: foodModel.name,
          nutrients: nutrients,
          serving: serving,
          slot: slot,
          source: item['source'] as String? ?? 'user',
          time: time,
          foodId: foodId,
          food: foodModel,
        );
      }).toList();
    });
  }
}
