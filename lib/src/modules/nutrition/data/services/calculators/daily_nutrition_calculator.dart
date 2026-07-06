import 'package:injectable/injectable.dart';
import '../../../../logfood/helper/log_food_helper.dart';
import '../../../../logfood/data/models/food_model.dart';
import '../../../domain/entities/nutrition_data_entity.dart';
import '../../helpers/date_helper.dart';

/// Calculator responsible for calculating daily nutrition data
abstract class DailyNutritionCalculator {
  /// Calculate nutrition data for a single day from food items
  DailyCalorieData calculateDailyData({
    required DateTime date,
    required List<Map<String, dynamic>> dayFoods,
    required double dailyGoal,
  });

  /// Calculate total nutrients for a list of food items
  Map<String, double> calculateTotalNutrients(List<Map<String, dynamic>> items);
}

@LazySingleton(as: DailyNutritionCalculator)
class DailyNutritionCalculatorImpl implements DailyNutritionCalculator {
  @override
  DailyCalorieData calculateDailyData({
    required DateTime date,
    required List<Map<String, dynamic>> dayFoods,
    required double dailyGoal,
  }) {
    var breakfastNutrients = NutrientsData();
    var lunchNutrients = NutrientsData();
    var dinnerNutrients = NutrientsData();
    var snacksNutrients = NutrientsData();

    double totalCalories = 0.0;
    double breakfastCalories = 0.0;
    double lunchCalories = 0.0;
    double dinnerCalories = 0.0;
    double snacksCalories = 0.0;
    double dayCarbs = 0.0;
    double dayFat = 0.0;
    double dayProtein = 0.0;

    for (final item in dayFoods) {
      final meal = (item['meal'] as String?)?.toLowerCase() ?? 'breakfast';
      final foodData = item['food'] as Map<String, dynamic>? ?? item;
      final foodModel = LogFoodHelper.mapLogFoodToModel(foodData);

      // Calculate multiplier
      final multiplier = _calculateMultiplier(item, foodModel);

      // Calculate nutrients
      final calories = foodModel.calories.toDouble() * multiplier;
      final protein =
          (foodModel.nutrients[NutrientKeys.proteinG] ?? 0.0) * multiplier;
      final carbs =
          (foodModel.nutrients[NutrientKeys.carbsTotalG] ?? 0.0) * multiplier;
      final fat =
          (foodModel.nutrients[NutrientKeys.fatTotalG] ?? 0.0) * multiplier;
      final fiber =
          (foodModel.nutrients[NutrientKeys.fiberG] ?? 0.0) * multiplier;
      final sugar =
          _itemNumber(item, ['sugarG', 'sugarsG', 'sugar']) ??
          (foodModel.nutrients[NutrientKeys.sugarsG] ?? 0.0) * multiplier;
      final saturatedFat =
          _itemNumber(item, ['saturatedFatG', 'saturatedFat']) ??
          (foodModel.nutrients[NutrientKeys.fatSaturatedG] ?? 0.0) * multiplier;
      final polyunsaturatedFat =
          (foodModel.nutrients[NutrientKeys.fatPolyunsatG] ?? 0.0) * multiplier;
      final monounsaturatedFat =
          (foodModel.nutrients[NutrientKeys.fatMonounsatG] ?? 0.0) * multiplier;
      final transFat =
          (foodModel.nutrients[NutrientKeys.fatTransG] ?? 0.0) * multiplier;
      final cholesterol =
          _itemNumber(item, ['cholesterolMg', 'cholesterol']) ??
          (foodModel.nutrients[NutrientKeys.cholesterolMg] ?? 0.0) * multiplier;
      final sodium =
          _itemNumber(item, ['sodiumMg', 'sodium']) ??
          (foodModel.nutrients[NutrientKeys.sodiumMg] ?? 0.0) * multiplier;
      final potassium =
          _itemNumber(item, ['potassiumMg', 'potassium']) ??
          (foodModel.nutrients[NutrientKeys.potassiumMg] ?? 0.0) * multiplier;
      final calcium = _nutrient(item, foodModel, NutrientKeys.calciumMg, [
        'calciumMg',
        'calcium',
      ], multiplier);
      final iron = _nutrient(item, foodModel, NutrientKeys.ironMg, [
        'ironMg',
        'iron',
      ], multiplier);
      final magnesium = _nutrient(item, foodModel, NutrientKeys.magnesiumMg, [
        'magnesiumMg',
        'magnesium',
      ], multiplier);
      final phosphorus = _nutrient(item, foodModel, NutrientKeys.phosphorusMg, [
        'phosphorusMg',
        'phosphorus',
      ], multiplier);
      final zinc = _nutrient(item, foodModel, NutrientKeys.zincMg, [
        'zincMg',
        'zinc',
      ], multiplier);
      final vitaminA = _nutrient(item, foodModel, NutrientKeys.vitaminAUg, [
        'vitaminAUg',
        'vitaminA',
      ], multiplier);
      final vitaminC = _nutrient(item, foodModel, NutrientKeys.vitaminCMg, [
        'vitaminCMg',
        'vitaminC',
      ], multiplier);
      final vitaminD = _nutrient(item, foodModel, NutrientKeys.vitaminDUg, [
        'vitaminDUg',
        'vitaminD',
      ], multiplier);
      final vitaminE = _nutrient(item, foodModel, NutrientKeys.vitaminEMg, [
        'vitaminEMg',
        'vitaminE',
      ], multiplier);
      final vitaminK = _nutrient(item, foodModel, NutrientKeys.vitaminKUg, [
        'vitaminKUg',
        'vitaminK',
      ], multiplier);
      final vitaminB6 = _nutrient(item, foodModel, NutrientKeys.vitaminB6Mg, [
        'vitaminB6Mg',
        'vitaminB6',
      ], multiplier);
      final vitaminB12 = _nutrient(item, foodModel, NutrientKeys.vitaminB12Ug, [
        'vitaminB12Ug',
        'vitaminB12',
      ], multiplier);
      final folateDfe = _nutrient(item, foodModel, NutrientKeys.folateDfeUg, [
        'folateDfeUg',
        'folateDfe',
      ], multiplier);

      // Update totals
      totalCalories += calories;
      dayCarbs += carbs;
      dayFat += fat;
      dayProtein += protein;

      final foodNutrients = NutrientsData(
        protein: protein,
        carbohydrates: carbs,
        fiber: fiber,
        sugar: sugar,
        fat: fat,
        saturatedFat: saturatedFat,
        polyunsaturatedFat: polyunsaturatedFat,
        monounsaturatedFat: monounsaturatedFat,
        transFat: transFat,
        cholesterol: cholesterol,
        sodium: sodium,
        potassium: potassium,
        calcium: calcium,
        iron: iron,
        magnesium: magnesium,
        phosphorus: phosphorus,
        zinc: zinc,
        vitaminA: vitaminA,
        vitaminC: vitaminC,
        vitaminD: vitaminD,
        vitaminE: vitaminE,
        vitaminK: vitaminK,
        vitaminB6: vitaminB6,
        vitaminB12: vitaminB12,
        folateDfe: folateDfe,
      );

      // Group by meal
      switch (meal) {
        case 'breakfast':
          breakfastCalories += calories;
          breakfastNutrients = _addNutrients(breakfastNutrients, foodNutrients);
          break;
        case 'lunch':
          lunchCalories += calories;
          lunchNutrients = _addNutrients(lunchNutrients, foodNutrients);
          break;
        case 'dinner':
          dinnerCalories += calories;
          dinnerNutrients = _addNutrients(dinnerNutrients, foodNutrients);
          break;
        case 'snacks':
        case 'snack':
          snacksCalories += calories;
          snacksNutrients = _addNutrients(snacksNutrients, foodNutrients);
          break;
        default:
          breakfastCalories += calories;
          breakfastNutrients = _addNutrients(breakfastNutrients, foodNutrients);
      }
    }

    final netCalories = totalCalories; // TODO: subtract burned calories
    final dayLabel = DateHelper.getDayLabel(date);

    return DailyCalorieData(
      date: date,
      totalCalories: totalCalories,
      netCalories: netCalories,
      goal: dailyGoal,
      dayLabel: dayLabel,
      breakfastCalories: breakfastCalories,
      lunchCalories: lunchCalories,
      dinnerCalories: dinnerCalories,
      snacksCalories: snacksCalories,
      carbs: dayCarbs,
      fat: dayFat,
      protein: dayProtein,
      breakfastNutrients: breakfastNutrients,
      lunchNutrients: lunchNutrients,
      dinnerNutrients: dinnerNutrients,
      snacksNutrients: snacksNutrients,
    );
  }

  @override
  Map<String, double> calculateTotalNutrients(
    List<Map<String, dynamic>> items,
  ) {
    double totalProtein = 0.0;
    double totalCarbs = 0.0;
    double totalFat = 0.0;
    double totalFiber = 0.0;
    double totalSugar = 0.0;
    double totalSaturatedFat = 0.0;
    double totalPolyunsaturatedFat = 0.0;
    double totalMonounsaturatedFat = 0.0;
    double totalTransFat = 0.0;
    double totalCholesterol = 0.0;
    double totalSodium = 0.0;
    double totalPotassium = 0.0;
    double totalCalcium = 0.0;
    double totalIron = 0.0;
    double totalMagnesium = 0.0;
    double totalPhosphorus = 0.0;
    double totalZinc = 0.0;
    double totalVitaminA = 0.0;
    double totalVitaminC = 0.0;
    double totalVitaminD = 0.0;
    double totalVitaminE = 0.0;
    double totalVitaminK = 0.0;
    double totalVitaminB6 = 0.0;
    double totalVitaminB12 = 0.0;
    double totalFolateDfe = 0.0;

    for (final item in items) {
      final foodData = item['food'] as Map<String, dynamic>? ?? item;
      final foodModel = LogFoodHelper.mapLogFoodToModel(foodData);
      final multiplier = _calculateMultiplier(item, foodModel);

      totalProtein +=
          (foodModel.nutrients[NutrientKeys.proteinG] ?? 0.0) * multiplier;
      totalCarbs +=
          (foodModel.nutrients[NutrientKeys.carbsTotalG] ?? 0.0) * multiplier;
      totalFat +=
          (foodModel.nutrients[NutrientKeys.fatTotalG] ?? 0.0) * multiplier;
      totalFiber +=
          (foodModel.nutrients[NutrientKeys.fiberG] ?? 0.0) * multiplier;
      totalSugar +=
          _itemNumber(item, ['sugarG', 'sugarsG', 'sugar']) ??
          (foodModel.nutrients[NutrientKeys.sugarsG] ?? 0.0) * multiplier;
      totalSaturatedFat +=
          _itemNumber(item, ['saturatedFatG', 'saturatedFat']) ??
          (foodModel.nutrients[NutrientKeys.fatSaturatedG] ?? 0.0) * multiplier;
      totalPolyunsaturatedFat +=
          (foodModel.nutrients[NutrientKeys.fatPolyunsatG] ?? 0.0) * multiplier;
      totalMonounsaturatedFat +=
          (foodModel.nutrients[NutrientKeys.fatMonounsatG] ?? 0.0) * multiplier;
      totalTransFat +=
          (foodModel.nutrients[NutrientKeys.fatTransG] ?? 0.0) * multiplier;
      totalCholesterol +=
          _itemNumber(item, ['cholesterolMg', 'cholesterol']) ??
          (foodModel.nutrients[NutrientKeys.cholesterolMg] ?? 0.0) * multiplier;
      totalSodium +=
          _itemNumber(item, ['sodiumMg', 'sodium']) ??
          (foodModel.nutrients[NutrientKeys.sodiumMg] ?? 0.0) * multiplier;
      totalPotassium +=
          _itemNumber(item, ['potassiumMg', 'potassium']) ??
          (foodModel.nutrients[NutrientKeys.potassiumMg] ?? 0.0) * multiplier;
      totalCalcium += _nutrient(item, foodModel, NutrientKeys.calciumMg, [
        'calciumMg',
        'calcium',
      ], multiplier);
      totalIron += _nutrient(item, foodModel, NutrientKeys.ironMg, [
        'ironMg',
        'iron',
      ], multiplier);
      totalMagnesium += _nutrient(item, foodModel, NutrientKeys.magnesiumMg, [
        'magnesiumMg',
        'magnesium',
      ], multiplier);
      totalPhosphorus += _nutrient(item, foodModel, NutrientKeys.phosphorusMg, [
        'phosphorusMg',
        'phosphorus',
      ], multiplier);
      totalZinc += _nutrient(item, foodModel, NutrientKeys.zincMg, [
        'zincMg',
        'zinc',
      ], multiplier);
      totalVitaminA += _nutrient(item, foodModel, NutrientKeys.vitaminAUg, [
        'vitaminAUg',
        'vitaminA',
      ], multiplier);
      totalVitaminC += _nutrient(item, foodModel, NutrientKeys.vitaminCMg, [
        'vitaminCMg',
        'vitaminC',
      ], multiplier);
      totalVitaminD += _nutrient(item, foodModel, NutrientKeys.vitaminDUg, [
        'vitaminDUg',
        'vitaminD',
      ], multiplier);
      totalVitaminE += _nutrient(item, foodModel, NutrientKeys.vitaminEMg, [
        'vitaminEMg',
        'vitaminE',
      ], multiplier);
      totalVitaminK += _nutrient(item, foodModel, NutrientKeys.vitaminKUg, [
        'vitaminKUg',
        'vitaminK',
      ], multiplier);
      totalVitaminB6 += _nutrient(item, foodModel, NutrientKeys.vitaminB6Mg, [
        'vitaminB6Mg',
        'vitaminB6',
      ], multiplier);
      totalVitaminB12 += _nutrient(item, foodModel, NutrientKeys.vitaminB12Ug, [
        'vitaminB12Ug',
        'vitaminB12',
      ], multiplier);
      totalFolateDfe += _nutrient(item, foodModel, NutrientKeys.folateDfeUg, [
        'folateDfeUg',
        'folateDfe',
      ], multiplier);
    }

    return {
      'protein': totalProtein,
      'carbs': totalCarbs,
      'fat': totalFat,
      'fiber': totalFiber,
      'sugar': totalSugar,
      'saturatedFat': totalSaturatedFat,
      'polyunsaturatedFat': totalPolyunsaturatedFat,
      'monounsaturatedFat': totalMonounsaturatedFat,
      'transFat': totalTransFat,
      'cholesterol': totalCholesterol,
      'sodium': totalSodium,
      'potassium': totalPotassium,
      'calcium': totalCalcium,
      'iron': totalIron,
      'magnesium': totalMagnesium,
      'phosphorus': totalPhosphorus,
      'zinc': totalZinc,
      'vitaminA': totalVitaminA,
      'vitaminC': totalVitaminC,
      'vitaminD': totalVitaminD,
      'vitaminE': totalVitaminE,
      'vitaminK': totalVitaminK,
      'vitaminB6': totalVitaminB6,
      'vitaminB12': totalVitaminB12,
      'folateDfe': totalFolateDfe,
    };
  }

  double _calculateMultiplier(Map<String, dynamic> item, FoodModel foodModel) {
    double toDoubleValue(dynamic v) => (v as num?)?.toDouble() ?? 0.0;
    final double loggedServingSize = toDoubleValue(item['servingSize']);
    final double loggedNumberOfServings = toDoubleValue(
      item['numberOfServings'],
    );

    if (loggedServingSize > 0 && loggedNumberOfServings > 0) {
      final double baseServingSize = foodModel.unitSizes.isNotEmpty
          ? foodModel.unitSizes[0]
          : 1.0;
      return (loggedServingSize * loggedNumberOfServings) / baseServingSize;
    }

    return 1.0;
  }

  double? _itemNumber(Map<String, dynamic> item, List<String> keys) {
    for (final key in keys) {
      final value = item[key];
      if (value is num) return value.toDouble();
      if (value is String) {
        final parsed = double.tryParse(value.trim());
        if (parsed != null) return parsed;
      }
    }
    return null;
  }

  double _nutrient(
    Map<String, dynamic> item,
    FoodModel foodModel,
    String nutrientKey,
    List<String> apiKeys,
    double multiplier,
  ) {
    return _itemNumber(item, apiKeys) ??
        (foodModel.nutrients[nutrientKey] ?? 0.0) * multiplier;
  }

  NutrientsData _addNutrients(NutrientsData existing, NutrientsData toAdd) {
    return NutrientsData(
      protein: existing.protein + toAdd.protein,
      carbohydrates: existing.carbohydrates + toAdd.carbohydrates,
      fiber: existing.fiber + toAdd.fiber,
      sugar: existing.sugar + toAdd.sugar,
      fat: existing.fat + toAdd.fat,
      saturatedFat: existing.saturatedFat + toAdd.saturatedFat,
      polyunsaturatedFat:
          existing.polyunsaturatedFat + toAdd.polyunsaturatedFat,
      monounsaturatedFat:
          existing.monounsaturatedFat + toAdd.monounsaturatedFat,
      transFat: existing.transFat + toAdd.transFat,
      cholesterol: existing.cholesterol + toAdd.cholesterol,
      sodium: existing.sodium + toAdd.sodium,
      potassium: existing.potassium + toAdd.potassium,
      calcium: existing.calcium + toAdd.calcium,
      iron: existing.iron + toAdd.iron,
      magnesium: existing.magnesium + toAdd.magnesium,
      phosphorus: existing.phosphorus + toAdd.phosphorus,
      zinc: existing.zinc + toAdd.zinc,
      vitaminA: existing.vitaminA + toAdd.vitaminA,
      vitaminC: existing.vitaminC + toAdd.vitaminC,
      vitaminD: existing.vitaminD + toAdd.vitaminD,
      vitaminE: existing.vitaminE + toAdd.vitaminE,
      vitaminK: existing.vitaminK + toAdd.vitaminK,
      vitaminB6: existing.vitaminB6 + toAdd.vitaminB6,
      vitaminB12: existing.vitaminB12 + toAdd.vitaminB12,
      folateDfe: existing.folateDfe + toAdd.folateDfe,
    );
  }
}

class NutrientKeys {
  static const String proteinG = 'protein_g';
  static const String carbsTotalG = 'carbs_total_g';
  static const String fatTotalG = 'fat_total_g';
  static const String fiberG = 'fiber_g';
  static const String sugarsG = 'sugars_g';
  static const String fatSaturatedG = 'fat_saturated_g';
  static const String fatPolyunsatG = 'fat_polyunsat_g';
  static const String fatMonounsatG = 'fat_monounsat_g';
  static const String fatTransG = 'fat_trans_g';
  static const String cholesterolMg = 'cholesterol_mg';
  static const String sodiumMg = 'sodium_mg';
  static const String potassiumMg = 'potassium_mg';
  static const String calciumMg = 'calcium_mg';
  static const String ironMg = 'iron_mg';
  static const String magnesiumMg = 'magnesium_mg';
  static const String phosphorusMg = 'phosphorus_mg';
  static const String zincMg = 'zinc_mg';
  static const String vitaminAUg = 'vitamin_a_ug';
  static const String vitaminCMg = 'vitamin_c_mg';
  static const String vitaminDUg = 'vitamin_d_ug';
  static const String vitaminEMg = 'vitamin_e_mg';
  static const String vitaminKUg = 'vitamin_k_ug';
  static const String vitaminB6Mg = 'vitamin_b6_mg';
  static const String vitaminB12Ug = 'vitamin_b12_ug';
  static const String folateDfeUg = 'folate_dfe_ug';
}
