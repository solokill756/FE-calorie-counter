import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/ingredient_recognition_model.dart';

part 'ingredient_vision_state.freezed.dart';

@freezed
class IngredientVisionState with _$IngredientVisionState {
  const factory IngredientVisionState.initial() = _IngredientVisionInitial;

  const factory IngredientVisionState.loading() = _IngredientVisionLoading;

  const factory IngredientVisionState.success({
    required List<DetectedIngredientModel> ingredients,
    String? imageUrl,
  }) = _IngredientVisionSuccess;

  const factory IngredientVisionState.failure(String message) = _IngredientVisionFailure;
}
