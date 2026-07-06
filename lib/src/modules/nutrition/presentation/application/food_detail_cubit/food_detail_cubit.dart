import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../data/helpers/nutrition_date_range.dart';
import '../../../domain/entities/food_item_entity.dart';
import '../../../domain/repository/food_detail_repository.dart';

part 'food_detail_state.dart';
part 'food_detail_cubit.freezed.dart';
part 'food_detail_state_extensions.dart';

@singleton
class FoodDetailCubit extends Cubit<FoodDetailState> {
  final FoodDetailRepository _repository;
  String? _type;

  FoodDetailCubit(this._repository)
    : super(FoodDetailState.initial(currentDate: DateTime.now()));

  void setType(String type) {
    if (_type != type) {
      _type = type;
      loadFoods();
    }
  }

  Future<void> loadFoods() async {
    if (isClosed) return;

    final currentDate = state.currentDate;
    final selectedPeriod = state.selectedPeriod;

    emit(
      FoodDetailState.loading(
        currentDate: currentDate,
        selectedPeriod: selectedPeriod,
      ),
    );

    try {
      final dateRange = _DateRangeCalculator.calculate(
        currentDate,
        selectedPeriod,
      );

      if (_type == null) return;

      final result = await _repository.getFoodsByNutrient(
        startDate: dateRange.start,
        endDate: dateRange.end,
        type: _type!,
      );

      result.fold(
        (foods) {
          if (isClosed) return;
          emit(
            FoodDetailState.loaded(
              foods: foods,
              currentDate: currentDate,
              selectedPeriod: selectedPeriod,
            ),
          );
        },
        (error) {
          if (isClosed) return;
          emit(
            FoodDetailState.error(
              message: error.message,
              currentDate: currentDate,
              selectedPeriod: selectedPeriod,
            ),
          );
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        FoodDetailState.error(
          message: e.toString(),
          currentDate: currentDate,
          selectedPeriod: selectedPeriod,
        ),
      );
    }
  }

  void changePeriod(String period, {DateTime? selectedDate}) {
    final currentDate = NutritionDateRangeHelper.dateOnly(
      selectedDate ?? state.currentDate,
    );
    emit(
      FoodDetailState.loading(currentDate: currentDate, selectedPeriod: period),
    );
    loadFoods();
  }

  void navigatePrevious() {
    final period = state.selectedPeriod;
    final newDate = NutritionDateRangeHelper.previous(state.currentDate, period);

    emit(FoodDetailState.loading(currentDate: newDate, selectedPeriod: period));
    loadFoods();
  }

  void navigateNext() {
    final period = state.selectedPeriod;
    final newDate = NutritionDateRangeHelper.next(state.currentDate, period);

    emit(FoodDetailState.loading(currentDate: newDate, selectedPeriod: period));
    loadFoods();
  }
}

class _DateRangeCalculator {
  static _DateRange calculate(DateTime currentDate, String period) {
    final range = NutritionDateRangeHelper.forPeriod(currentDate, period);

    return _DateRange(
      start: range.start,
      end: range.end,
    );
  }
}

class _DateRange {
  final DateTime start;
  final DateTime end;

  const _DateRange({required this.start, required this.end});
}
