part of 'progress_cubit.dart';

@freezed
class ProgressState with _$ProgressState {
  const factory ProgressState.initial() = _Initial;
  const factory ProgressState.loading() = _Loading;
  const factory ProgressState.loaded({required ProgressStats stats}) = _Loaded;
  const factory ProgressState.error(String message) = _Error;
  const factory ProgressState.adding() = _Adding;
  const factory ProgressState.addedSuccess(String message) = _AddedSuccess;
  const factory ProgressState.updatedSuccess(String message) = _UpdatedSuccess;
  const factory ProgressState.deletedSuccess(String message) = _DeletedSuccess;
  const factory ProgressState.addedFailure(String message) = _AddedFailure;
  const factory ProgressState.updatedFailure(String message) = _UpdatedFailure;
  const factory ProgressState.deletedFailure(String message) = _DeletedFailure;
}
