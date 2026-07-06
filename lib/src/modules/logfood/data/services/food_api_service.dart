import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/data/remote/base/api_error.dart';
import '../../../../core/data/remote/base/api_response.dart';
import '../../../../core/data/remote/services/api_service.dart';
import '../../../nutrition/data/helpers/date_helper.dart';

abstract class FoodApiService {
  /// GET /api/Food - Get list of foods
  Future<Result<List<Map<String, dynamic>>, ApiError>> getFoods({
    int page = 1,
    int pageSize = 10,
    bool includeAll = false,
  });

  /// POST /api/Food - Create new food
  Future<Result<Map<String, dynamic>, ApiError>> addFood(
    Map<String, dynamic> payload,
  );

  /// PUT /api/Food/{id} - Update food
  Future<Result<Map<String, dynamic>, ApiError>> updateFood(
    String id,
    Map<String, dynamic> payload,
  );

  /// DELETE /api/Food/{id} - Delete food
  Future<Result<StatusApiResponse, ApiError>> deleteFood(String id);

  /// GET /api/Food?search={query} - Search foods
  Future<Result<List<Map<String, dynamic>>, ApiError>> searchFoods(
    String query, {
    int page = 1,
    int pageSize = 10,
  });

  /// GET /api/LogFood - Get recent/logged foods
  Future<Result<List<Map<String, dynamic>>, ApiError>> getRecentFoods({
    DateTime? startDate,
    DateTime? endDate,
    int page = 1,
    int pageSize = 5,
  });

  /// GET /api/Food/{id} - Get food by ID
  Future<Result<Map<String, dynamic>, ApiError>> getFoodById(int id);

  /// DELETE /api/LogFood/{id} - Delete log food
  Future<Result<StatusApiResponse, ApiError>> deleteLogFood(int id);

  Future<Result<List<Map<String, dynamic>>, ApiError>> getMyRecipes({
    String? search,
  });
  Future<Result<Map<String, dynamic>, ApiError>> createRecipe(
    Map<String, dynamic> payload,
  );
  Future<Result<Map<String, dynamic>, ApiError>> updateRecipe(
    int recipeId,
    Map<String, dynamic> payload,
  );
  Future<Result<StatusApiResponse, ApiError>> deleteRecipe(int recipeId);
  Future<Result<Map<String, dynamic>, ApiError>> convertRecipeToMeal(
    int recipeId,
  );
}

@LazySingleton(as: FoodApiService)
class FoodApiServiceImpl implements FoodApiService {
  final Dio _dio;

  FoodApiServiceImpl(this._dio);

  @override
  Future<Result<List<Map<String, dynamic>>, ApiError>> getFoods({
    int page = 1,
    int pageSize = 10,
    bool includeAll = false,
  }) {
    return _dio
        .get(
          'api/Food',
          queryParameters: {
            'page': page,
            'pageSize': pageSize,
            'includeAll': includeAll,
          },
        )
        .tryGet((response) {
          final data = response.data as Map<String, dynamic>;
          return (data['items'] as List<dynamic>? ?? [])
              .cast<Map<String, dynamic>>();
        });
  }

  @override
  Future<Result<Map<String, dynamic>, ApiError>> addFood(
    Map<String, dynamic> payload,
  ) {
    return _dio.post('api/Food', data: payload).tryGet((response) {
      return response.data as Map<String, dynamic>;
    });
  }

  @override
  Future<Result<Map<String, dynamic>, ApiError>> updateFood(
    String id,
    Map<String, dynamic> payload,
  ) {
    return _dio.put('api/Food/$id', data: payload).tryGet((response) {
      return response.data as Map<String, dynamic>;
    });
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> deleteFood(String id) {
    return _dio.delete('api/Food/$id').tryGet((response) {
      return StatusApiResponse.fromJson(response.data as Map<String, dynamic>);
    });
  }

  @override
  Future<Result<List<Map<String, dynamic>>, ApiError>> searchFoods(
    String query, {
    int page = 1,
    int pageSize = 10,
  }) {
    return _dio
        .get(
          'api/Food',
          queryParameters: {
            'search': query,
            'page': page,
            'pageSize': pageSize,
          },
        )
        .tryGet((response) {
          final data = response.data as Map<String, dynamic>;
          return (data['items'] as List<dynamic>? ?? [])
              .cast<Map<String, dynamic>>();
        });
  }

  @override
  Future<Result<List<Map<String, dynamic>>, ApiError>> getRecentFoods({
    DateTime? startDate,
    DateTime? endDate,
    int page = 1,
    int pageSize = 5,
  }) {
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
      return (data['items'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();
    });
  }

  @override
  Future<Result<Map<String, dynamic>, ApiError>> getFoodById(int id) {
    return _dio.get('api/Food/$id').tryGet((response) {
      return response.data as Map<String, dynamic>;
    });
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> deleteLogFood(int id) {
    return _dio.delete('api/LogFood/$id').tryGet((response) {
      return const StatusApiResponse(
        message: 'Log food deleted successfully',
        statusCode: 200,
      );
    });
  }

  @override
  Future<Result<List<Map<String, dynamic>>, ApiError>> getMyRecipes({
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
          return (response.data as List<dynamic>? ?? [])
              .whereType<Map<String, dynamic>>()
              .toList();
        });
  }

  @override
  Future<Result<Map<String, dynamic>, ApiError>> createRecipe(
    Map<String, dynamic> payload,
  ) {
    return _dio.post('recipe-builder/recipes', data: payload).tryGet((
      response,
    ) {
      return response.data as Map<String, dynamic>;
    });
  }

  @override
  Future<Result<Map<String, dynamic>, ApiError>> updateRecipe(
    int recipeId,
    Map<String, dynamic> payload,
  ) {
    return _dio.put('recipe-builder/recipes/$recipeId', data: payload).tryGet((
      response,
    ) {
      return response.data as Map<String, dynamic>;
    });
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> deleteRecipe(int recipeId) {
    return _dio.delete('recipe-builder/recipes/$recipeId').tryGet((response) {
      return StatusApiResponse.fromJson(response.data as Map<String, dynamic>);
    });
  }

  @override
  Future<Result<Map<String, dynamic>, ApiError>> convertRecipeToMeal(
    int recipeId,
  ) {
    return _dio
        .post('recipe-builder/recipes/$recipeId/convert-to-meal')
        .tryGet((response) => response.data as Map<String, dynamic>);
  }
}
