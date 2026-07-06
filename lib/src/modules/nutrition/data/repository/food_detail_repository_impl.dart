import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';
import '../../../../core/data/remote/base/api_error.dart';
import '../../../../core/data/remote/services/api_service.dart';
import '../../../logfood/data/models/food_model.dart';
import '../../../logfood/helper/log_food_helper.dart';
import '../../domain/entities/food_item_entity.dart';
import '../../domain/repository/food_detail_repository.dart';
import '../helpers/date_helper.dart';

@LazySingleton(as: FoodDetailRepository)
class FoodDetailRepositoryImpl implements FoodDetailRepository {
  final Dio _dio;

  FoodDetailRepositoryImpl(this._dio);

  @override
  Future<Result<List<FoodItemEntity>, ApiError>> getFoodsByNutrient({
    required DateTime startDate,
    required DateTime endDate,
    required String type,
  }) {
    final queryParameters = <String, dynamic>{
      'page': 1,
      'pageSize': 1000,
      'startDate': DateHelper.formatDateForApi(startDate),
      'endDate': DateHelper.formatDateForApi(endDate),
      'includeQuickAdd': true,
    };

    return _dio.get('api/LogFood', queryParameters: queryParameters).tryGet((
      response,
    ) {
      final data = response.data as Map<String, dynamic>;
      final items = (data['items'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();

      final foodTotals = <String, double>{};

      for (final item in items) {
        final foodData = item['food'] as Map<String, dynamic>? ?? item;
        final foodModel = LogFoodHelper.mapLogFoodToModel(foodData);
        final foodName = _foodName(item, foodModel.name);
        final value = _NutrientExtractor.extract(item, foodModel, type);

        foodTotals[foodName] = (foodTotals[foodName] ?? 0.0) + value;
      }

      final sortedFoods = foodTotals.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      return sortedFoods
          .map((entry) => FoodItemEntity(name: entry.key, total: entry.value))
          .toList();
    });
  }
}

class _NutrientExtractor {
  static double extract(
    Map<String, dynamic> item,
    FoodModel foodModel,
    String type,
  ) {
    switch (type) {
      case 'calories':
        return _number(item, ['calories', 'caloriesKcal']) ??
            foodModel.calories;
      case 'carbohydrates':
        return _number(item, ['totalCarbohydratesG', 'carbs']) ??
            foodModel.carbs ??
            0.0;
      case 'fat':
        return _number(item, ['totalFatG', 'fat']) ?? foodModel.fat ?? 0.0;
      case 'protein':
        return _number(item, ['proteinG', 'protein']) ??
            foodModel.protein ??
            0.0;
      default:
        return 0.0;
    }
  }

  static double? _number(Map<String, dynamic> item, List<String> keys) {
    for (final key in keys) {
      final value = item[key];
      if (value is num) return value.toDouble();
      if (value is String) {
        final parsed = double.tryParse(value);
        if (parsed != null) return parsed;
      }
    }
    return null;
  }
}

String _foodName(Map<String, dynamic> item, String fallback) {
  final value = item['foodName'] ??
      item['FoodName'] ??
      (item['food'] is Map<String, dynamic>
          ? (item['food'] as Map<String, dynamic>)['description']
          : null);
  if (value is String && value.trim().isNotEmpty) {
    return value.trim();
  }
  return fallback;
}
