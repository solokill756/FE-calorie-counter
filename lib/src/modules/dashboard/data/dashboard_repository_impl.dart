import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../logfood/helper/log_food_helper.dart';
import '../domain/repository/dashboard_repository.dart';
import 'models/dashboard_today_response.dart';

@LazySingleton(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl(this._dio);

  final Dio _dio;

  String get _todayDateKey => LogFoodHelper().dateKeyFrom(DateTime.now());

  @override
  Future<DashboardTodayResponse> getTodayDashboard() async {
    final res = await _dio.get<Map<String, dynamic>>(
      'api/dashboard/today',
      queryParameters: <String, dynamic>{'date': _todayDateKey},
    );
    final data = res.data;
    if (data == null) {
      throw DioException(
        requestOptions: res.requestOptions,
        message: 'Empty dashboard response',
      );
    }
    return DashboardTodayResponse.fromJson(data);
  }

  @override
  Future<DashboardAiSuggestion> getTodaySuggestion() async {
    final res = await _dio.get<Map<String, dynamic>>(
      'api/dashboard/today/suggestion',
      queryParameters: <String, dynamic>{'date': _todayDateKey},
    );
    final data = res.data;
    if (data == null) {
      throw DioException(
        requestOptions: res.requestOptions,
        message: 'Empty dashboard suggestion response',
      );
    }
    return DashboardAiSuggestion.fromJson(data);
  }
}
