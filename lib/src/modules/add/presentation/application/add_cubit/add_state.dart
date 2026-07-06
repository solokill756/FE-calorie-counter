part of 'add_cubit.dart';

@freezed
class AddState with _$AddState {
  const factory AddState({
    @Default(null) AddAction? selectedAction,
    @Default(false) bool isLoading,
  }) = _AddState;
}

enum AddAction {
  logFood,
  barcodeScan,
  voiceLog,
  mealScan,
  water,
  weight,
  exercise,
  aiSuggestRecipe,
  aiPhotoRecipe,
}
