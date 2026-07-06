import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/data/remote/base/api_error.dart';
import '../../../../core/data/remote/base/api_response.dart';
import '../../../../core/data/remote/services/api_service.dart';
import '../../../nutrition/data/helpers/date_helper.dart';
import '../../domain/repository/food_repository.dart';
import '../../helper/log_food_helper.dart';
import '../models/food_model.dart';
import '../models/ingredient_recognition_model.dart';
import '../models/meal_detail_model.dart';
import '../models/meal_summary_model.dart';
import '../models/fridge_manual_quota_model.dart';
import '../models/fridge_meal_plan_result_model.dart';
import '../models/recipe_builder_generate_model.dart';
import '../models/recipe_model.dart';

@LazySingleton(as: FoodRepository)
class FoodRepositoryImpl implements FoodRepository {
  final Dio _dio;

  FoodRepositoryImpl(this._dio);

  MealSummaryModel _mapMealToSummaryModel(Map<String, dynamic> json) {
    int toInt(dynamic v) {
      if (v is int) return v;
      if (v is num) return v.toInt();
      if (v is String) return int.tryParse(v.trim()) ?? 0;
      return 0;
    }

    double toDouble(dynamic v) {
      if (v is num) return v.toDouble();
      if (v is String) return double.tryParse(v.trim()) ?? 0;
      return 0;
    }

    final nutritionSummary =
        json['nutritionSummary'] as Map<String, dynamic>? ?? const {};
    return MealSummaryModel(
      id: toInt(json['id']),
      name: (json['name'] as String?) ?? '',
      directions: json['directions'] as String?,
      imageUrl: (json['imageUrl'] as String?)?.trim(),
      calories: toDouble(nutritionSummary['calories']),
      carbs: toDouble(nutritionSummary['carbs']),
      fat: toDouble(nutritionSummary['fat']),
      protein: toDouble(nutritionSummary['protein']),
      createdAt: DateTime.tryParse((json['createdAt'] ?? '').toString()),
    );
  }

  /// Lấy danh sách thức ăn từ API `/api/Food`
  @override
  Future<Result<List<FoodModel>, ApiError>> getFoods({
    int page = 1,
    int pageSize = 10,
    bool includeAll = false,
  }) async {
    final queryParameters = <String, dynamic>{
      'page': page,
      'pageSize': pageSize,
      'includeAll': includeAll,
    };

    return _dio.get('api/Food', queryParameters: queryParameters).tryGet((
      response,
    ) {
      final data = response.data as Map<String, dynamic>;
      final items = (data['items'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();
      final foods = items.map(LogFoodHelper.mapApiFoodToModel).toList();
      return foods;
    });
  }

  /// Gửi request tạo Food lên API `/api/Food`
  @override
  Future<Result<FoodModel, ApiError>> addFood(FoodModel food) {
    final payload = LogFoodHelper.mapFoodToApiPayload(food);
    return _dio.post('api/Food', data: payload).tryGet((response) {
      // API trả về trực tiếp object food, không wrap trong StatusApiResponse
      final foodData = response.data as Map<String, dynamic>;
      return LogFoodHelper.mapApiFoodToModel(foodData);
    });
  }

  /// Chưa có API update nên tạm để trống
  @override
  Future<Result<FoodModel, ApiError>> updateFood(
    String id,
    FoodModel food,
  ) async {
    final payload = LogFoodHelper.mapFoodToApiPayload(food);
    return _dio.put('api/Food/$id', data: payload).tryGet((response) {
      return LogFoodHelper.mapApiFoodToModel(
        response.data as Map<String, dynamic>,
      );
    });
  }

  /// Chưa có API delete nên tạm để trống
  @override
  Future<Result<StatusApiResponse, ApiError>> deleteFood(String id) async {
    return _dio.delete('api/Food/$id').tryGet((response) {
      return StatusApiResponse.fromJson(response.data as Map<String, dynamic>);
    });
  }

  /// Tìm kiếm thức ăn qua query param `search`
  @override
  Future<Result<List<FoodModel>, ApiError>> searchFoods(
    String query, {
    bool includeAll = true,
    bool mineOnly = false,
    int page = 1,
    int pageSize = 10,
  }) async {
    return _dio
        .get(
          'api/Food',
          queryParameters: {
            'search': query,
            'page': page,
            'pageSize': pageSize,
            'includeAll': includeAll,
            'mineOnly': mineOnly,
          },
        )
        .tryGet((response) {
          final data = response.data as Map<String, dynamic>;
          final items = (data['items'] as List<dynamic>? ?? [])
              .cast<Map<String, dynamic>>();
          final foods = items.map(LogFoodHelper.mapApiFoodToModel).toList();
          return foods;
        });
  }

  /// Dữ liệu gợi ý lấy từ API Food với `includeAll=true`. Load 10 items đầu tiên.
  @override
  Future<List<FoodModel>> getSuggestedFoods({
    int page = 1,
    int pageSize = 10,
  }) async {
    final result = await getFoods(
      page: page,
      pageSize: pageSize,
      includeAll: true,
    );
    return result.fold((foods) => foods, (_) => <FoodModel>[]);
  }

  /// Lấy danh sách log foods từ API `/api/LogFood` với date range
  @override
  Future<Result<List<FoodModel>, ApiError>> getRecentFoods({
    DateTime? startDate,
    DateTime? endDate,
    int page = 1,
    int pageSize = 5,
  }) async {
    final DateTime end = endDate ?? DateTime.now();
    final DateTime start = startDate ?? end.subtract(const Duration(days: 30));

    final queryParameters = <String, dynamic>{
      'page': page,
      'pageSize': pageSize,
      'startDate': DateHelper.formatDateKey(start),
      'endDate': DateHelper.formatDateKey(end),
    };

    return _dio.get('api/LogFood', queryParameters: queryParameters).tryGet((
      response,
    ) {
      final data = response.data as Map<String, dynamic>;
      final items = (data['items'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();
      // Map log food items to FoodModel; newest loggedAt first (matches API + UI)
      final foods = items.map(LogFoodHelper.mapLogFoodToModel).toList();
      LogFoodHelper.sortByLoggedAtNewestFirst(foods);
      return foods;
    });
  }

  @override
  Future<Result<List<FoodModel>, ApiError>> getMyFoods() async {
    return _dio
        .get(
          'api/Food',
          queryParameters: {'page': 1, 'pageSize': 100, 'mineOnly': true},
        )
        .tryGet((response) {
          final data = response.data as Map<String, dynamic>;
          final items = (data['items'] as List<dynamic>? ?? [])
              .cast<Map<String, dynamic>>();
          final foods = items.map(LogFoodHelper.mapApiFoodToModel).toList();
          return foods;
        });
  }

  @override
  Future<Result<MealDetail, ApiError>> getMealDetail(int mealId) {
    return _dio.get('api/Meal/$mealId').tryGet((response) {
      return MealDetail.fromJson(response.data as Map<String, dynamic>);
    });
  }

  @override
  Future<Result<List<MealSummaryModel>, ApiError>> getMyMeals({
    String? search,
    bool includeCommunity = false,
  }) async {
    return _dio
        .get(
          'api/Meal',
          queryParameters: {
            'search': search,
            'page': 1,
            'pageSize': 100,
            'includeCommunity': includeCommunity,
          },
        )
        .tryGet((response) {
          final data = response.data as Map<String, dynamic>;
          final items = (data['items'] as List<dynamic>? ?? [])
              .cast<Map<String, dynamic>>();
          return items.map(_mapMealToSummaryModel).toList();
        });
  }

  @override
  Future<Result<MealSummaryModel, ApiError>> createMeal(
    String name, {
    String? imageUrl,
  }) {
    final payload = <String, dynamic>{'name': name};
    if (imageUrl != null && imageUrl.trim().isNotEmpty) {
      payload['imageUrl'] = imageUrl.trim();
    }
    return _dio.post('api/Meal', data: payload).tryGet((response) {
      return _mapMealToSummaryModel(response.data as Map<String, dynamic>);
    });
  }

  @override
  Future<Result<MealSummaryModel, ApiError>> copyPreviousMeal(String name) {
    return _dio.post('api/Meal/copy-previous', data: {'name': name}).tryGet((
      response,
    ) {
      return _mapMealToSummaryModel(response.data as Map<String, dynamic>);
    });
  }

  @override
  Future<Result<MealSummaryModel, ApiError>> updateMeal(
    int mealId, {
    String? name,
    String? directions,
    int? shareWith,
    String? imageUrl,
  }) {
    final payload = <String, dynamic>{};
    if (name != null) payload['name'] = name;
    if (directions != null) payload['directions'] = directions;
    if (shareWith != null) payload['shareWith'] = shareWith;
    if (imageUrl != null) payload['imageUrl'] = imageUrl.trim();
    return _dio.put('api/Meal/$mealId', data: payload).tryGet((response) {
      return _mapMealToSummaryModel(response.data as Map<String, dynamic>);
    });
  }

  @override
  Future<Result<MealSummaryModel, ApiError>> addFoodToMeal(
    int mealId, {
    required int foodId,
    double quantity = 1,
  }) {
    return _dio
        .post(
          'api/Meal/$mealId/items',
          data: {'foodId': foodId, 'quantity': quantity},
        )
        .tryGet((response) {
          return _mapMealToSummaryModel(response.data as Map<String, dynamic>);
        });
  }

  @override
  Future<Result<MealSummaryModel, ApiError>> updateMealItem(
    int mealId,
    int mealFoodId, {
    double? quantity,
    String? unit,
    int? order,
  }) {
    final payload = <String, dynamic>{};
    if (quantity != null) payload['quantity'] = quantity;
    if (unit != null) payload['unit'] = unit;
    if (order != null) payload['order'] = order;
    return _dio.put('api/Meal/$mealId/items/$mealFoodId', data: payload).tryGet(
      (response) {
        return _mapMealToSummaryModel(response.data as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Result<MealSummaryModel, ApiError>> removeMealItem(
    int mealId,
    int mealFoodId,
  ) {
    return _dio.delete('api/Meal/$mealId/items/$mealFoodId').tryGet((response) {
      return _mapMealToSummaryModel(response.data as Map<String, dynamic>);
    });
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> deleteMeal(int id) {
    return _dio.delete('api/Meal/$id').tryGet((response) {
      return StatusApiResponse.fromJson(response.data as Map<String, dynamic>);
    });
  }

  @override
  Future<Result<List<RecipeModel>, ApiError>> getMyRecipes({
    String? search,
    bool includeCommunity = false,
  }) {
    final trimmed = search?.trim();
    final queryParameters = <String, dynamic>{
      if (trimmed != null && trimmed.isNotEmpty) 'search': trimmed,
      if (includeCommunity) 'includeCommunity': true,
    };
    return _dio
        .get(
          'recipe-builder/recipes',
          queryParameters: queryParameters.isEmpty ? null : queryParameters,
        )
        .tryGet((response) {
          final list = (response.data as List<dynamic>? ?? [])
              .whereType<Map<String, dynamic>>()
              .map(RecipeModel.fromJson)
              .toList();
          return list;
        });
  }

  @override
  Future<Result<RecipeModel, ApiError>> getRecipeById(int recipeId) {
    return _dio
        .get('recipe-builder/recipes/$recipeId')
        .tryGet(
          (response) =>
              RecipeModel.fromJson(response.data as Map<String, dynamic>),
        );
  }

  @override
  Future<Result<RecipeModel, ApiError>> createRecipe(RecipeModel recipe) {
    return _dio
        .post('recipe-builder/recipes', data: recipe.toPayload())
        .tryGet(
          (response) =>
              RecipeModel.fromJson(response.data as Map<String, dynamic>),
        );
  }

  @override
  Future<Result<RecipeModel, ApiError>> updateRecipe(
    int recipeId,
    RecipeModel recipe,
  ) {
    return _dio
        .put('recipe-builder/recipes/$recipeId', data: recipe.toPayload())
        .tryGet(
          (response) =>
              RecipeModel.fromJson(response.data as Map<String, dynamic>),
        );
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> deleteRecipe(int recipeId) {
    return _dio.delete('recipe-builder/recipes/$recipeId').tryGet((response) {
      return StatusApiResponse.fromJson(response.data as Map<String, dynamic>);
    });
  }

  @override
  Future<Result<MealSummaryModel, ApiError>> convertRecipeToMeal(int recipeId) {
    return _dio
        .post('recipe-builder/recipes/$recipeId/convert-to-meal')
        .tryGet(
          (response) =>
              _mapMealToSummaryModel(response.data as Map<String, dynamic>),
        );
  }

  /// Map JSON từ API `/api/Food` sang `FoodModel` nội bộ.

  @override
  Future<Result<FridgeMealPlanResult, ApiError>> generateFridgeMealPlan({
    String? date,
    bool replace = false,
  }) {
    final body = <String, dynamic>{
      if (date != null && date.isNotEmpty) 'date': date,
      if (replace) 'replace': true,
    };
    return _dio.post('fridge-meal-plans/generate', data: body).tryGet((response) {
      return FridgeMealPlanResult.fromJson(
        response.data as Map<String, dynamic>,
      );
    });
  }

  @override
  Future<Result<FridgeGenerationStatus, ApiError>> getFridgeGenerationStatus() {
    return _dio.get('fridge-meal-plans/manual-quota').tryGet(
      (response) => FridgeGenerationStatus.fromJson(
        response.data as Map<String, dynamic>,
      ),
    );
  }

  @override
  Future<Result<FoodModel, ApiError>> getFoodById(int id) {
    return _dio.get('api/Food/$id').tryGet((response) {
      final foodData = response.data as Map<String, dynamic>;
      return LogFoodHelper.mapApiFoodToModel(foodData);
    });
  }

  @override
  Future<Result<List<FoodModel>, ApiError>> getFoodsByIds(List<int> ids) {
    if (ids.isEmpty) {
      return Future.value(Result.success(<FoodModel>[]));
    }
    return _dio.get(
      'api/Food',
      queryParameters: {'ids': ids.join(',')},
    ).tryGet((response) {
      final data = response.data as Map<String, dynamic>;
      final items = (data['items'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();
      final foods = items.map(LogFoodHelper.mapApiFoodToModel).toList();
      return foods;
    });
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> deleteLogFood(int id) async {
    return _dio.delete('api/LogFood/$id').tryGet((response) {
      return StatusApiResponse(
        message: 'Log food deleted successfully',
        statusCode: 200,
      );
    });
  }

  @override
  Future<Result<List<FoodModel>, ApiError>> getMyStapleFoods() {
    return _dio.get('recipe-builder/staples').tryGet((response) {
      final list = (response.data as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(LogFoodHelper.mapApiFoodToModel)
          .toList();
      return list;
    });
  }

  @override
  Future<Result<bool, ApiError>> addStapleFood(int foodId) {
    return _dio
        .post('recipe-builder/staples', data: {'foodId': foodId})
        .tryGet((_) => true);
  }

  @override
  Future<Result<bool, ApiError>> removeStapleFood(int foodId) {
    return _dio.delete('recipe-builder/staples/$foodId').tryGet((_) => true);
  }

  @override
  Future<Result<IngredientRecognitionResultModel, ApiError>>
  recognizeIngredientsFromImage(String imageUrl, {int topK = 5}) {
    return _dio
        .post(
          'recipe-builder/vision/recognize',
          data: {'imageUrl': imageUrl, 'topK': topK},
        )
        .tryGet((response) {
          return IngredientRecognitionResultModel.fromJson(
            response.data as Map<String, dynamic>,
          );
        });
  }

  @override
  Future<Result<IngredientRecognitionResultModel, ApiError>>
  matchIngredientNames(
    List<MatchIngredientRequest> ingredients, {
    int topK = 5,
  }) {
    return _dio
        .post(
          'recipe-builder/vision/match',
          data: {
            'ingredients': ingredients.map((e) => e.toJson()).toList(),
            'topK': topK,
          },
        )
        .tryGet((response) {
          return IngredientRecognitionResultModel.fromJson(
            response.data as Map<String, dynamic>,
          );
        });
  }

  @override
  Future<Result<RecipeBuilderGenerateResult, ApiError>>
  generateRecipeFromStaples({
    required String mealSlot,
    String? date,
    Map<String, dynamic>? constraints,
    List<int>? foodIds,
  }) {
    final body = <String, dynamic>{
      'mealSlot': mealSlot,
      if (date != null && date.isNotEmpty) 'date': date,
      if (constraints != null && constraints.isNotEmpty)
        'constraints': constraints,
      if (foodIds != null && foodIds.isNotEmpty) 'foodIds': foodIds,
    };
    return _dio.post('recipe-builder/generate', data: body).tryGet((response) {
      return RecipeBuilderGenerateResult.fromJson(
        response.data as Map<String, dynamic>,
      );
    });
  }
}
