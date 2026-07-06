part of 'progress_trends_cubit.dart';

@freezed
class ProgressTrendsState with _$ProgressTrendsState {
  const factory ProgressTrendsState.initial() = _PtInitial;
  const factory ProgressTrendsState.loading() = _PtLoading;
  const factory ProgressTrendsState.loaded(ProgressTrendsResponse data) = _PtLoaded;
  const factory ProgressTrendsState.error(String message) = _PtError;
}
