import 'package:injectable/injectable.dart';
import '../../../logfood/data/models/log_food_model.dart';

/// Service responsible for aggregating nutrients from logged foods
abstract class NutrientAggregationService {
  /// Aggregate calories from logged foods and return top foods
  Future<List<String>> getTopFoodsByCalories(
    List<LogFoodModel> logFoods, {
    int limit = 3,
  });

  /// Aggregate carbohydrates from logged foods and return top foods
  Future<List<String>> getTopFoodsByCarbohydrates(
    List<LogFoodModel> logFoods, {
    int limit = 3,
  });

  /// Aggregate fat from logged foods and return top foods
  Future<List<String>> getTopFoodsByFat(
    List<LogFoodModel> logFoods, {
    int limit = 3,
  });

  /// Aggregate protein from logged foods and return top foods
  Future<List<String>> getTopFoodsByProtein(
    List<LogFoodModel> logFoods, {
    int limit = 3,
  });

  /// Aggregate any nutrient from logged foods and return top foods
  Future<List<String>> getTopFoodsByNutrient(
    List<LogFoodModel> logFoods,
    String nutrientKey,
    String unit, {
    int? limit,
  });
}

@LazySingleton(as: NutrientAggregationService)
class NutrientAggregationServiceImpl implements NutrientAggregationService {
  @override
  Future<List<String>> getTopFoodsByCalories(
    List<LogFoodModel> logFoods, {
    int limit = 3,
  }) async {
    try {
      final foodCalories = _aggregateNutrient(
        logFoods,
        (food) => food.calories.toDouble(),
      );

      return _sortAndFormatResults(foodCalories, limit, 'cal', isCalorie: true);
    } catch (e) {
      print('NutrientAggregationService: Error in getTopFoodsByCalories: $e');
      return [];
    }
  }

  @override
  Future<List<String>> getTopFoodsByCarbohydrates(
    List<LogFoodModel> logFoods, {
    int limit = 3,
  }) async {
    try {
      final foodCarbs = _aggregateNutrient(
        logFoods,
        (food) => food.carbs ?? 0.0,
      );

      return _sortAndFormatResults(foodCarbs, limit, 'g');
    } catch (e) {
      print(
        'NutrientAggregationService: Error in getTopFoodsByCarbohydrates: $e',
      );
      return [];
    }
  }

  @override
  Future<List<String>> getTopFoodsByFat(
    List<LogFoodModel> logFoods, {
    int limit = 3,
  }) async {
    try {
      final foodFat = _aggregateNutrient(logFoods, (food) => food.fat ?? 0.0);

      return _sortAndFormatResults(foodFat, limit, 'g');
    } catch (e) {
      print('NutrientAggregationService: Error in getTopFoodsByFat: $e');
      return [];
    }
  }

  @override
  Future<List<String>> getTopFoodsByProtein(
    List<LogFoodModel> logFoods, {
    int limit = 3,
  }) async {
    try {
      final foodProtein = _aggregateNutrient(
        logFoods,
        (food) => food.protein ?? 0.0,
      );

      return _sortAndFormatResults(foodProtein, limit, 'g');
    } catch (e) {
      print('NutrientAggregationService: Error in getTopFoodsByProtein: $e');
      return [];
    }
  }

  @override
  Future<List<String>> getTopFoodsByNutrient(
    List<LogFoodModel> logFoods,
    String nutrientKey,
    String unit, {
    int? limit,
  }) async {
    try {
      final foodNutrients = _aggregateNutrient(
        logFoods,
        (food) => (food.nutrients[nutrientKey] ?? 0.0).toDouble(),
      );

      return _sortAndFormatResults(foodNutrients, limit ?? 3, unit);
    } catch (e) {
      print(
        'NutrientAggregationService: Error in getTopFoodsByNutrient ($nutrientKey): $e',
      );
      return [];
    }
  }

  /// Private helper to aggregate nutrient values for each food
  Map<String, double> _aggregateNutrient(
    List<LogFoodModel> logFoods,
    double Function(dynamic food) extractNutrient,
  ) {
    final Map<String, double> foodNutrients = {};

    for (final item in logFoods) {
      final logFood = item;
      final foodName = logFood.food.name;

      // Calculate multiplier based on serving size
      final multiplier = _calculateMultiplier(logFood);

      // Extract and multiply nutrient
      final nutrientValue = extractNutrient(logFood.food) * multiplier;

      // Aggregate by food name
      if (foodNutrients.containsKey(foodName)) {
        foodNutrients[foodName] = foodNutrients[foodName]! + nutrientValue;
      } else {
        foodNutrients[foodName] = nutrientValue;
      }
    }

    return foodNutrients;
  }

  /// Private helper to calculate serving size multiplier
  double _calculateMultiplier(LogFoodModel logFood) {
    double toDoubleValue(dynamic v) => (v as num?)?.toDouble() ?? 0.0;

    final double loggedServingSize = toDoubleValue(logFood.serving['servingSize']);
    final double loggedNumberOfServings = toDoubleValue(
      logFood.serving['numberOfServings'],
    );

    if (loggedServingSize > 0 && loggedNumberOfServings > 0) {
      final double baseServingSize = logFood.food.unitSizes.isNotEmpty
          ? logFood.food.unitSizes[0]
          : 1.0;
      return (loggedServingSize * loggedNumberOfServings) / baseServingSize;
    }

    return 1.0;
  }

  /// Private helper to sort and format results
  List<String> _sortAndFormatResults(
    Map<String, double> foodValues,
    int limit,
    String unit, {
    bool isCalorie = false,
  }) {
    final sortedFoods = foodValues.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedFoods.take(limit).map((entry) {
      final value = isCalorie
          ? entry.value.toInt().toString()
          : entry.value.toStringAsFixed(1);
      return '${entry.key} - $value $unit';
    }).toList();
  }
}
