part of 'weightForm_cubit.dart';

@freezed
class WeightFormState with _$WeightFormState {
  const factory WeightFormState.initial() = WeightFormInitial;
  const factory WeightFormState.savingLoading() = WeightFormSavingLoading;
  const factory WeightFormState.saveSuccess(String message) =
      WeightFormSaveSuccess;
  const factory WeightFormState.saveFailure(String message) =
      WeightFormSaveFailure;
  const factory WeightFormState.loading() = WeightFormLoading;
  const factory WeightFormState.loaded(WeightFormModel weightEntry) =
      WeightFormLoaded;
  const factory WeightFormState.error(String message) = WeightFormError;
}
