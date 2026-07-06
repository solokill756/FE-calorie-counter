import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_nutritional_threshold_model.freezed.dart';
part 'user_nutritional_threshold_model.g.dart';

/// Active row from BE `UserNutritionalThreshold` / `auth/me` `nutritionalThresholds`.
@freezed
class UserNutritionalThreshold with _$UserNutritionalThreshold {
  const factory UserNutritionalThreshold({
    required String nutrient,
    double? minAmount,
    double? maxAmount,
    @Default('g') String unit,
  }) = _UserNutritionalThreshold;

  factory UserNutritionalThreshold.fromJson(Map<String, dynamic> json) =>
      _$UserNutritionalThresholdFromJson(json);
}
