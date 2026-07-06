part of 'logfood_cubit.dart';

@freezed
class LogFoodState with _$LogFoodState {
  const factory LogFoodState.initial() = LogFoodInitial;

  const factory LogFoodState.loading() = LogFoodGeneralLoading;

  const factory LogFoodState.error(String message) = LogFoodError;
  const factory LogFoodState.logFoodSuccess(
    String message, [
    int? ratingPromptLogCount,
  ]) = LogFoodLogSuccess;
  const factory LogFoodState.logFoodError(String message) = LogFoodLogError;
  const factory LogFoodState.logFoodLoading() = LogFoodLoading;
  const factory LogFoodState.logFoodDetailSuccess(
    String message, [
    int? ratingPromptLogCount,
  ]) = LogFoodLogDetailSuccess;
  const factory LogFoodState.quickAddSuccess(
    String message, [
    int? ratingPromptLogCount,
  ]) = LogFoodQuickAddSuccess;

  const factory LogFoodState.quickAddLoading() = LogFoodQuickAddLoading;

  const factory LogFoodState.quickAddError(String message) =
      LogFoodQuickAddError;
  const factory LogFoodState.logFoodDetailLoading() = LogFoodDetailLoading;
  const factory LogFoodState.logFoodDetailError(String message) =
      LogFoodDetailError;
}
