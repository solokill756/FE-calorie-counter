// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HipModelImpl _$$HipModelImplFromJson(Map<String, dynamic> json) =>
    _$HipModelImpl(
      recordedAt: DateTime.parse(json['recordedAt'] as String),
      hipsCm: (json['hipsCm'] as num).toDouble(),
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$HipModelImplToJson(_$HipModelImpl instance) =>
    <String, dynamic>{
      'recordedAt': instance.recordedAt.toIso8601String(),
      'hipsCm': instance.hipsCm,
      'id': instance.id,
    };
