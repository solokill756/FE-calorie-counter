part of 'nutrition_cubit.dart';

extension NutritionStateExtensions on NutritionState {
  bool get isLoading {
    return maybeWhen(loading: (_, __, ___) => true, orElse: () => false);
  }

  String? get errorMessage {
    return maybeWhen(
      error: (message, _, __, ___, ____) => message,
      orElse: () => null,
    );
  }

  WeeklyNutritionData? get weeklyData {
    return maybeWhen(
      loaded: (weeklyData, _, __, ___, ____, a, b, c, d) => weeklyData,
      error: (_, __, ___, ____, weeklyData) => weeklyData,
      orElse: () => null,
    );
  }

  String get selectedPeriod {
    return maybeWhen(
      initial: (_, period, __) => period,
      loading: (_, period, __) => period,
      loaded: (_, __, period, ___, ____, a, b, c, d) => period,
      error: (_, __, period, ___, ____) => period,
      orElse: () => 'Week View',
    );
  }

  DateTime get currentDate {
    return maybeWhen(
      initial: (date, _, __) => date,
      loading: (date, _, __) => date,
      loaded: (_, date, __, ___, ____, a, b, c, d) => date,
      error: (_, date, __, ___, ____) => date,
      orElse: () => DateTime.now(),
    );
  }

  bool get isNetMode {
    return maybeWhen(
      initial: (_, __, isNetMode) => isNetMode,
      loading: (_, __, isNetMode) => isNetMode,
      loaded: (_, __, ___, isNetMode, ____, a, b, c, d) => isNetMode,
      error: (_, __, ___, isNetMode, ____) => isNetMode,
      orElse: () => false,
    );
  }

  List<String> get foodsHighestInCalories {
    return maybeWhen(
      loaded: (_, __, ___, ____, ______, foods, a, b, c) => foods,
      orElse: () => <String>[],
    );
  }

  List<String> get foodsHighestInCarbohydrates {
    return maybeWhen(
      loaded: (_, __, ___, ____, ______, a, foods, b, c) => foods,
      orElse: () => <String>[],
    );
  }

  List<String> get foodsHighestInFat {
    return maybeWhen(
      loaded: (_, __, ___, ____, ______, a, b, foods, c) => foods,
      orElse: () => <String>[],
    );
  }

  List<String> get foodsHighestInProtein {
    return maybeWhen(
      loaded: (_, __, ___, ____, ______, a, b, c, foods) => foods,
      orElse: () => <String>[],
    );
  }
}
