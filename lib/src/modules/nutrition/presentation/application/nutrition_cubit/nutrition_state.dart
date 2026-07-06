part of 'nutrition_cubit.dart';

@freezed
class NutritionState with _$NutritionState {
  const factory NutritionState.initial({
    required DateTime currentDate,
    @Default('Week View') String selectedPeriod,
    @Default(false) bool isNetMode,
  }) = NutritionInitial;

  const factory NutritionState.loading({
    required DateTime currentDate,
    required String selectedPeriod,
    @Default(false) bool isNetMode,
  }) = NutritionLoading;

  const factory NutritionState.loaded({
    required WeeklyNutritionData weeklyData,
    required DateTime currentDate,
    required String selectedPeriod,
    @Default(false) bool isNetMode,
    @Default(false) bool fresh,
    @Default([]) List<String> foodsHighestInCalories,
    @Default([]) List<String> foodsHighestInCarbohydrates,
    @Default([]) List<String> foodsHighestInFat,
    @Default([]) List<String> foodsHighestInProtein,
  }) = NutritionLoaded;

  const factory NutritionState.error({
    required String message,
    required DateTime currentDate,
    required String selectedPeriod,
    @Default(false) bool isNetMode,
    WeeklyNutritionData? weeklyData,
  }) = NutritionError;
}
