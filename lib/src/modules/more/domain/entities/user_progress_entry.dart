import 'package:caloriecounter/src/modules/weight_form/data/model/weightForm_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_progress_entry.freezed.dart';
part 'user_progress_entry.g.dart';

@freezed
class UserProgressEntry with _$UserProgressEntry {
  const factory UserProgressEntry({
    required int steaksConsumed,
    required WeightFormModel weight,
  }) = _UserProgressEntry;
  factory UserProgressEntry.fromJson(Map<String, dynamic> json) =>
      _$UserProgressEntryFromJson(json);
}
