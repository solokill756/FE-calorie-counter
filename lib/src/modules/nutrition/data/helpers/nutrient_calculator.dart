import '../../../logfood/data/models/food_model.dart';
import '../../../logfood/helper/log_food_helper.dart';
import '../../domain/entities/nutrition_data_entity.dart';

class NutrientCalculator {
  static NutrientsData calculateAverageNutrients({
    required List<Map<String, dynamic>> items,
    required int days,
  }) {
    final totals = _calculateTotals(items);
    return _createNutrientsData(totals, days);
  }

  static _NutrientTotals _calculateTotals(List<Map<String, dynamic>> items) {
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
          (foodModel.nutrients[NutrientKeys.sugarsG] ?? 0.0) * multiplier;
      totalSaturatedFat +=
          (foodModel.nutrients[NutrientKeys.fatSaturatedG] ?? 0.0) * multiplier;
      totalPolyunsaturatedFat +=
          (foodModel.nutrients[NutrientKeys.fatPolyunsatG] ?? 0.0) * multiplier;
      totalMonounsaturatedFat +=
          (foodModel.nutrients[NutrientKeys.fatMonounsatG] ?? 0.0) * multiplier;
      totalTransFat +=
          (foodModel.nutrients[NutrientKeys.fatTransG] ?? 0.0) * multiplier;
      totalCholesterol +=
          (foodModel.nutrients[NutrientKeys.cholesterolMg] ?? 0.0) * multiplier;
      totalSodium +=
          (foodModel.nutrients[NutrientKeys.sodiumMg] ?? 0.0) * multiplier;
      totalPotassium +=
          (foodModel.nutrients[NutrientKeys.potassiumMg] ?? 0.0) * multiplier;
      totalCalcium +=
          (foodModel.nutrients[NutrientKeys.calciumMg] ?? 0.0) * multiplier;
      totalIron +=
          (foodModel.nutrients[NutrientKeys.ironMg] ?? 0.0) * multiplier;
      totalMagnesium +=
          (foodModel.nutrients[NutrientKeys.magnesiumMg] ?? 0.0) * multiplier;
      totalPhosphorus +=
          (foodModel.nutrients[NutrientKeys.phosphorusMg] ?? 0.0) * multiplier;
      totalZinc +=
          (foodModel.nutrients[NutrientKeys.zincMg] ?? 0.0) * multiplier;
      totalVitaminA +=
          (foodModel.nutrients[NutrientKeys.vitaminAUg] ?? 0.0) * multiplier;
      totalVitaminC +=
          (foodModel.nutrients[NutrientKeys.vitaminCMg] ?? 0.0) * multiplier;
      totalVitaminD +=
          (foodModel.nutrients[NutrientKeys.vitaminDUg] ?? 0.0) * multiplier;
      totalVitaminE +=
          (foodModel.nutrients[NutrientKeys.vitaminEMg] ?? 0.0) * multiplier;
      totalVitaminK +=
          (foodModel.nutrients[NutrientKeys.vitaminKUg] ?? 0.0) * multiplier;
      totalVitaminB6 +=
          (foodModel.nutrients[NutrientKeys.vitaminB6Mg] ?? 0.0) * multiplier;
      totalVitaminB12 +=
          (foodModel.nutrients[NutrientKeys.vitaminB12Ug] ?? 0.0) * multiplier;
      totalFolateDfe +=
          (foodModel.nutrients[NutrientKeys.folateDfeUg] ?? 0.0) * multiplier;
    }

    return _NutrientTotals(
      protein: totalProtein,
      carbohydrates: totalCarbs,
      fiber: totalFiber,
      sugar: totalSugar,
      fat: totalFat,
      saturatedFat: totalSaturatedFat,
      polyunsaturatedFat: totalPolyunsaturatedFat,
      monounsaturatedFat: totalMonounsaturatedFat,
      transFat: totalTransFat,
      cholesterol: totalCholesterol,
      sodium: totalSodium,
      potassium: totalPotassium,
      calcium: totalCalcium,
      iron: totalIron,
      magnesium: totalMagnesium,
      phosphorus: totalPhosphorus,
      zinc: totalZinc,
      vitaminA: totalVitaminA,
      vitaminC: totalVitaminC,
      vitaminD: totalVitaminD,
      vitaminE: totalVitaminE,
      vitaminK: totalVitaminK,
      vitaminB6: totalVitaminB6,
      vitaminB12: totalVitaminB12,
      folateDfe: totalFolateDfe,
    );
  }

  static NutrientsData _createNutrientsData(_NutrientTotals totals, int days) {
    return NutrientsData(
      protein: totals.protein / days,
      carbohydrates: totals.carbohydrates / days,
      fiber: totals.fiber / days,
      sugar: totals.sugar / days,
      fat: totals.fat / days,
      saturatedFat: totals.saturatedFat / days,
      polyunsaturatedFat: totals.polyunsaturatedFat / days,
      monounsaturatedFat: totals.monounsaturatedFat / days,
      transFat: totals.transFat / days,
      cholesterol: totals.cholesterol / days,
      sodium: totals.sodium / days,
      potassium: totals.potassium / days,
      calcium: totals.calcium / days,
      iron: totals.iron / days,
      magnesium: totals.magnesium / days,
      phosphorus: totals.phosphorus / days,
      zinc: totals.zinc / days,
      vitaminA: totals.vitaminA / days,
      vitaminC: totals.vitaminC / days,
      vitaminD: totals.vitaminD / days,
      vitaminE: totals.vitaminE / days,
      vitaminK: totals.vitaminK / days,
      vitaminB6: totals.vitaminB6 / days,
      vitaminB12: totals.vitaminB12 / days,
      folateDfe: totals.folateDfe / days,
    );
  }

  static double _calculateMultiplier(
    Map<String, dynamic> item,
    FoodModel foodModel,
  ) {
    double toDoubleValue(dynamic v) => (v as num?)?.toDouble() ?? 0.0;
    final loggedServingSize = toDoubleValue(item['servingSize']);
    final loggedNumberOfServings = toDoubleValue(item['numberOfServings']);

    if (loggedServingSize > 0 && loggedNumberOfServings > 0) {
      final baseServingSize = foodModel.unitSizes.isNotEmpty
          ? foodModel.unitSizes[0]
          : 1.0;
      return (loggedServingSize * loggedNumberOfServings) / baseServingSize;
    }
    return 1.0;
  }
}

class _NutrientTotals {
  final double protein;
  final double carbohydrates;
  final double fiber;
  final double sugar;
  final double fat;
  final double saturatedFat;
  final double polyunsaturatedFat;
  final double monounsaturatedFat;
  final double transFat;
  final double cholesterol;
  final double sodium;
  final double potassium;
  final double calcium;
  final double iron;
  final double magnesium;
  final double phosphorus;
  final double zinc;
  final double vitaminA;
  final double vitaminC;
  final double vitaminD;
  final double vitaminE;
  final double vitaminK;
  final double vitaminB6;
  final double vitaminB12;
  final double folateDfe;

  const _NutrientTotals({
    required this.protein,
    required this.carbohydrates,
    required this.fiber,
    required this.sugar,
    required this.fat,
    required this.saturatedFat,
    required this.polyunsaturatedFat,
    required this.monounsaturatedFat,
    required this.transFat,
    required this.cholesterol,
    required this.sodium,
    required this.potassium,
    required this.calcium,
    required this.iron,
    required this.magnesium,
    required this.phosphorus,
    required this.zinc,
    required this.vitaminA,
    required this.vitaminC,
    required this.vitaminD,
    required this.vitaminE,
    required this.vitaminK,
    required this.vitaminB6,
    required this.vitaminB12,
    required this.folateDfe,
  });
}
