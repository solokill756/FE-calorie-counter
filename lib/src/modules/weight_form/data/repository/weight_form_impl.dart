import 'package:caloriecounter/src/core/data/remote/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/data/remote/base/api_error.dart';
import '../../domain/repository/weightForm_repo.dart';
import '../model/weightForm_model.dart';

@Injectable(as: WeightFormRepository)
class WeightFormRepositoryImpl implements WeightFormRepository {
  final Dio _dio;
  WeightFormRepositoryImpl(this._dio);

  Map<String, dynamic> _toApiPayload(WeightFormModel model) {
    final payload = <String, dynamic>{
      'weightKg': model.weightKg,
      'recordedAt': const DateTimeIso8601Converter().toJson(model.recordedAt),
    };
    final photoUrl = model.photoUrl?.trim();
    if (photoUrl != null && photoUrl.isNotEmpty) {
      payload['photoUrl'] = photoUrl;
    }
    return payload;
  }

  @override
  Future<Result<WeightFormModel, ApiError>> saveWeightEntry(
    WeightFormModel weightFormModel,
  ) async {
    return _dio
        .post('api/Weight', data: _toApiPayload(weightFormModel))
        .tryGet((response) {
      final WeightFormModel savedEntry = WeightFormModel.fromJson(
        response.data,
      );
      return savedEntry;
    });
  }

  @override
  Future<Result<String, ApiError>> updateWeightEntry({
    required String entryId,
    required WeightFormModel weightModel,
  }) async {
    return _dio
        .put('api/Weight/$entryId', data: _toApiPayload(weightModel))
        .tryGet((response) {
      final String statusMessage = 'Weight entry updated successfully';
      return statusMessage;
    });
  }

  @override
  Future<Result<WeightFormModel, ApiError>> getWeightEntry({
    required String entryId,
  }) {
    return _dio.get('api/Weight/$entryId').tryGet((response) {
      final WeightFormModel entry = WeightFormModel.fromJson(response.data);
      return entry;
    });
  }
}
