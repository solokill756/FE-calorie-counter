import 'package:caloriecounter/src/modules/logfood/data/models/food_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'log_food_model.freezed.dart';
part 'log_food_model.g.dart';

@freezed
class LogFoodModel with _$LogFoodModel {
  const factory LogFoodModel({
    String? brandName,
    int? id,
    required String nameFood,
    required Map<String, dynamic> nutrients,
    required Map<String, dynamic> serving,
    required String slot,
    required String source,
    required DateTime time,
    required int foodId,
    required FoodModel food,
  }) = _LogFoodModel;

  const LogFoodModel._();

  factory LogFoodModel.fromJson(Map<String, dynamic> json) =>
      _$LogFoodModelFromJson(json);
}
