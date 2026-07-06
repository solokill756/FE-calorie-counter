import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_data_entity.freezed.dart';

@freezed
class DailyCalorieData with _$DailyCalorieData {
  const factory DailyCalorieData({
    required DateTime date,
    required double totalCalories,
    required double netCalories,
    required double goal,
    required String dayLabel,
    @Default(0.0) double breakfastCalories,
    @Default(0.0) double lunchCalories,
    @Default(0.0) double dinnerCalories,
    @Default(0.0) double snacksCalories,
    @Default(0.0) double carbs,
    @Default(0.0) double fat,
    @Default(0.0) double protein,
    @Default(NutrientsData()) NutrientsData breakfastNutrients,
    @Default(NutrientsData()) NutrientsData lunchNutrients,
    @Default(NutrientsData()) NutrientsData dinnerNutrients,
    @Default(NutrientsData()) NutrientsData snacksNutrients,
  }) = _DailyCalorieData;
}

@freezed
class NutrientsData with _$NutrientsData {
  const factory NutrientsData({
    @Default(0.0) double protein,
    @Default(0.0) double carbohydrates,
    @Default(0.0) double fiber,
    @Default(0.0) double sugar,
    @Default(0.0) double fat,
    @Default(0.0) double saturatedFat,
    @Default(0.0) double polyunsaturatedFat,
    @Default(0.0) double monounsaturatedFat,
    @Default(0.0) double transFat,
    @Default(0.0) double cholesterol,
    @Default(0.0) double sodium,
    @Default(0.0) double potassium,
    @Default(0.0) double calcium,
    @Default(0.0) double iron,
    @Default(0.0) double magnesium,
    @Default(0.0) double phosphorus,
    @Default(0.0) double zinc,
    @Default(0.0) double vitaminA,
    @Default(0.0) double vitaminC,
    @Default(0.0) double vitaminD,
    @Default(0.0) double vitaminE,
    @Default(0.0) double vitaminK,
    @Default(0.0) double vitaminB6,
    @Default(0.0) double vitaminB12,
    @Default(0.0) double folateDfe,
  }) = _NutrientsData;
}

@freezed
class MacrosData with _$MacrosData {
  const factory MacrosData({
    @Default(0.0) double carbs,
    @Default(0.0) double fat,
    @Default(0.0) double protein,
    @Default(0.0) double carbsGoal,
    @Default(0.0) double fatGoal,
    @Default(0.0) double proteinGoal,
    @Default(0.0) double carbsGoalPercent,
    @Default(0.0) double fatGoalPercent,
    @Default(0.0) double proteinGoalPercent,
  }) = _MacrosData;
}

@freezed
class WeeklyNutritionData with _$WeeklyNutritionData {
  const factory WeeklyNutritionData({
    required List<DailyCalorieData> dailyData,
    required double weeklyGoal,
    required double netAverage,
    required double netCaloriesUnderGoal,
    @Default(NutrientsData()) NutrientsData nutrients,
    @Default(MacrosData()) MacrosData macros,
  }) = _WeeklyNutritionData;
}

extension DailyCalorieDataMealNutrients on DailyCalorieData {
  NutrientsData getNutrientsByMeal(String meal) {
    switch (meal.toLowerCase()) {
      case 'breakfast':
        return breakfastNutrients;
      case 'lunch':
        return lunchNutrients;
      case 'dinner':
        return dinnerNutrients;
      case 'snacks':
      case 'snack':
        return snacksNutrients;
      default:
        return NutrientsData();
    }
  }

  // Helper để lấy một nutrient cụ thể theo bữa
  double getNutrientByMeal(String meal, String nutrientKey) {
    final nutrients = getNutrientsByMeal(meal);
    final normalizedKey = nutrientKey.toLowerCase().replaceAll(
      RegExp(r'[^a-z0-9]'),
      '',
    );

    switch (normalizedKey) {
      case 'protein':
        return nutrients.protein;
      case 'carbohydrates':
      case 'carbs':
      case 'totalcarbohydrates':
        return nutrients.carbohydrates;
      case 'fiber':
      case 'dietaryfiber':
        return nutrients.fiber;
      case 'sugar':
      case 'sugars':
        return nutrients.sugar;
      case 'fat':
      case 'totalfat':
        return nutrients.fat;
      case 'saturatedfat':
        return nutrients.saturatedFat;
      case 'cholesterol':
        return nutrients.cholesterol;
      case 'sodium':
        return nutrients.sodium;
      case 'potassium':
        return nutrients.potassium;
      case 'calcium':
        return nutrients.calcium;
      case 'iron':
        return nutrients.iron;
      case 'magnesium':
        return nutrients.magnesium;
      case 'phosphorus':
        return nutrients.phosphorus;
      case 'zinc':
        return nutrients.zinc;
      case 'vitamina':
        return nutrients.vitaminA;
      case 'vitaminc':
        return nutrients.vitaminC;
      case 'vitamind':
        return nutrients.vitaminD;
      case 'vitamine':
        return nutrients.vitaminE;
      case 'vitamink':
        return nutrients.vitaminK;
      case 'vitaminb6':
        return nutrients.vitaminB6;
      case 'vitaminb12':
        return nutrients.vitaminB12;
      case 'folate':
      case 'folatedfe':
        return nutrients.folateDfe;
      default:
        return 0.0;
    }
  }
}
