part of 'nutrient_detail_cubit.dart';

@freezed
class NutrientDetailState with _$NutrientDetailState {
  const factory NutrientDetailState.initial({
    required DateTime currentDate,
    @Default('Week View') String selectedPeriod,
    String? nutrientName,
  }) = NutrientDetailInitial;

  const factory NutrientDetailState.loading({
    required DateTime currentDate,
    required String selectedPeriod,
    String? nutrientName,
  }) = NutrientDetailLoading;

  const factory NutrientDetailState.loaded({
    required WeeklyNutritionData weeklyData,
    required List<String> foodsHighestInNutrient,
    required DateTime currentDate,
    required String selectedPeriod,
    String? nutrientName,
  }) = NutrientDetailLoaded;

  const factory NutrientDetailState.error({
    required String message,
    required DateTime currentDate,
    required String selectedPeriod,
    String? nutrientName,
  }) = NutrientDetailError;
}
