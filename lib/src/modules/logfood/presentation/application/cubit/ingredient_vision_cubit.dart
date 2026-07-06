import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/ingredient_recognition_model.dart';
import '../../../domain/repository/food_repository.dart';
import 'ingredient_vision_state.dart';

@injectable
class IngredientVisionCubit extends Cubit<IngredientVisionState> {
  final FoodRepository _foodRepository;

  IngredientVisionCubit(this._foodRepository) : super(const IngredientVisionState.initial());

  void _emit(IngredientVisionState next) {
    if (!isClosed) emit(next);
  }

  Future<void> recognize(String imageUrl, {int topK = 5}) async {
    _emit(const IngredientVisionState.loading());
    final result = await _foodRepository.recognizeIngredientsFromImage(imageUrl, topK: topK);
    if (isClosed) return;
    result.fold(
      (data) => _emit(IngredientVisionState.success(
        ingredients: data.ingredients,
        imageUrl: data.imageUrl,
      )),
      (error) => _emit(IngredientVisionState.failure(
        error.message.isNotEmpty ? error.message : 'Ingredient recognition failed.',
      )),
    );
  }

  Future<void> matchAgain(String ingredientId, String name) async {
    _emit(const IngredientVisionState.loading());
    final result = await _foodRepository.matchIngredientNames([
      MatchIngredientRequest(clientIngredientId: ingredientId, name: name),
    ], topK: 5);
    if (isClosed) return;
    result.fold(
      (data) {
        if (data.ingredients.isEmpty) {
          _emit(const IngredientVisionState.failure('No matching foods found.'));
          return;
        }
        final currentState = state;
        currentState.maybeWhen(
          success: (currentIngredients, imageUrl) {
            final updated = currentIngredients.map((item) {
              if (item.clientIngredientId != ingredientId) return item;
              return data.ingredients.first;
            }).toList();
            _emit(IngredientVisionState.success(
              ingredients: updated,
              imageUrl: imageUrl,
            ));
          },
          orElse: () {},
        );
      },
      (error) => _emit(IngredientVisionState.failure(
        error.message.isNotEmpty ? error.message : 'Food matching failed.',
      )),
    );
  }

  void replaceAll(List<DetectedIngredientModel> ingredients) {
    _emit(IngredientVisionState.success(
      ingredients: ingredients,
      imageUrl: state.maybeWhen(
        success: (_, imageUrl) => imageUrl,
        orElse: () => null,
      ),
    ));
  }

  void removeIngredient(String ingredientId) {
    state.maybeWhen(
      success: (ingredients, imageUrl) {
        _emit(IngredientVisionState.success(
          ingredients: ingredients
              .where((item) => item.clientIngredientId != ingredientId)
              .toList(),
          imageUrl: imageUrl,
        ));
      },
      orElse: () {},
    );
  }
}
