part of 'food_detail_cubit.dart';

@freezed
class FoodDetailState with _$FoodDetailState {
  const factory FoodDetailState.initial({
    required DateTime currentDate,
    @Default('Week View') String selectedPeriod,
  }) = FoodDetailInitial;

  const factory FoodDetailState.loading({
    required DateTime currentDate,
    required String selectedPeriod,
  }) = FoodDetailLoading;

  const factory FoodDetailState.loaded({
    required List<FoodItemEntity> foods,
    required DateTime currentDate,
    required String selectedPeriod,
  }) = FoodDetailLoaded;

  const factory FoodDetailState.error({
    required String message,
    required DateTime currentDate,
    required String selectedPeriod,
  }) = FoodDetailError;
}
