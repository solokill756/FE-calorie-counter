import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../../common/utils/getit_utils.dart';
import '../../../../logfood/domain/repository/logfood_repo.dart';
import '../../../data/helpers/nutrition_date_range.dart';
import '../../../domain/entities/nutrition_data_entity.dart';
import '../../../domain/repository/nutrition_repository.dart';

part 'nutrition_state.dart';
part 'nutrition_cubit.freezed.dart';
part 'nutrition_state_extensions.dart';

@singleton
class NutritionCubit extends Cubit<NutritionState> {
  final NutritionRepository _repository;

  NutritionCubit(this._repository)
    : super(NutritionState.initial(currentDate: DateTime.now()));

  Future<void> loadWeeklyData() async {
    await loadDataForPeriod(state.selectedPeriod);
  }

  Future<void> loadDataForPeriod(String period, {DateTime? selectedDate}) async {
    if (isClosed) return;

    final currentDate =
        NutritionDateRangeHelper.dateOnly(selectedDate ?? state.currentDate);
    final isNetMode = state.isNetMode;

    emit(
      NutritionState.loading(
        currentDate: currentDate,
        selectedPeriod: period,
        isNetMode: isNetMode,
      ),
    );

    try {
      final weeklyData = switch (period) {
        NutritionDateRangeHelper.monthView => await _repository.getMonthlyData(
            currentDate,
          ),
        NutritionDateRangeHelper.dayView => await _repository.getDailyData(
            currentDate,
          ),
        _ => await _repository.getWeeklyData(currentDate),
      };
      final dateRange = NutritionDateRangeHelper.forPeriod(
        currentDate,
        period,
      );
      final logFoodsResult = await getIt<LogFoodRepository>().getLogFoodsByDate(
        dateRange.start,
        dateRange.end,
        includeQuickAdd: true,
      );

      List<String> foodsHighestInCalories = [];
      List<String> foodsHighestInCarbohydrates = [];
      List<String> foodsHighestInFat = [];
      List<String> foodsHighestInProtein = [];

      await logFoodsResult.fold((logFoods) async {
        foodsHighestInCalories = await _repository.getFoodsHighestInCalories(
          logFoods,
        );
        foodsHighestInCarbohydrates = await _repository
            .getFoodsHighestInCarbohydrates(logFoods);
        foodsHighestInFat = await _repository.getFoodsHighestInFat(logFoods);
        foodsHighestInProtein = await _repository.getFoodsHighestInProtein(
          logFoods,
        );
      }, (_) async {});

      emit(
        NutritionState.loaded(
          weeklyData: weeklyData,
          currentDate: currentDate,
          selectedPeriod: period,
          isNetMode: isNetMode,
          fresh: true,
          foodsHighestInCalories: foodsHighestInCalories,
          foodsHighestInCarbohydrates: foodsHighestInCarbohydrates,
          foodsHighestInFat: foodsHighestInFat,
          foodsHighestInProtein: foodsHighestInProtein,
        ),
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        NutritionState.error(
          message: e.toString(),
          currentDate: currentDate,
          selectedPeriod: period,
          isNetMode: isNetMode,
        ),
      );
    }
  }

  void toggleCalorieMode() {
    final newIsNetMode = !state.isNetMode;
    _updateStateWithNewIsNetMode(newIsNetMode);
  }

  void setCalorieMode(bool isNetMode) {
    if (state.isNetMode == isNetMode) return;
    _updateStateWithNewIsNetMode(isNetMode);
  }

  void _updateStateWithNewIsNetMode(bool newIsNetMode) {
    state.maybeWhen(
      initial: (date, period, _) {
        emit(
          NutritionState.initial(
            currentDate: date,
            selectedPeriod: period,
            isNetMode: newIsNetMode,
          ),
        );
      },
      loading: (date, period, _) {
        emit(
          NutritionState.loading(
            currentDate: date,
            selectedPeriod: period,
            isNetMode: newIsNetMode,
          ),
        );
      },
      loaded: (weeklyData, date, period, _, fresh, a, b, c, d) {
        emit(
          NutritionState.loaded(
            weeklyData: weeklyData,
            currentDate: date,
            selectedPeriod: period,
            isNetMode: newIsNetMode,
            fresh: fresh,
            foodsHighestInCalories: a,
            foodsHighestInCarbohydrates: b,
            foodsHighestInFat: c,
            foodsHighestInProtein: d,
          ),
        );
      },
      error: (message, date, period, _, weeklyData) {
        emit(
          NutritionState.error(
            message: message,
            currentDate: date,
            selectedPeriod: period,
            isNetMode: newIsNetMode,
            weeklyData: weeklyData,
          ),
        );
      },
      orElse: () {},
    );
  }

  void changePeriod(String period, {DateTime? selectedDate}) {
    loadDataForPeriod(period, selectedDate: selectedDate ?? state.currentDate);
  }

  void navigatePrevious() {
    final period = state.selectedPeriod;
    final newDate = NutritionDateRangeHelper.previous(state.currentDate, period);
    loadDataForPeriod(period, selectedDate: newDate);
  }

  void navigateNext() {
    final period = state.selectedPeriod;
    final newDate = NutritionDateRangeHelper.next(state.currentDate, period);
    loadDataForPeriod(period, selectedDate: newDate);
  }
}
