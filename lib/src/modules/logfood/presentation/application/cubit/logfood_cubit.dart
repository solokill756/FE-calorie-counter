import 'dart:async';

import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:caloriecounter/src/core/data/local/storage.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/application/dashboard_cubit.dart';
import 'package:caloriecounter/src/modules/diary/presentation/application/diary_cubit/diary_cubit.dart';
import 'package:caloriecounter/src/modules/nutrition/presentation/application/nutrition_cubit/nutrition_cubit.dart';
import 'package:caloriecounter/src/modules/progress/presentation/application/progress_trends_cubit/progress_trends_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/models/food_model.dart';
import '../../../domain/repository/logfood_repo.dart';

part 'logfood_state.dart';
part 'logfood_cubit.freezed.dart';

@singleton
class LogFoodCubit extends Cubit<LogFoodState> {
  final LogFoodRepository logFoodRepository;

  LogFoodCubit({required this.logFoodRepository})
    : super(const LogFoodState.initial());

  Future<void> addLogFood({
    required FoodModel food,
    required String slot,
    required double qty,
    required int unitSelectedIndex,
    DateTime? time,
    bool skipRecentUpdate = false,
    String? selectedTab,
    int logFoodPage = 0,
  }) async {
    try {
      logFoodPage == 0
          ? emit(const LogFoodState.logFoodLoading())
          : emit(const LogFoodState.logFoodDetailLoading());
      final result = await logFoodRepository.logFood(
        food: food,
        slot: slot,
        qty: qty,
        time: time,
        unitSelectedIndex: unitSelectedIndex,
        skipRecentUpdate: skipRecentUpdate,
      );

      if (result.isSuccess()) {
        final ratingPromptLogCount = await _recordSuccessfulLog();
        await _refreshFoodDependentData([time ?? DateTime.now()]);
        logFoodPage == 0
            ? emit(
                LogFoodState.logFoodSuccess(
                  'Food logged successfully',
                  ratingPromptLogCount,
                ),
              )
            : emit(
                LogFoodState.logFoodDetailSuccess(
                  'Food logged successfully',
                  ratingPromptLogCount,
                ),
              );
      } else {
        logFoodPage == 0
            ? emit(
                const LogFoodState.logFoodError(
                  'Failed to add food to history',
                ),
              )
            : emit(
                const LogFoodState.logFoodDetailError(
                  'Failed to add food to history',
                ),
              );
      }
    } catch (e) {
      logFoodPage == 0
          ? emit(LogFoodState.logFoodError('Failed to add food to history: $e'))
          : emit(
              LogFoodState.logFoodDetailError(
                'Failed to add food to history: $e',
              ),
            );
    }
  }

  /// Quick-add a saved meal (My Meals) to the diary using server quick-add + MealId.
  Future<void> addLogSavedMealTemplate({
    required FoodModel meal,
    required String slot,
    DateTime? time,
    String? selectedTab,
  }) async {
    try {
      emit(const LogFoodState.logFoodLoading());
      final result = await logFoodRepository.logSavedMealTemplate(
        meal: meal,
        slot: slot,
        time: time,
      );

      if (result.isSuccess()) {
        final ratingPromptLogCount = await _recordSuccessfulLog();
        await _refreshFoodDependentData([time ?? DateTime.now()]);
        emit(
          LogFoodState.logFoodSuccess(
            'Meal logged successfully',
            ratingPromptLogCount,
          ),
        );
      } else {
        emit(
          const LogFoodState.logFoodError(
            'Failed to log meal',
          ),
        );
      }
    } catch (e) {
      emit(LogFoodState.logFoodError('Failed to log meal: $e'));
    }
  }

  Future<void> logFoodToSelectedDays({
    required FoodModel food,
    required String slot,
    required double qty,
    required List<DateTime> dates,
    required int unitSelectedIndex,
    bool skipRecentUpdate = false,
  }) async {
    try {
      emit(LogFoodState.logFoodDetailLoading());
      final result = await logFoodRepository.logFoodToMultipleDays(
        food: food,
        slot: slot,
        qty: qty,
        dates: dates,
        unitSelectedIndex: unitSelectedIndex,
        skipRecentUpdate: skipRecentUpdate,
      );
      if (result.isSuccess()) {
        final ratingPromptLogCount = await _recordSuccessfulLog();
        await _refreshFoodDependentData(dates);
        emit(
          LogFoodState.logFoodDetailSuccess(
            'Food logged to selected days successfully',
            ratingPromptLogCount,
          ),
        );
      } else {
        emit(
          const LogFoodState.logFoodDetailError(
            'Failed to log food to selected days. Please try again later.',
          ),
        );
      }
    } catch (e) {
      emit(
        LogFoodState.logFoodDetailError(
          'Failed to log food to selected days: $e',
        ),
      );
    }
  }

  Future<void> logMultipleFoods({
    required List<FoodModel> foodEntries,
    required int unitSelectedIndex,
    required double qty,
    DateTime? time,
    bool skipRecentUpdate = false,
    required String slot,
  }) async {
    try {
      emit(const LogFoodState.logFoodDetailLoading());
      final result = await logFoodRepository.logMultipleFoods(
        foods: foodEntries,
        time: time,
        skipRecentUpdate: skipRecentUpdate,
        unitSelectedIndex: unitSelectedIndex,
        qty: qty,
        slot: slot,
      );
      if (result.isSuccess()) {
        final ratingPromptLogCount = await _recordSuccessfulLog();
        await _refreshFoodDependentData([time ?? DateTime.now()]);
        emit(
          LogFoodState.logFoodSuccess(
            'Multiple foods logged successfully',
            ratingPromptLogCount,
          ),
        );
      } else {
        emit(
          const LogFoodState.logFoodDetailError(
            'Failed to log multiple foods. Please try again later.',
          ),
        );
      }
    } catch (e) {
      emit(LogFoodState.logFoodError('Failed to log multiple foods: $e'));
    }
  }

  Future<void> logMultipleFoodsToSelectedDays({
    required List<FoodModel> foodEntries,
    required List<DateTime> dates,
    required int unitSelectedIndex,
    required double qty,
    bool skipRecentUpdate = false,
    required String slot,
  }) async {
    try {
      emit(LogFoodState.logFoodDetailLoading());
      final result = await logFoodRepository.logMultipleFoodsToMultipleDays(
        foods: foodEntries,
        dates: dates,
        skipRecentUpdate: skipRecentUpdate,
        unitSelectedIndex: unitSelectedIndex,
        qty: qty,
        slot: slot,
      );
      if (result.isSuccess()) {
        final ratingPromptLogCount = await _recordSuccessfulLog();
        await _refreshFoodDependentData(dates);
        emit(
          LogFoodState.logFoodDetailSuccess(
            'Multiple foods logged to multiple days successfully',
            ratingPromptLogCount,
          ),
        );
      } else {
        emit(
          const LogFoodState.logFoodDetailError(
            'Failed to log multiple foods to multiple days. Please try again later.',
          ),
        );
      }
    } catch (e) {
      emit(
        LogFoodState.logFoodDetailError(
          'Failed to log multiple foods to multiple days: $e',
        ),
      );
    }
  }

  Future<void> quickAddLogFood({
    required double calories,
    required String slot,
    double? fat,
    double? carbs,
    double? protein,
    DateTime? time,
  }) async {
    try {
      emit(LogFoodState.quickAddLoading());
      final result = await logFoodRepository.quickAddLogFood(
        calories: calories,
        slot: slot,
        time: time,
        fat: fat,
        carbs: carbs,
        protein: protein,
      );
      if (result.isSuccess()) {
        final statusApiResponse = result.getOrNull()!;
        final ratingPromptLogCount = await _recordSuccessfulLog();
        await _refreshFoodDependentData([time ?? DateTime.now()]);
        emit(
          LogFoodState.quickAddSuccess(
            statusApiResponse.message,
            ratingPromptLogCount,
          ),
        );
      } else {
        debugPrint(result.exceptionOrNull()?.message);
        emit(const LogFoodState.quickAddError('Failed to quick add food'));
      }
    } catch (e) {
      debugPrint('Failed to quick add food: ${e.toString()}');
      emit(LogFoodState.quickAddError('Failed to quick add food'));
    }
  }

  Future<void> _refreshFoodDependentData(List<DateTime> dates) async {
    final affectedDays = dates.map(_dateOnly).toSet();
    if (affectedDays.isEmpty) return;

    try {
      final diaryCubit = getIt<DiaryCubit>();
      final selectedDiaryDay = _diarySelectedDate(diaryCubit);
      if (selectedDiaryDay != null && affectedDays.contains(selectedDiaryDay)) {
        await diaryCubit.loadDiaryForDate(selectedDiaryDay, null);
      }
    } catch (e) {
      debugPrint('LogFoodCubit: diary refresh skipped: $e');
    }

    try {
      if (affectedDays.contains(_dateOnly(DateTime.now()))) {
        await getIt<DashboardCubit>().refreshDashboard();
      }
    } catch (e) {
      debugPrint('LogFoodCubit: dashboard refresh skipped: $e');
    }

    try {
      await getIt<NutritionCubit>().loadWeeklyData();
    } catch (e) {
      debugPrint('LogFoodCubit: nutrition refresh skipped: $e');
    }

    try {
      await getIt<ProgressTrendsCubit>().loadTrailingDays();
    } catch (e) {
      debugPrint('LogFoodCubit: progress trends refresh skipped: $e');
    }
  }

  Future<int?> _recordSuccessfulLog() async {
    final nextCount = Storage.logSuccessCount + 1;
    await Storage.setLogSuccessCount(nextCount);
    return nextCount.isOdd ? nextCount : null;
  }

  DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

  DateTime? _diarySelectedDate(DiaryCubit cubit) {
    return cubit.state.maybeWhen(
      initial: _dateOnly,
      loading: (date, _) => _dateOnly(date),
      loaded: (date, _) => _dateOnly(date),
      error: (date, _, __) => _dateOnly(date),
      removeFoodEntryLoading: (date, _) => _dateOnly(date),
      removeFoodEntrySuccess: (date, _, __) => _dateOnly(date),
      removeFoodEntryError: (date, _, __) => _dateOnly(date),
      orElse: () => null,
    );
  }
}
