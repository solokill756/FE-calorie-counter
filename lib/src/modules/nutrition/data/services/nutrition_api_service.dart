import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class NutritionApiService {
  /// Fetch log foods data from API for a date range
  Future<List<Map<String, dynamic>>> fetchLogFoodsFromApi({
    required String startDate,
    required String endDate,
    int page = 1,
    int pageSize = 1000,
    bool includeQuickAdd = true,
  });
}

@LazySingleton(as: NutritionApiService)
class NutritionApiServiceImpl implements NutritionApiService {
  final Dio _dio;

  NutritionApiServiceImpl(this._dio);

  @override
  Future<List<Map<String, dynamic>>> fetchLogFoodsFromApi({
    required String startDate,
    required String endDate,
    int page = 1,
    int pageSize = 1000,
    bool includeQuickAdd = true,
  }) async {
    try {
      final queryParameters = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
        'startDate': startDate,
        'endDate': endDate,
        'includeQuickAdd': includeQuickAdd,
      };

      final response = await _dio.get(
        'api/LogFood',
        queryParameters: queryParameters,
      );

      final data = response.data as Map<String, dynamic>;
      final items = (data['items'] as List<dynamic>? ?? [])
          .cast<Map<String, dynamic>>();

      return items;
    } catch (e) {
      rethrow;
    }
  }
}
