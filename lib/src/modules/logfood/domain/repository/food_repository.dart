import 'package:caloriecounter/src/core/data/remote/base/api_error.dart';
import 'package:caloriecounter/src/core/data/remote/base/api_response.dart';
import 'package:result_dart/result_dart.dart';

import '../../data/models/food_model.dart';
import '../../data/models/ingredient_recognition_model.dart';
import '../../data/models/meal_detail_model.dart';
import '../../data/models/meal_summary_model.dart';
import '../../data/models/fridge_manual_quota_model.dart';
import '../../data/models/fridge_meal_plan_result_model.dart';
import '../../data/models/recipe_builder_generate_model.dart';
import '../../data/models/recipe_model.dart';

abstract class FoodRepository {
  Future<Result<List<FoodModel>, ApiError>> getFoods({
    int page = 1,
    int pageSize = 10,
    bool includeAll = false,
  });
  Future<Result<FoodModel, ApiError>> addFood(FoodModel food);
  Future<Result<FoodModel, ApiError>> updateFood(String id, FoodModel food);
  Future<Result<StatusApiResponse, ApiError>> deleteFood(String id);
  Future<Result<List<FoodModel>, ApiError>> searchFoods(
    String query, {
    bool includeAll = true,
    bool mineOnly = false,
    int page = 1,
    int pageSize = 10,
  });
  Future<List<FoodModel>> getSuggestedFoods({int page = 1, int pageSize = 10});
  Future<Result<List<FoodModel>, ApiError>> getRecentFoods({
    DateTime? startDate,
    DateTime? endDate,
    int page = 1,
    int pageSize = 5,
  });
  Future<Result<List<FoodModel>, ApiError>> getMyFoods();
  Future<Result<List<MealSummaryModel>, ApiError>> getMyMeals({
    String? search,
    bool includeCommunity = false,
  });
  Future<Result<MealDetail, ApiError>> getMealDetail(int mealId);
  Future<Result<MealSummaryModel, ApiError>> createMeal(
    String name, {
    String? imageUrl,
  });
  Future<Result<MealSummaryModel, ApiError>> copyPreviousMeal(String name);
  Future<Result<MealSummaryModel, ApiError>> updateMeal(
    int mealId, {
    String? name,
    String? directions,
    int? shareWith,
    String? imageUrl,
  });
  Future<Result<MealSummaryModel, ApiError>> addFoodToMeal(
    int mealId, {
    required int foodId,
    double quantity = 1,
  });
  Future<Result<MealSummaryModel, ApiError>> updateMealItem(
    int mealId,
    int mealFoodId, {
    double? quantity,
    String? unit,
    int? order,
  });
  Future<Result<MealSummaryModel, ApiError>> removeMealItem(
    int mealId,
    int mealFoodId,
  );
  Future<Result<StatusApiResponse, ApiError>> deleteMeal(int id);
  Future<Result<List<RecipeModel>, ApiError>> getMyRecipes({
    String? search,
    bool includeCommunity = false,
  });
  Future<Result<RecipeModel, ApiError>> getRecipeById(int recipeId);
  Future<Result<RecipeModel, ApiError>> createRecipe(RecipeModel recipe);
  Future<Result<RecipeModel, ApiError>> updateRecipe(
    int recipeId,
    RecipeModel recipe,
  );
  Future<Result<StatusApiResponse, ApiError>> deleteRecipe(int recipeId);
  Future<Result<MealSummaryModel, ApiError>> convertRecipeToMeal(int recipeId);
  Future<Result<FridgeMealPlanResult, ApiError>> generateFridgeMealPlan({
    String? date,
    bool replace = false,
  });
  Future<Result<FridgeGenerationStatus, ApiError>> getFridgeGenerationStatus();
  Future<Result<FoodModel, ApiError>> getFoodById(int id);
  Future<Result<List<FoodModel>, ApiError>> getFoodsByIds(List<int> ids);
  Future<Result<StatusApiResponse, ApiError>> deleteLogFood(int id);

  Future<Result<List<FoodModel>, ApiError>> getMyStapleFoods();
  Future<Result<bool, ApiError>> addStapleFood(int foodId);
  Future<Result<bool, ApiError>> removeStapleFood(int foodId);
  Future<Result<IngredientRecognitionResultModel, ApiError>>
  recognizeIngredientsFromImage(String imageUrl, {int topK = 5});
  Future<Result<IngredientRecognitionResultModel, ApiError>>
  matchIngredientNames(
    List<MatchIngredientRequest> ingredients, {
    int topK = 5,
  });
  Future<Result<RecipeBuilderGenerateResult, ApiError>>
  generateRecipeFromStaples({
    required String mealSlot,
    String? date,
    Map<String, dynamic>? constraints,
    List<int>? foodIds,
  });
}

class MatchIngredientRequest {
  const MatchIngredientRequest({this.clientIngredientId, required this.name});

  final String? clientIngredientId;
  final String name;

  Map<String, dynamic> toJson() => {
    if (clientIngredientId != null && clientIngredientId!.isNotEmpty)
      'clientIngredientId': clientIngredientId,
    'name': name,
  };
}
