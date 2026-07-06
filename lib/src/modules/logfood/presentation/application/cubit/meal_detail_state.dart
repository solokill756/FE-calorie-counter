import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:caloriecounter/src/core/data/remote/base/api_error.dart';
import 'package:caloriecounter/src/modules/logfood/data/models/meal_detail_model.dart';

part 'meal_detail_state.freezed.dart';

@freezed
class MealDetailState with _$MealDetailState {
  const factory MealDetailState.initial() = MealDetailInitial;
  const factory MealDetailState.loading() = MealDetailLoading;
  const factory MealDetailState.loaded(MealDetail meal) = MealDetailLoaded;
  const factory MealDetailState.error(ApiError error) = MealDetailError;
}
