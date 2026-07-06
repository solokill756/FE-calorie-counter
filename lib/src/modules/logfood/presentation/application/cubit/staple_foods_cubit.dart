import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:caloriecounter/src/modules/logfood/data/models/food_model.dart';
import 'package:caloriecounter/src/modules/logfood/domain/repository/food_repository.dart';
import 'staple_foods_state.dart';

@injectable
class StapleFoodsCubit extends Cubit<StapleFoodsState> {
  final FoodRepository _foodRepository;

  StapleFoodsCubit(this._foodRepository) : super(const StapleFoodsState.initial());

  Future<void> load() async {
    emit(const StapleFoodsState.loading());
    final result = await _foodRepository.getMyStapleFoods();
    result.fold(
      (list) => emit(StapleFoodsState.success(staples: list)),
      (error) => emit(StapleFoodsState.failure(
        error.message.isNotEmpty ? error.message : 'Could not load pantry',
      )),
    );
  }

  Future<void> add(int foodId) async {
    final result = await _foodRepository.addStapleFood(foodId);
    result.fold(
      (_) => load(),
      (error) => emit(StapleFoodsState.failure(
        error.message.isNotEmpty ? error.message : 'Add failed',
      )),
    );
  }

  Future<void> remove(int foodId) async {
    final result = await _foodRepository.removeStapleFood(foodId);
    result.fold(
      (_) => load(),
      (error) => emit(StapleFoodsState.failure(
        error.message.isNotEmpty ? error.message : 'Remove failed',
      )),
    );
  }
}
