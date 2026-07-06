import 'package:injectable/injectable.dart';
import '../../../logfood/helper/log_food_helper.dart';
import '../../domain/entities/food_item_entity.dart';
import 'nutrient_extractor_service.dart';

/// Service responsible for processing food data and calculating nutrient aggregates
abstract class FoodNutrientProcessorService {
  /// Process raw food items and aggregate nutrients by food name
  List<FoodItemEntity> processFoodsByNutrient(
    List<Map<String, dynamic>> items,
    String nutrientType,
  );

  /// Process raw food items and get nutrient breakdown for each food
  Map<String, Map<String, double>> processFoodNutrientBreakdown(
    List<Map<String, dynamic>> items,
  );

  /// Get total nutrients across all foods
  Map<String, double> getTotalNutrients(List<Map<String, dynamic>> items);
}

@LazySingleton(as: FoodNutrientProcessorService)
class FoodNutrientProcessorServiceImpl implements FoodNutrientProcessorService {
  final NutrientExtractorService _nutrientExtractor;

  FoodNutrientProcessorServiceImpl(this._nutrientExtractor);

  @override
  List<FoodItemEntity> processFoodsByNutrient(
    List<Map<String, dynamic>> items,
    String nutrientType,
  ) {
    final foodTotals = _aggregateFoodNutrients(items, nutrientType);
    return _sortAndMapToEntities(foodTotals);
  }

  @override
  Map<String, Map<String, double>> processFoodNutrientBreakdown(
    List<Map<String, dynamic>> items,
  ) {
    final breakdown = <String, Map<String, double>>{};

    for (final item in items) {
      final foodData = item['food'] as Map<String, dynamic>? ?? item;
      final foodModel = LogFoodHelper.mapLogFoodToModel(foodData);
      final foodName = foodModel.name;

      if (!breakdown.containsKey(foodName)) {
        breakdown[foodName] = {};
      }

      final nutrients = _nutrientExtractor.extractAll(foodModel);
      nutrients.forEach((nutrient, value) {
        breakdown[foodName]![nutrient] =
            (breakdown[foodName]![nutrient] ?? 0.0) + value;
      });
    }

    return breakdown;
  }

  @override
  Map<String, double> getTotalNutrients(List<Map<String, dynamic>> items) {
    final totals = <String, double>{
      'calories': 0.0,
      'carbohydrates': 0.0,
      'fat': 0.0,
      'protein': 0.0,
    };

    for (final item in items) {
      final foodData = item['food'] as Map<String, dynamic>? ?? item;
      final foodModel = LogFoodHelper.mapLogFoodToModel(foodData);
      final nutrients = _nutrientExtractor.extractAll(foodModel);

      nutrients.forEach((nutrient, value) {
        totals[nutrient] = (totals[nutrient] ?? 0.0) + value;
      });
    }

    return totals;
  }

  Map<String, double> _aggregateFoodNutrients(
    List<Map<String, dynamic>> items,
    String nutrientType,
  ) {
    final foodTotals = <String, double>{};

    for (final item in items) {
      final foodData = item['food'] as Map<String, dynamic>? ?? item;
      final foodModel = LogFoodHelper.mapLogFoodToModel(foodData);
      final foodName = foodModel.name;
      final value = _nutrientExtractor.extract(foodModel, nutrientType);

      foodTotals[foodName] = (foodTotals[foodName] ?? 0.0) + value;
    }

    return foodTotals;
  }

  List<FoodItemEntity> _sortAndMapToEntities(Map<String, double> foodTotals) {
    final sortedFoods = foodTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedFoods
        .map((entry) => FoodItemEntity(name: entry.key, total: entry.value))
        .toList();
  }
}
