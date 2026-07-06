import '../../../../core/data/remote/base/api_error.dart';
import '../entities/nutrition_data_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract class NutrientDetailRepository {
  Future<Result<WeeklyNutritionData, ApiError>> getNutrientData({
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<Result<List<String>, ApiError>> getFoodsHighestInNutrient({
    required DateTime startDate,
    required DateTime endDate,
    required String nutrientType,
  });
}
