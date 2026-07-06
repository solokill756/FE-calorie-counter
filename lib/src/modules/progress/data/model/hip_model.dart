import 'package:freezed_annotation/freezed_annotation.dart';

part 'hip_model.freezed.dart';
part 'hip_model.g.dart';

@freezed
class HipModel with _$HipModel {
  const factory HipModel({
    required DateTime recordedAt,
    required double hipsCm,
    int? id,
  }) = _HipModel;

  factory HipModel.fromJson(Map<String, dynamic> json) =>
      _$HipModelFromJson(json);
}
