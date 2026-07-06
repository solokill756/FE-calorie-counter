import 'package:caloriecounter/src/core/data/remote/base/api_response.dart';
import 'package:caloriecounter/src/modules/progress/domain/entities/progress_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../common/utils/formats.dart';
import '../../../../core/data/remote/base/api_error.dart';
import '../../domain/repository/progress_repo.dart';

@Injectable(as: ProgressRepository)
class ProcessRepositoryImpl implements ProgressRepository {
  final Dio _dio;
  ProcessRepositoryImpl(this._dio);

  @override
  Future<Result<ProgressStats, ApiError>> fetchProcessData({
    required int page,
    required int pageSize,
    required String type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      String apiEndpoint;

      switch (type.toLowerCase()) {
        case 'weights':
          apiEndpoint = '/api/Weight';
          break;
        case 'steps':
          apiEndpoint = '/api/Step';
          break;
        case 'calories':
          apiEndpoint = '/api/Calorie';
          break;
        case 'necks':
          apiEndpoint = '/api/Neck';
          break;
        case 'waists':
          apiEndpoint = '/api/Waist';
          break;
        case 'hips':
          apiEndpoint = '/api/Hip';
          break;
        default:
          apiEndpoint = '/api/Progress';
      }

      final queryParameters = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
      };

      // Add startDate and endDate to query parameters if provided
      if (startDate != null) {
        queryParameters['startDate'] = startDate.toUtc().toIso8601String(); // ISO8601 with UTC (Z)
      }
      if (endDate != null) {
        queryParameters['endDate'] = endDate.toUtc().toIso8601String(); // ISO8601 with UTC (Z)
      }

      final response = await _dio.get(
        apiEndpoint,
        queryParameters: queryParameters,
      );

      final progressStats = ProgressStats.convertToProgressStats(
        response.data,
        type,
        response.data['total'] ?? 0,
      );
      return Success(progressStats);
    } on DioException catch (e) {
      final apiError = ApiError(
        e.response?.statusCode,
        e.message ?? 'Unknown error occurred',
      );
      return Failure(apiError);
    } catch (e) {
      return Failure(ApiError(null, 'Error: ${e.toString()}'));
    }
  }

  @override
  Future<Result<String, ApiError>> addProgressEntry(
    Map<String, dynamic> data,
    String type,
  ) async {
    try {
      final formattedDate = Formats.formatDateTimeToISO8601(data['recordedAt']);

      switch (type.toLowerCase()) {
        case 'necks':
          final neckModel = {
            'recordedAt': formattedDate,
            'neckCm': data['value'],
          };
          await _dio.post('/api/Neck', data: neckModel);
          return Success('Added successfully');

        case 'waists':
          final waistModel = {
            'recordedAt': formattedDate,
            'waistCm': data['value'],
          };
          await _dio.post('/api/Waist', data: waistModel);
          return Success('Added successfully');

        case 'hips':
          final hipModel = {
            'recordedAt': formattedDate,
            'hipsCm': data['value'],
          };
          await _dio.post('/api/Hip', data: hipModel);
          return Success('Added successfully');

        default:
          return Success('Added successfully');
      }
    } catch (e) {
      debugPrint('$e');
      return Failure(ApiError(null, 'Adding failed'));
    }
  }

  @override
  Future<Result<void, ApiError>> deleteProgressEntry(String id) async {
    try {
      await _dio.delete('/api/Progress/entries/$id');
      return Success.unit();
    } catch (e) {
      return Failure(ApiError(null, 'Deleting failed'));
    }
  }

  @override
  Future<Result<StatusApiResponse, ApiError>> updateProgressEntry(
    Map<String, dynamic> data,
    String type,
  ) async {
    try {
      final formattedDate = Formats.formatDateTimeToISO8601(data['recordedAt']);
      final entryId = data['id'] as String?;

      if (entryId == null) {
        return Failure(ApiError(null, 'Entry ID is required for update'));
      }

      // Since server only allows DELETE and GET for these endpoints,
      // we need to delete the old entry and create a new one
      switch (type.toLowerCase()) {
        case 'necks':
          // Delete old entry
          await _dio.delete('/api/Neck/$entryId');
          // Create new entry with updated data
          final neckModel = {
            'recordedAt': formattedDate,
            'neckCm': data['value'],
          };
          await _dio.post('/api/Neck', data: neckModel);
          break;

        case 'waists':
          // Delete old entry
          await _dio.delete('/api/Waist/$entryId');
          // Create new entry with updated data
          final waistModel = {
            'recordedAt': formattedDate,
            'waistCm': data['value'],
          };
          await _dio.post('/api/Waist', data: waistModel);
          break;

        case 'hips':
          // Delete old entry
          await _dio.delete('/api/Hip/$entryId');
          // Create new entry with updated data
          final hipModel = {
            'recordedAt': formattedDate,
            'hipCm': data['value'],
          };
          await _dio.post('/api/Hip', data: hipModel);
          break;

        default:
          return Failure(ApiError(null, 'Update not supported for this type'));
      }
      return Success(
        StatusApiResponse(message: 'Updated successfully', statusCode: 200),
      );
    } catch (e) {
      return Failure(ApiError(null, 'Updating failed: ${e.toString()}'));
    }
  }
}
