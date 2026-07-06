import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../data/helpers/nutrition_date_range.dart';
import '../../../domain/repository/nutrient_detail_repository.dart';
import '../../../domain/entities/nutrition_data_entity.dart';

part 'nutrient_detail_state.dart';
part 'nutrient_detail_cubit.freezed.dart';
part 'nutrient_detail_state_extensions.dart';

@singleton
class NutrientDetailCubit extends Cubit<NutrientDetailState> {
  final NutrientDetailRepository _repository;
  String? _nutrientType;

  NutrientDetailCubit(this._repository)
    : super(NutrientDetailState.initial(currentDate: DateTime.now()));

  void setInitialDate(DateTime date) {
    final selectedPeriod = state.selectedPeriod;
    final nutrientName = state.nutrientName;
    // Giữ nguyên state type hiện tại, chỉ update date
    emit(
      state.maybeWhen(
        initial: (_, period, name) => NutrientDetailState.initial(
          currentDate: date,
          selectedPeriod: period,
          nutrientName: name,
        ),
        loading: (_, period, name) => NutrientDetailState.loading(
          currentDate: date,
          selectedPeriod: period,
          nutrientName: name,
        ),
        loaded: (weeklyData, foods, _, period, name) =>
            NutrientDetailState.loaded(
              weeklyData: weeklyData,
              foodsHighestInNutrient: foods,
              currentDate: date,
              selectedPeriod: period,
              nutrientName: name,
            ),
        error: (message, _, period, name) => NutrientDetailState.error(
          message: message,
          currentDate: date,
          selectedPeriod: period,
          nutrientName: name,
        ),
        orElse: () => NutrientDetailState.initial(
          currentDate: date,
          selectedPeriod: selectedPeriod,
          nutrientName: nutrientName,
        ),
      ),
    );
  }

  void setInitialPeriod(String period) {
    final currentDate = state.currentDate;
    final nutrientName = state.nutrientName;
    // Giữ nguyên state type hiện tại, chỉ update period
    emit(
      state.maybeWhen(
        initial: (date, _, name) => NutrientDetailState.initial(
          currentDate: date,
          selectedPeriod: period,
          nutrientName: name,
        ),
        loading: (date, _, name) => NutrientDetailState.loading(
          currentDate: date,
          selectedPeriod: period,
          nutrientName: name,
        ),
        loaded: (weeklyData, foods, date, _, name) =>
            NutrientDetailState.loaded(
              weeklyData: weeklyData,
              foodsHighestInNutrient: foods,
              currentDate: date,
              selectedPeriod: period,
              nutrientName: name,
            ),
        error: (message, date, _, name) => NutrientDetailState.error(
          message: message,
          currentDate: date,
          selectedPeriod: period,
          nutrientName: name,
        ),
        orElse: () => NutrientDetailState.initial(
          currentDate: currentDate,
          selectedPeriod: period,
          nutrientName: nutrientName,
        ),
      ),
    );
  }

  void setNutrientType(String nutrientType) {
    _nutrientType = nutrientType;
    final currentDate = state.currentDate;
    final selectedPeriod = state.selectedPeriod;

    // Emit state với nutrientName
    emit(
      state.maybeWhen(
        initial: (date, period, _) => NutrientDetailState.initial(
          currentDate: date,
          selectedPeriod: period,
          nutrientName: nutrientType,
        ),
        loading: (date, period, _) => NutrientDetailState.loading(
          currentDate: date,
          selectedPeriod: period,
          nutrientName: nutrientType,
        ),
        loaded: (_, __, date, period, _) => NutrientDetailState.loading(
          currentDate: date,
          selectedPeriod: period,
          nutrientName: nutrientType,
        ),
        error: (_, date, period, _) => NutrientDetailState.loading(
          currentDate: date,
          selectedPeriod: period,
          nutrientName: nutrientType,
        ),
        orElse: () => NutrientDetailState.loading(
          currentDate: currentDate,
          selectedPeriod: selectedPeriod,
          nutrientName: nutrientType,
        ),
      ),
    );

    loadNutrientData();
  }

  Future<void> loadNutrientData({bool skipEmitLoading = false}) async {
    if (isClosed || _nutrientType == null) return;

    final currentDate = state.currentDate;
    final selectedPeriod = state.selectedPeriod;
    final nutrientName = state.nutrientName;

    // Chỉ emit loading nếu chưa được emit (khi gọi từ navigateNext/Previous thì đã emit rồi)
    if (!skipEmitLoading) {
      emit(
        NutrientDetailState.loading(
          currentDate: currentDate,
          selectedPeriod: selectedPeriod,
          nutrientName: nutrientName,
        ),
      );
    }

    try {
      final dateRange = _DateRangeCalculator.calculate(
        currentDate,
        selectedPeriod,
      );

      final nutrientDataResult = await _repository.getNutrientData(
        startDate: dateRange.start,
        endDate: dateRange.end,
      );

      final foodsResult = await _repository.getFoodsHighestInNutrient(
        startDate: dateRange.start,
        endDate: dateRange.end,
        nutrientType: _nutrientType!,
      );

      nutrientDataResult.fold(
        (weeklyData) {
          foodsResult.fold(
            (foods) {
              if (isClosed) return;
              emit(
                NutrientDetailState.loaded(
                  weeklyData: weeklyData,
                  foodsHighestInNutrient: foods,
                  currentDate: currentDate,
                  selectedPeriod: selectedPeriod,
                  nutrientName: nutrientName,
                ),
              );
            },
            (error) {
              if (isClosed) return;
              emit(
                NutrientDetailState.error(
                  message: error.message,
                  currentDate: currentDate,
                  selectedPeriod: selectedPeriod,
                  nutrientName: nutrientName,
                ),
              );
            },
          );
        },
        (error) {
          if (isClosed) return;
          emit(
            NutrientDetailState.error(
              message: error.message,
              currentDate: currentDate,
              selectedPeriod: selectedPeriod,
              nutrientName: nutrientName,
            ),
          );
        },
      );
    } catch (e) {
      if (isClosed) return;
      emit(
        NutrientDetailState.error(
          message: e.toString(),
          currentDate: currentDate,
          selectedPeriod: selectedPeriod,
          nutrientName: nutrientName,
        ),
      );
    }
  }

  void changePeriod(String period, {DateTime? selectedDate}) {
    final currentDate = NutritionDateRangeHelper.dateOnly(
      selectedDate ?? state.currentDate,
    );
    final nutrientName = state.nutrientName;
    emit(
      NutrientDetailState.loading(
        currentDate: currentDate,
        selectedPeriod: period,
        nutrientName: nutrientName,
      ),
    );
    loadNutrientData(skipEmitLoading: true);
  }

  void navigatePrevious() {
    final period = state.selectedPeriod;
    final nutrientName = state.nutrientName;
    final newDate = NutritionDateRangeHelper.previous(state.currentDate, period);

    emit(
      NutrientDetailState.loading(
        currentDate: newDate,
        selectedPeriod: period,
        nutrientName: nutrientName,
      ),
    );
    loadNutrientData(skipEmitLoading: true);
  }

  void navigateNext() {
    final period = state.selectedPeriod;
    final nutrientName = state.nutrientName;
    final newDate = NutritionDateRangeHelper.next(state.currentDate, period);

    emit(
      NutrientDetailState.loading(
        currentDate: newDate,
        selectedPeriod: period,
        nutrientName: nutrientName,
      ),
    );
    loadNutrientData(skipEmitLoading: true);
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
