import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:caloriecounter/src/modules/logfood/helper/log_food_helper.dart';

import 'models/water_log_models.dart';
import '../domain/repository/water_log_repository.dart';

@LazySingleton(as: WaterLogRepository)
class WaterLogRepositoryImpl implements WaterLogRepository {
  WaterLogRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<WaterTodayDto> getToday() async {
    final res = await _dio.get<Map<String, dynamic>>('api/water-log/today');
    final data = res.data;
    if (data == null) {
      throw DioException(
        requestOptions: res.requestOptions,
        message: 'Empty water today response',
      );
    }
    return WaterTodayDto.fromJson(data);
  }

  @override
  Future<AddWaterResultDto> addMl(int amountMl) async {
    final dateKey = LogFoodHelper().dateKeyFrom(DateTime.now());
    final res = await _dio.post<Map<String, dynamic>>(
      'api/water-log/add',
      data: <String, dynamic>{'amountMl': amountMl, 'date': dateKey},
    );
    final data = res.data;
    if (data == null) {
      throw DioException(
        requestOptions: res.requestOptions,
        message: 'Empty add water response',
      );
    }
    return AddWaterResultDto.fromJson(data);
  }

  @override
  Future<AddWaterResultDto> setTodayTotal(int amountMl) async {
    final res = await _dio.put<Map<String, dynamic>>(
      'api/water-log/today',
      data: <String, dynamic>{'amountMl': amountMl},
    );
    final data = res.data;
    if (data == null) {
      throw DioException(
        requestOptions: res.requestOptions,
        message: 'Empty set water response',
      );
    }
    return AddWaterResultDto.fromJson(data);
  }

  @override
  Future<List<WaterHistoryRowDto>> history({
    required String from,
    required String to,
  }) async {
    final res = await _dio.get<List<dynamic>>(
      'api/water-log/history',
      queryParameters: <String, dynamic>{
        'from': from,
        'to': to,
      },
    );
    final data = res.data;
    if (data == null) return [];
    return data
        .map((e) => WaterHistoryRowDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
