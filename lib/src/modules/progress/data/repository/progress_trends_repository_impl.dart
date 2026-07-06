import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/progress_trends_models.dart';
import '../../domain/repository/progress_trends_repository.dart';

@LazySingleton(as: ProgressTrendsRepository)
class ProgressTrendsRepositoryImpl implements ProgressTrendsRepository {
  ProgressTrendsRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<ProgressTrendsResponse> fetchTrends({
    required String from,
    required String to,
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      'api/progress/trends',
      queryParameters: <String, dynamic>{'from': from, 'to': to},
    );
    final data = res.data;
    if (data == null) {
      throw DioException(
        requestOptions: res.requestOptions,
        message: 'Empty progress trends response',
      );
    }
    return ProgressTrendsResponse.fromJson(data);
  }
}
