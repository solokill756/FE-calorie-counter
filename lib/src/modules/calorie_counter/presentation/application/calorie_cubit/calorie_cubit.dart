import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';
import '../../../domain/repository/calorie_repository.dart';
import '../../../domain/entities/calorie_entity.dart';
part 'calorie_state.dart';
part 'calorie_cubit.freezed.dart';

@singleton
class CalorieCubit extends Cubit<CalorieState> {
  final CalorieRepository _repository;

  CalorieCubit(this._repository) : super(const CalorieState.initial()) {
    _initialize();
  }

  Future<void> _initialize() async {
    await loadTodayData();
  }

  Future<void> loadTodayData() async {
    emit(const CalorieState.loading());
    try {
      final results = await Future.wait([
        _repository.getTodayCalories(),
        _repository.getTodayMacros(),
        _repository.getTodayActivities(),
        _repository.getWeightHistory(),
        // _authRepository.getUserProfile(),
      ]);

      final caloriesResult = results[0] as Result<CalorieEntity, Exception>;
      final macrosResult = results[1] as Result<MacroEntity, Exception>;
      final activitiesResult =
          results[2] as Result<List<ActivityEntity>, Exception>;
      final weightResult = results[3] as Result<List<WeightEntity>, Exception>;

      if (caloriesResult.isSuccess() &&
          macrosResult.isSuccess() &&
          activitiesResult.isSuccess() &&
          weightResult.isSuccess()) {
        emit(
          CalorieState.loaded(
            todayCalories: caloriesResult.getOrNull(),
            todayMacros: macrosResult.getOrNull(),
            todayActivities: activitiesResult.getOrNull() ?? [],
            weightHistory: weightResult.getOrNull() ?? [],
          ),
        );
      } else {
        emit(
          CalorieState.loaded(
            isError: true,
            errorMessage: _getErrorMessage([
              caloriesResult,
              macrosResult,
              activitiesResult,
              weightResult,
            ]),
            todayCalories: caloriesResult.getOrNull(),
            todayMacros: macrosResult.getOrNull(),
            todayActivities: activitiesResult.getOrNull() ?? [],
            weightHistory: weightResult.getOrNull() ?? [],
          ),
        );
      }
    } catch (e) {
      emit(
        CalorieState.loaded(
          isError: true,
          errorMessage: 'Failed to load data: ${e.toString()}',
        ),
      );
    }
  }

  String _getErrorMessage(List<Result> results) {
    final errors = <String>[];
    for (final result in results) {
      if (!result.isSuccess()) {
        errors.add(result.exceptionOrNull()?.toString() ?? 'Unknown error');
      }
    }
    return errors.isEmpty ? 'Unknown error occurred' : errors.join(', ');
  }

  Future<void> addCalories(int calories) async {
    emit(const CalorieState.loading());
    try {
      final result = await _repository.addCalories(calories);
      if (result.isSuccess()) {
        await loadTodayData();
      } else {
        _emitError('Failed to add calories: ${result.exceptionOrNull()}');
      }
    } catch (e) {
      _emitError('Failed to add calories: ${e.toString()}');
    }
  }

  Future<void> addActivity(ActivityEntity activity) async {
    emit(const CalorieState.loading());
    try {
      final result = await _repository.addActivity(activity);
      if (result.isSuccess()) {
        await loadTodayData();
      } else {
        _emitError('Failed to add activity: ${result.exceptionOrNull()}');
      }
    } catch (e) {
      _emitError('Failed to add activity: ${e.toString()}');
    }
  }

  Future<void> updateWeight(double weight) async {
    emit(const CalorieState.loading());
    try {
      final result = await _repository.updateWeight(weight);
      if (result.isSuccess()) {
        await loadTodayData();
      } else {
        _emitError('Failed to update weight: ${result.exceptionOrNull()}');
      }
    } catch (e) {
      _emitError('Failed to update weight: ${e.toString()}');
    }
  }

  void updateSteps(int steps) {
    state.whenOrNull(
      loaded:
          (
            isLoading,
            isError,
            errorMessage,
            todayCalories,
            todayMacros,
            todayActivities,
            weightHistory,
            currentSteps,
            stepGoal,
          ) {
            emit(
              CalorieState.loaded(
                isLoading: isLoading,
                isError: isError,
                errorMessage: errorMessage,
                todayCalories: todayCalories,
                todayMacros: todayMacros,
                todayActivities: todayActivities,
                weightHistory: weightHistory,
                steps: steps,
                stepGoal: stepGoal,
              ),
            );
          },
    );
  }

  void clearError() {
    state.whenOrNull(
      loaded:
          (
            isLoading,
            isError,
            errorMessage,
            todayCalories,
            todayMacros,
            todayActivities,
            weightHistory,
            steps,
            stepGoal,
          ) {
            if (isError) {
              emit(
                CalorieState.loaded(
                  isLoading: isLoading,
                  isError: false,
                  errorMessage: null,
                  todayCalories: todayCalories,
                  todayMacros: todayMacros,
                  todayActivities: todayActivities,
                  weightHistory: weightHistory,
                  steps: steps,
                  stepGoal: stepGoal,
                ),
              );
            }
          },
    );
  }

  void _emitError(String message) {
    state.whenOrNull(
      loaded:
          (
            isLoading,
            isError,
            errorMessage,
            todayCalories,
            todayMacros,
            todayActivities,
            weightHistory,
            steps,
            stepGoal,
          ) {
            emit(
              CalorieState.loaded(
                isLoading: isLoading,
                isError: true,
                errorMessage: message,
                todayCalories: todayCalories,
                todayMacros: todayMacros,
                todayActivities: todayActivities,
                weightHistory: weightHistory,
                steps: steps,
                stepGoal: stepGoal,
              ),
            );
          },
    );
  }

  Future<void> refreshData() async {
    await loadTodayData();
  }
}
