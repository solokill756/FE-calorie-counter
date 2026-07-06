import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:caloriecounter/src/modules/calorie_counter/presentation/application/calorie_cubit/calorie_cubit.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/application/dashboard_cubit.dart';
import 'package:caloriecounter/src/modules/diary/presentation/application/diary_cubit/diary_cubit.dart';
import 'package:caloriecounter/src/modules/nutrition/presentation/application/nutrition_cubit/nutrition_cubit.dart';
import 'package:caloriecounter/src/modules/progress/presentation/application/progress_trends_cubit/progress_trends_cubit.dart';
import '../../../domain/models/exercise_models.dart';
import '../../../domain/repository/exercise_repository.dart';
import '../../../../logfood/helper/log_food_helper.dart';

class ExerciseUiState {
  const ExerciseUiState({
    this.homeLoading = false,
    this.listLoading = false,
    this.error,
    this.today,
    this.recent = const [],
    this.catalog,
    this.history,
    this.catalogMineOnly = false,
  });

  final bool homeLoading;
  final bool listLoading;
  final String? error;
  final ExerciseSummaryToday? today;
  final List<ExerciseLogListItem> recent;
  final ExerciseListPage? catalog;
  final ExerciseLogListPage? history;
  final bool catalogMineOnly;

  ExerciseUiState copyWith({
    bool? homeLoading,
    bool? listLoading,
    String? error,
    ExerciseSummaryToday? today,
    List<ExerciseLogListItem>? recent,
    ExerciseListPage? catalog,
    ExerciseLogListPage? history,
    bool? catalogMineOnly,
    bool clearError = false,
  }) {
    return ExerciseUiState(
      homeLoading: homeLoading ?? this.homeLoading,
      listLoading: listLoading ?? this.listLoading,
      error: clearError ? null : (error ?? this.error),
      today: today ?? this.today,
      recent: recent ?? this.recent,
      catalog: catalog ?? this.catalog,
      history: history ?? this.history,
      catalogMineOnly: catalogMineOnly ?? this.catalogMineOnly,
    );
  }

  /// Prefer summary items (same source as Today card); fall back to legacy recent list.
  List<ExerciseLogListItem> get recentLogsToday {
    final summaryItems = today?.items ?? const [];
    if (summaryItems.isNotEmpty) return summaryItems;
    return recent;
  }
}

@singleton
class ExerciseCubit extends Cubit<ExerciseUiState> {
  ExerciseCubit(this._repo) : super(const ExerciseUiState());

  final ExerciseRepository _repo;

  Future<void> refreshHome() async {
    emit(state.copyWith(homeLoading: true, clearError: true));
    try {
      final dateKey = LogFoodHelper().dateKeyFrom(DateTime.now());
      var today = await _repo.getTodaySummary(date: dateKey);
      var recent = today.items;

      if (recent.isEmpty && today.totalLogs > 0) {
        final logs = await _repo.listLogs(
          from: dateKey,
          to: dateKey,
          page: 1,
          limit: 50,
        );
        recent = logs.items;
        today = ExerciseSummaryToday(
          date: today.date,
          totalCaloriesBurned: today.totalCaloriesBurned,
          totalMinutes: today.totalMinutes,
          totalLogs: today.totalLogs,
          items: recent,
        );
      }

      emit(
        state.copyWith(
          homeLoading: false,
          today: today,
          recent: recent,
          clearError: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          homeLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> loadCatalog({
    String? q,
    String? type,
    bool? mineOnly,
    int page = 1,
  }) async {
    final effectiveMineOnly = mineOnly ?? state.catalogMineOnly;
    emit(state.copyWith(listLoading: true, clearError: true, catalogMineOnly: effectiveMineOnly));
    try {
      final cat = await _repo.listExercises(
        q: q,
        type: type,
        mineOnly: effectiveMineOnly,
        page: page,
        limit: 30,
      );
      emit(state.copyWith(listLoading: false, catalog: cat));
    } catch (e) {
      emit(
        state.copyWith(
          listLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> loadHistory(String from, String to, {int page = 1}) async {
    emit(state.copyWith(listLoading: true, clearError: true));
    try {
      final logs = await _repo.listLogs(
        from: from,
        to: to,
        page: page,
        limit: 50,
      );
      emit(state.copyWith(listLoading: false, history: logs));
    } catch (e) {
      emit(
        state.copyWith(
          listLoading: false,
          error: e.toString(),
        ),
      );
    }
  }

  Future<ExerciseItem?> loadExerciseDetail(int id) async {
    try {
      return await _repo.getExercise(id);
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
      return null;
    }
  }

  Future<bool> deleteExerciseFromCatalog(int id) async {
    try {
      await _repo.deleteExercise(id);
      await loadCatalog();
      return true;
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
      return false;
    }
  }

  Future<ExerciseLogCreated> createLogAndRefresh({
    required int exerciseId,
    DateTime? startedAt,
    required double minutesPerformed,
    String source = 'manual',
    String? historyFrom,
    String? historyTo,
  }) async {
    final changedAt = startedAt ?? DateTime.now();
    final created = await _repo.createLog(
      exerciseId: exerciseId,
      startedAt: startedAt,
      minutesPerformed: minutesPerformed,
      source: source,
    );

    _applyOptimisticLog(created, changedAt);
    final isToday = _dateOnly(changedAt) == _dateOnly(DateTime.now());
    final refresh = refreshExerciseDependentData(
      changedAt,
      historyFrom: historyFrom,
      historyTo: historyTo,
    );
    if (isToday) {
      await refresh;
    } else {
      unawaited(refresh);
    }
    return created;
  }

  void _applyOptimisticLog(ExerciseLogCreated created, DateTime changedAt) {
    final changedDay = _dateOnly(changedAt);
    final isToday = changedDay == _dateOnly(DateTime.now());
    if (!isToday) return;

    final current = state.today;

    final nextRecent = <ExerciseLogListItem>[
      ExerciseLogListItem(
        id: created.id,
        exerciseId: created.exercise.id,
        exerciseName: created.exercise.name,
        exerciseType: created.exercise.type,
        startedAt: created.startedAt,
        minutesPerformed: created.minutesPerformed,
        caloriesBurned: created.caloriesBurned,
        source: created.source,
      ),
      ...state.recentLogsToday,
    ];

    final nextToday = current == null
        ? ExerciseSummaryToday(
            date: LogFoodHelper().dateKeyFrom(changedDay),
            totalCaloriesBurned: created.caloriesBurned,
            totalMinutes: created.minutesPerformed,
            totalLogs: 1,
            items: nextRecent,
          )
        : ExerciseSummaryToday(
            date: current.date,
            totalCaloriesBurned:
                current.totalCaloriesBurned + created.caloriesBurned,
            totalMinutes: current.totalMinutes + created.minutesPerformed,
            totalLogs: current.totalLogs + 1,
            items: nextRecent,
          );

    emit(state.copyWith(today: nextToday, recent: nextRecent));
  }

  Future<void> refreshExerciseDependentData(
    DateTime changedAt, {
    String? historyFrom,
    String? historyTo,
  }) async {
    final changedDay = _dateOnly(changedAt);
    final changedKey = LogFoodHelper().dateKeyFrom(changedDay);
    final today = _dateOnly(DateTime.now());
    final isToday = changedDay == today;

    if (isToday) {
      await refreshHome();
      unawaited(_runSafe(() async => getIt<DashboardCubit>().refreshDashboard(), label: '.refreshDashboard'));
    }

    unawaited(
      _runSafe(() async {
        if (historyFrom != null &&
            historyTo != null &&
            historyFrom.compareTo(changedKey) <= 0 &&
            historyTo.compareTo(changedKey) >= 0) {
          await loadHistory(historyFrom, historyTo);
        }
      }, label: '.loadHistory'),
    );

    unawaited(
      _runSafe(() async {
        final diaryCubit = getIt<DiaryCubit>();
        final selectedDiaryDay = _diarySelectedDate(diaryCubit);
        if (selectedDiaryDay != null && selectedDiaryDay == changedDay) {
          await diaryCubit.loadDiaryForDate(selectedDiaryDay, null);
        }
      }, label: '.refreshDiary'),
    );

    if (isToday) {
      unawaited(_runSafe(() async => getIt<CalorieCubit>().loadTodayData(), label: '.calorie'));
    }

    unawaited(_runSafe(() async => getIt<NutritionCubit>().loadWeeklyData(), label: '.nutrition'));
    unawaited(_runSafe(() async => getIt<ProgressTrendsCubit>().loadTrailingDays(), label: '.progress'));
  }

  Future<void> _runSafe(Future<void> Function() task, {String label = ''}) async {
    try {
      await task();
    } catch (e) {
      // Cross-module refresh chạy best-effort; lỗi không ảnh hưởng UX chính
      debugPrint('ExerciseCubit._runSafe$label: $e');
    }
  }

  Future<void> deleteLog(
    int id, {
    required String from,
    required String to,
    DateTime? changedAt,
  }) async {
    await _repo.deleteLog(id);
    await refreshExerciseDependentData(
      changedAt ?? DateTime.now(),
      historyFrom: from,
      historyTo: to,
    );
  }

  DateTime _dateOnly(DateTime date) {
    final local = date.toLocal();
    return DateTime(local.year, local.month, local.day);
  }

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
