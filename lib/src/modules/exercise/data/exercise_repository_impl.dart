import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../logfood/helper/log_food_helper.dart';
import '../domain/models/exercise_models.dart';
import '../domain/repository/exercise_repository.dart';

@LazySingleton(as: ExerciseRepository)
class ExerciseRepositoryImpl implements ExerciseRepository {
  ExerciseRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<ExerciseListPage> listExercises({
    String? q,
    String? type,
    bool mineOnly = false,
    int page = 1,
    int limit = 20,
  }) async {
    final res = await _dio.get(
      'api/exercises',
      queryParameters: <String, dynamic>{
        if (q != null && q.trim().isNotEmpty) 'q': q.trim(),
        if (type != null && type.isNotEmpty) 'type': type,
        if (mineOnly) 'mineOnly': true,
        'page': page,
        'limit': limit,
      },
    );
    return ExerciseListPage.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<ExerciseItem> getExercise(int id) async {
    final res = await _dio.get('api/exercises/$id');
    return ExerciseItem.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<ExerciseLogListPage> listLogs({
    String? from,
    String? to,
    int page = 1,
    int limit = 20,
  }) async {
    final res = await _dio.get(
      'api/exercise-logs',
      queryParameters: <String, dynamic>{
        if (from != null && from.isNotEmpty) 'from': from,
        if (to != null && to.isNotEmpty) 'to': to,
        'page': page,
        'limit': limit,
      },
    );
    return ExerciseLogListPage.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<ExerciseSummaryToday> getTodaySummary({String? date}) async {
    final dateKey = date ?? LogFoodHelper().dateKeyFrom(DateTime.now());
    final res = await _dio.get(
      'api/exercise-logs/summary/today',
      queryParameters: <String, dynamic>{'date': dateKey},
    );
    return ExerciseSummaryToday.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<Map<String, dynamic>> getSummaryRange(String from, String to) async {
    final res = await _dio.get(
      'api/exercise-logs/summary',
      queryParameters: {'from': from, 'to': to},
    );
    return res.data as Map<String, dynamic>;
  }

  @override
  Future<ExerciseLogCreated> createLog({
    required int exerciseId,
    DateTime? startedAt,
    required double minutesPerformed,
    String source = 'manual',
  }) async {
    final res = await _dio.post(
      'api/exercise-logs',
      data: {
        'exerciseId': exerciseId,
        'minutesPerformed': minutesPerformed,
        'source': source,
        if (startedAt != null) 'startedAt': startedAt.toUtc().toIso8601String(),
      },
    );
    return ExerciseLogCreated.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<void> deleteLog(int id) async {
    await _dio.delete('api/exercise-logs/$id');
  }

  @override
  Future<ExerciseItem> createExercise({
    required String name,
    required String type,
    double? met,
    double? defaultCalPerMin,
    String? notes,
  }) async {
    final res = await _dio.post(
      'api/exercises',
      data: <String, dynamic>{
        'name': name.trim(),
        'type': type,
        if (met != null) 'met': met,
        if (defaultCalPerMin != null) 'defaultCalPerMin': defaultCalPerMin,
        if (notes != null && notes.trim().isNotEmpty) 'notes': notes.trim(),
      },
    );
    return ExerciseItem.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<ExerciseItem> updateExercise(
    int id, {
    String? name,
    String? type,
    double? met,
    double? defaultCalPerMin,
    String? notes,
  }) async {
    final data = <String, dynamic>{};
    if (name != null) data['name'] = name.trim();
    if (type != null) data['type'] = type;
    if (met != null) data['met'] = met;
    if (defaultCalPerMin != null) data['defaultCalPerMin'] = defaultCalPerMin;
    if (notes != null) data['notes'] = notes.trim();
    final res = await _dio.patch('api/exercises/$id', data: data);
    return ExerciseItem.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<void> deleteExercise(int id) async {
    await _dio.delete('api/exercises/$id');
  }
}
