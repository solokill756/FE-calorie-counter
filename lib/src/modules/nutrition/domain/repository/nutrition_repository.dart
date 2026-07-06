import '../../../logfood/data/models/log_food_model.dart';
import '../entities/nutrition_data_entity.dart';

abstract class NutritionRepository {
  Future<WeeklyNutritionData> getDailyData(DateTime date);
  Future<WeeklyNutritionData> getWeeklyData(DateTime startDate);
  Future<WeeklyNutritionData> getMonthlyData(DateTime startDate);
  Future<List<String>> getFoodsHighestInCalories(List<LogFoodModel> logFoods);
  Future<List<String>> getFoodsHighestInCarbohydrates(
    List<LogFoodModel> logFoods,
  );
  Future<List<String>> getFoodsHighestInFat(List<LogFoodModel> logFoods);
  Future<List<String>> getFoodsHighestInProtein(List<LogFoodModel> logFoods);
  Future<List<String>> getFoodsHighestInNutrient(
    List<LogFoodModel> logFoods,
    String nutrientKey,
    String unit, // 'g', 'mg', '%', 'cal'
    int? limit, // Optional limit, null means no limit
  );
}
