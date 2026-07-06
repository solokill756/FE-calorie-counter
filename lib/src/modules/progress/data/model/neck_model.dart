import 'package:freezed_annotation/freezed_annotation.dart';
part 'neck_model.freezed.dart';
part 'neck_model.g.dart';

@freezed
class NeckModel with _$NeckModel {
  const factory NeckModel({
    required DateTime recordedAt,
    required double neckCm,
    int? id,
  }) = _NeckModel;

  factory NeckModel.fromJson(Map<String, dynamic> json) =>
      _$NeckModelFromJson(json);
}
