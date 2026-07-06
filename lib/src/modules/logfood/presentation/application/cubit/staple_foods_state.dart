import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:caloriecounter/src/modules/logfood/data/models/food_model.dart';

part 'staple_foods_state.freezed.dart';

@freezed
class StapleFoodsState with _$StapleFoodsState {
  const factory StapleFoodsState.initial() = _StapleFoodsInitial;

  const factory StapleFoodsState.loading() = _StapleFoodsLoading;

  const factory StapleFoodsState.success({
    required List<FoodModel> staples,
  }) = _StapleFoodsSuccess;

  const factory StapleFoodsState.failure(String message) = _StapleFoodsFailure;
}
