import 'dart:async';

import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/application/dashboard_cubit.dart';
import 'package:caloriecounter/src/modules/nutrition/presentation/application/nutrition_cubit/nutrition_cubit.dart';
import 'package:caloriecounter/src/modules/progress/presentation/application/progress_trends_cubit/progress_trends_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../common/utils/error_message_mapper.dart';
import '../../../domain/entities/diary_entity.dart';
import '../../../domain/repository/diary_repository.dart';
import 'diary_state.dart';

@singleton
class DiaryCubit extends Cubit<DiaryState> {
  final DiaryRepository _repository;
  DiaryLoaded? previousLoadedState;
  DiaryCubit(this._repository)
    : super(DiaryState.initial(selectedDate: DateTime.now()));

  Future<void> loadDiaryForDate(
    DateTime date,
    DiaryEntity? initialDiary,
  ) async {
    final currentDiary = state.maybeWhen(
      loaded: (_, diary) => diary,
      loading: (_, diary) => diary,
      error: (_, __, diary) => diary,
      orElse: () => null,
    );

    emit(DiaryState.loading(selectedDate: date, diary: currentDiary));

    try {
      final diary = initialDiary ?? await _repository.getDiaryForDate(date);
      emit(DiaryState.loaded(selectedDate: date, diary: diary));
    } catch (e) {
      debugPrint('Diary load error: $e');
      emit(
        DiaryState.error(
          selectedDate: date,
          message: ErrorMessageMapper.messageFor(
            e,
            fallbackMessage: 'Unable to load diary data. Please try again.',
            featureLabel: 'diary',
          ),
          diary: currentDiary,
        ),
      );
    }
  }

  void changeDate(DateTime newDate) {
    loadDiaryForDate(newDate, null);
  }

  void nextDay() {
    final selectedDate = state.maybeWhen(
      initial: (date) => date,
      loading: (date, _) => date,
      loaded: (date, _) => date,
      error: (date, _, __) => date,
      orElse: () => DateTime.now(),
    );
    final nextDate = selectedDate.add(const Duration(days: 1));
    changeDate(nextDate);
  }

  void previousDay() {
    final selectedDate = state.maybeWhen(
      initial: (date) => date,
      loading: (date, _) => date,
      loaded: (date, _) => date,
      error: (date, _, __) => date,
      orElse: () => DateTime.now(),
    );
    final previousDate = selectedDate.subtract(const Duration(days: 1));
    changeDate(previousDate);
  }

  void goToToday() {
    changeDate(DateTime.now());
  }

  /// Reload the diary date currently shown (e.g. after weight changes daily targets).
  Future<void> reloadCurrentDiary() async {
    final selectedDate = state.selectedDate;
    await loadDiaryForDate(selectedDate, null);
  }

  Future<void> addFood(String mealType) async {
    // This would open a food selection dialog
    // For now, just show a placeholder
  }

  Future<void> addExercise() async {
    // This would open an exercise selection dialog
    // For now, just show a placeholder
  }

  Future<void> addWater() async {
    final diary = state.maybeWhen(
      loaded: (_, diary) => diary,
      orElse: () => null,
    );
    if (diary != null) {
      if (diary.isCompleted) return;
      final selectedDate = state.maybeWhen(
        initial: (date) => date,
        loading: (date, _) => date,
        loaded: (date, _) => date,
        error: (date, _, __) => date,
        orElse: () => DateTime.now(),
      );
      final nextAmountMl = (diary.waterAmountMl + 250).clamp(0, 20000);
      try {
        await _repository.updateWaterIntake(selectedDate, nextAmountMl);
        emit(
          DiaryState.loaded(
            selectedDate: selectedDate,
            diary: diary.copyWith(
              waterAmountMl: nextAmountMl,
              waterGlasses: (nextAmountMl / 250).round(),
            ),
          ),
        );
      } catch (e) {
        debugPrint('Add water error: $e');
        emit(
          DiaryState.error(
            selectedDate: selectedDate,
            message: ErrorMessageMapper.messageFor(
              e,
              fallbackMessage: 'Unable to update water intake. Please try again.',
              featureLabel: 'diary',
            ),
            diary: diary,
          ),
        );
      }
    }
  }

  Future<String?> updateNote(String? note) async {
    final selectedDate = state.selectedDate;
    final currentDiary = state.maybeWhen(
      loaded: (_, diary) => diary,
      loading: (_, diary) => diary,
      error: (_, __, diary) => diary,
      removeFoodEntryLoading: (_, diary) => diary,
      removeFoodEntrySuccess: (_, diary, __) => diary,
      removeFoodEntryError: (_, diary, __) => diary,
      orElse: () => null,
    );

    if (currentDiary == null) {
      return 'Diary data is not available yet.';
    }
    if (currentDiary.isCompleted) {
      return 'This diary is completed. Editing is disabled.';
    }

    final normalized = note?.trim();
    final nextNote = normalized == null || normalized.isEmpty ? null : normalized;

    try {
      await _repository.updateDiaryNote(selectedDate, nextNote);
      emit(
        DiaryState.loaded(
          selectedDate: selectedDate,
          diary: currentDiary.copyWith(note: nextNote),
        ),
      );
      return null;
    } catch (e) {
      debugPrint('Update diary note error: $e');
      return ErrorMessageMapper.messageFor(
        e,
        fallbackMessage: 'Unable to save note. Please try again.',
        featureLabel: 'diary',
      );
    }
  }

  Future<String?> clearNote() => updateNote(null);

  Future<void> removeFoodEntry(String mealType, String foodId) async {
    final selectedDate = state.maybeWhen(
      initial: (date) => date,
      loading: (date, _) => date,
      loaded: (date, _) => date,
      error: (date, _, __) => date,
      removeFoodEntryLoading: (date, _) => date,
      removeFoodEntrySuccess: (date, _, __) => date,
      removeFoodEntryError: (date, _, __) => date,
      orElse: () => DateTime.now(),
    );
    final currentDiary = state.maybeWhen(
      loaded: (_, diary) => diary,
      loading: (_, diary) => diary,
      error: (_, __, diary) => diary,
      removeFoodEntryLoading: (_, diary) => diary,
      removeFoodEntrySuccess: (_, diary, __) => diary,
      removeFoodEntryError: (_, diary, __) => diary,
      orElse: () => null,
    );

    if (currentDiary == null || currentDiary.isCompleted) return;

    // Optimistic UI: Update UI immediately
    final updatedDiary = currentDiary.removeFoodEntry(mealType, foodId);

    emit(DiaryState.loaded(selectedDate: selectedDate, diary: updatedDiary));

    // Call API in background
    final result = await _repository.removeFoodEntry(
      selectedDate,
      mealType,
      foodId,
    );

    result.fold(
      (_) {
        unawaited(_refreshFoodDependentData(selectedDate));
        // Success: Keep the optimistic update, just show success message
        emit(
          DiaryState.removeFoodEntrySuccess(
            selectedDate: selectedDate,
            diary: updatedDiary,
            message: 'Food entry removed successfully',
          ),
        );
      },
      (error) {
        // Error: Rollback to original state
        emit(
          DiaryState.removeFoodEntryError(
            selectedDate: selectedDate,
            diary: currentDiary, // Rollback to original
            message: error.message,
          ),
        );
        debugPrint('Error removing food entry: ${error.message}');
      },
    );
  }

  Future<void> removeExerciseEntry(String exerciseId) async {
    final selectedDate = state.maybeWhen(
      initial: (date) => date,
      loading: (date, _) => date,
      loaded: (date, _) => date,
      error: (date, _, __) => date,
      orElse: () => DateTime.now(),
    );
    final currentDiary = state.maybeWhen(
      loaded: (_, diary) => diary,
      loading: (_, diary) => diary,
      error: (_, __, diary) => diary,
      orElse: () => null,
    );
    if (currentDiary?.isCompleted == true) return;

    try {
      await _repository.removeExerciseEntry(selectedDate, exerciseId);
      // Reload data to reflect changes
      loadDiaryForDate(selectedDate, null);
      unawaited(_refreshFoodDependentData(selectedDate));
    } catch (e) {
      debugPrint('Remove exercise error: $e');
      emit(
        DiaryState.error(
          selectedDate: selectedDate,
          message: ErrorMessageMapper.messageFor(
            e,
            fallbackMessage: 'Unable to remove exercise. Please try again.',
            featureLabel: 'diary',
          ),
          diary: currentDiary,
        ),
      );
    }
  }

  Future<String?> completeDiary() async {
    final selectedDate = state.maybeWhen(
      initial: (date) => date,
      loading: (date, _) => date,
      loaded: (date, _) => date,
      error: (date, _, __) => date,
      removeFoodEntryLoading: (date, _) => date,
      removeFoodEntrySuccess: (date, _, __) => date,
      removeFoodEntryError: (date, _, __) => date,
      orElse: () => DateTime.now(),
    );

    final currentDiary = state.maybeWhen(
      loaded: (_, diary) => diary,
      loading: (_, diary) => diary,
      error: (_, __, diary) => diary,
      removeFoodEntryLoading: (_, diary) => diary,
      removeFoodEntrySuccess: (_, diary, __) => diary,
      removeFoodEntryError: (_, diary, __) => diary,
      orElse: () => null,
    );

    if (currentDiary == null) {
      return 'Diary data is not available yet.';
    }

    if (currentDiary.isCompleted) {
      return 'This diary is already completed.';
    }

    try {
      await _repository.updateDiaryStatus(
        date: selectedDate,
        isCompleted: true,
      );

      emit(
        DiaryState.loaded(
          selectedDate: selectedDate,
          diary: currentDiary.copyWith(isCompleted: true),
        ),
      );
      unawaited(_refreshFoodDependentData(selectedDate));
      return null;
    } catch (e) {
      debugPrint('Complete diary error: $e');
      return ErrorMessageMapper.messageFor(
        e,
        fallbackMessage: 'Unable to complete diary. Please try again.',
        featureLabel: 'diary',
      );
    }
  }

  Future<void> _refreshFoodDependentData(DateTime date) async {
    try {
      if (_dateOnly(date) == _dateOnly(DateTime.now())) {
        await getIt<DashboardCubit>().refreshDashboard();
      }
    } catch (e) {
      debugPrint('DiaryCubit: dashboard refresh skipped: $e');
    }

    try {
      await getIt<NutritionCubit>().loadWeeklyData();
    } catch (e) {
      debugPrint('DiaryCubit: nutrition refresh skipped: $e');
    }

    try {
      await getIt<ProgressTrendsCubit>().loadTrailingDays();
    } catch (e) {
      debugPrint('DiaryCubit: progress trends refresh skipped: $e');
    }
  }

  DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);
}
