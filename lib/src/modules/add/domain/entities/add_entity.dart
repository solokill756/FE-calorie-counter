import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_entity.freezed.dart';
part 'add_entity.g.dart';

@freezed
class AddEntity with _$AddEntity {
  const factory AddEntity({
    @Default('') String id,
    @Default('') String type,
    @Default('') String name,
    @Default(0.0) double value,
    @Default('') String unit,
    DateTime? timestamp,
  }) = _AddEntity;

  factory AddEntity.fromJson(Map<String, dynamic> json) =>
      _$AddEntityFromJson(json);
}
