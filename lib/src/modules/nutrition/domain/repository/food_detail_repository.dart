import '../entities/food_item_entity.dart';
import '../../../../core/data/remote/base/api_error.dart';
import 'package:result_dart/result_dart.dart';

abstract class FoodDetailRepository {
  Future<Result<List<FoodItemEntity>, ApiError>> getFoodsByNutrient({
    required DateTime startDate,
    required DateTime endDate,
    required String type,
  });
}
