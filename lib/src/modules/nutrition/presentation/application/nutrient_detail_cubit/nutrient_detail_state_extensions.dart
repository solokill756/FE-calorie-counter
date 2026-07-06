part of 'nutrient_detail_cubit.dart';

extension NutrientDetailStateExtensions on NutrientDetailState {
  bool get isLoading =>
      maybeWhen(loading: (_, __, ___) => true, orElse: () => false);

  String? get errorMessage =>
      maybeWhen(error: (message, _, __, ___) => message, orElse: () => null);

  WeeklyNutritionData? get weeklyData => maybeWhen(
    loaded: (weeklyData, _, __, ___, ____) => weeklyData,
    orElse: () => null,
  );

  String get selectedPeriod => maybeWhen(
    initial: (_, period, __) => period,
    loading: (_, period, __) => period,
    loaded: (_, __, ___, period, ____) => period,
    error: (_, __, period, ____) => period,
    orElse: () => 'Week View',
  );

  DateTime get currentDate => maybeWhen(
    initial: (date, _, __) => date,
    loading: (date, _, __) => date,
    loaded: (_, __, date, ___, ____) => date,
    error: (_, date, __, ____) => date,
    orElse: () => DateTime.now(),
  );

  String? get nutrientName => maybeWhen(
    initial: (_, __, name) => name,
    loading: (_, __, name) => name,
    loaded: (_, __, ___, ____, name) => name,
    error: (_, __, ___, name) => name,
    orElse: () => null,
  );

  List<String> get foodsHighestInNutrient =>
      maybeWhen(loaded: (_, foods, __, ___, ____) => foods, orElse: () => []);
}
