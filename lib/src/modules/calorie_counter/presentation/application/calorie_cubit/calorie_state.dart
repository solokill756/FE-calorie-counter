part of 'calorie_cubit.dart';

@freezed
class CalorieState with _$CalorieState {
  const factory CalorieState.loaded({
    @Default(false) bool isLoading,
    @Default(false) bool isError,
    String? errorMessage,
    CalorieEntity? todayCalories,
    MacroEntity? todayMacros,
    @Default([]) List<ActivityEntity> todayActivities,
    @Default([]) List<WeightEntity> weightHistory,
    @Default(0) int steps,
    @Default(10000) int stepGoal,
  }) = _Loaded;
  const factory CalorieState.initial() = _Initial;
  const factory CalorieState.loading() = _Loading;
  const factory CalorieState.error(String message) = _Error;
}
