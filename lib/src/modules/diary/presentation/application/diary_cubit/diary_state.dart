import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/diary_entity.dart';

part 'diary_state.freezed.dart';

@freezed
class DiaryState with _$DiaryState {
  const factory DiaryState.initial({required DateTime selectedDate}) =
      DiaryInitial;

  const factory DiaryState.loading({
    required DateTime selectedDate,
    DiaryEntity? diary,
  }) = DiaryLoading;

  const factory DiaryState.loaded({
    required DateTime selectedDate,
    required DiaryEntity diary,
  }) = DiaryLoaded;

  const factory DiaryState.error({
    required DateTime selectedDate,
    required String message,
    DiaryEntity? diary,
  }) = DiaryError;

  const factory DiaryState.removeFoodEntryLoading({
    required DateTime selectedDate,
    DiaryEntity? diary,
  }) = _DiaryRemoveFoodEntryLoading;

  const factory DiaryState.removeFoodEntryError({
    required DateTime selectedDate,
    DiaryEntity? diary,
    required String message,
  }) = DiaryRemoveFoodEntryError;

  const factory DiaryState.removeFoodEntrySuccess({
    required DateTime selectedDate,
    DiaryEntity? diary,
    required String message,
  }) = DiaryRemoveFoodEntrySuccess;
}

extension DiaryStateX on DiaryState {
  DiaryEntity? get diaryOrNull => maybeWhen(
    loaded: (_, diary) => diary,
    loading: (_, diary) => diary,
    error: (_, __, diary) => diary,
    removeFoodEntryLoading: (_, diary) => diary,
    removeFoodEntrySuccess: (_, diary, __) => diary,
    removeFoodEntryError: (_, diary, __) => diary,
    orElse: () => null,
  );

  DateTime get selectedDate => maybeWhen(
    initial: (d) => d,
    loading: (d, _) => d,
    loaded: (d, _) => d,
    error: (d, _, __) => d,
    removeFoodEntryLoading: (d, _) => d,
    removeFoodEntrySuccess: (d, _, __) => d,
    removeFoodEntryError: (d, _, __) => d,
    orElse: () => DateTime.now(),
  );
}
