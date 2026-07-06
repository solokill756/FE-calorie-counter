part of 'food_detail_cubit.dart';

extension FoodDetailStateExtensions on FoodDetailState {
  bool get isLoading {
    return maybeWhen(loading: (_, __) => true, orElse: () => false);
  }

  String? get errorMessage {
    return maybeWhen(error: (message, _, __) => message, orElse: () => null);
  }

  List<FoodItemEntity> get foods {
    return maybeWhen(
      loaded: (foods, _, __) => foods,
      orElse: () => <FoodItemEntity>[],
    );
  }

  String get selectedPeriod {
    return maybeWhen(
      initial: (_, period) => period,
      loading: (_, period) => period,
      loaded: (_, __, period) => period,
      error: (_, __, period) => period,
      orElse: () => 'Week View',
    );
  }

  DateTime get currentDate {
    return maybeWhen(
      initial: (date, _) => date,
      loading: (date, _) => date,
      loaded: (_, date, __) => date,
      error: (_, date, __) => date,
      orElse: () => DateTime.now(),
    );
  }
}
