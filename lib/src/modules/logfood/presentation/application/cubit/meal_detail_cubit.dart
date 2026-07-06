import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caloriecounter/src/modules/logfood/domain/repository/food_repository.dart';
import 'meal_detail_state.dart';

class MealDetailCubit extends Cubit<MealDetailState> {
  final FoodRepository foodRepository;
  final int mealId;

  MealDetailCubit({
    required this.foodRepository,
    required this.mealId,
  }) : super(const MealDetailState.initial());

  Future<void> loadMealDetail() async {
    emit(const MealDetailState.loading());
    final result = await foodRepository.getMealDetail(mealId);
    result.fold(
      (meal) => emit(MealDetailState.loaded(meal)),
      (error) => emit(MealDetailState.error(error)),
    );
  }
}
