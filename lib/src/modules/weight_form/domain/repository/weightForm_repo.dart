import 'package:caloriecounter/src/core/data/remote/base/api_error.dart';
import 'package:result_dart/result_dart.dart';

import '../../data/model/weightForm_model.dart';

abstract class WeightFormRepository {
  Future<Result<WeightFormModel, ApiError>> saveWeightEntry(
    WeightFormModel weightFormModel,
  );

  Future<Result<String, ApiError>> updateWeightEntry({
    required String entryId,
    required WeightFormModel weightModel,
  });
  Future<Result<WeightFormModel, ApiError>> getWeightEntry({
    required String entryId,
  });
}
