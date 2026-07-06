import 'package:result_dart/result_dart.dart';

import '../../../../core/data/remote/base/api_error.dart';
import '../../../../core/data/remote/base/api_response.dart';
import '../entities/entity.dart';

abstract class ProgressRepository {
  Future<Result<ProgressStats, ApiError>> fetchProcessData({
    required int page,
    required int pageSize,
    required String type,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<Result<void, ApiError>> addProgressEntry(
    Map<String, dynamic> data,
    String type,
  );
  Future<Result<StatusApiResponse, ApiError>> updateProgressEntry(
    Map<String, dynamic> data,
    String type,
  );
  Future<Result<void, ApiError>> deleteProgressEntry(String id);
}
