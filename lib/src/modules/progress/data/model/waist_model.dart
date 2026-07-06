import 'package:freezed_annotation/freezed_annotation.dart';
part 'waist_model.freezed.dart';
part 'waist_model.g.dart';

@freezed
class WaistModel with _$WaistModel {
  const factory WaistModel({
    required DateTime recordedAt,
    required double waistCm,
    int? id,
  }) = _WaistModel;

  factory WaistModel.fromJson(Map<String, dynamic> json) =>
      _$WaistModelFromJson(json);
}
