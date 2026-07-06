import '../../../logfood/helper/log_food_helper.dart';

class MealCalculator {
  static MealCalories calculateMealCalories(
    List<Map<String, dynamic>> dayFoods,
  ) {
    double breakfastCalories = 0.0;
    double lunchCalories = 0.0;
    double dinnerCalories = 0.0;
    double snacksCalories = 0.0;

    for (final item in dayFoods) {
      final meal = (item['meal'] as String?)?.toLowerCase() ?? 'breakfast';
      final foodData = item['food'] as Map<String, dynamic>? ?? item;
      final foodModel = LogFoodHelper.mapLogFoodToModel(foodData);
      final calories = foodModel.calories.toDouble();

      switch (meal) {
        case 'breakfast':
          breakfastCalories += calories;
          break;
        case 'lunch':
          lunchCalories += calories;
          break;
        case 'dinner':
          dinnerCalories += calories;
          break;
        case 'snacks':
        case 'snack':
          snacksCalories += calories;
          break;
        default:
          breakfastCalories += calories;
      }
    }

    return MealCalories(
      breakfast: breakfastCalories,
      lunch: lunchCalories,
      dinner: dinnerCalories,
      snacks: snacksCalories,
    );
  }
}

class MealCalories {
  final double breakfast;
  final double lunch;
  final double dinner;
  final double snacks;

  const MealCalories({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snacks,
  });
}
