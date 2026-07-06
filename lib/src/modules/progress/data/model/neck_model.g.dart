// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'neck_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NeckModelImpl _$$NeckModelImplFromJson(Map<String, dynamic> json) =>
    _$NeckModelImpl(
      recordedAt: DateTime.parse(json['recordedAt'] as String),
      neckCm: (json['neckCm'] as num).toDouble(),
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$NeckModelImplToJson(_$NeckModelImpl instance) =>
    <String, dynamic>{
      'recordedAt': instance.recordedAt.toIso8601String(),
      'neckCm': instance.neckCm,
      'id': instance.id,
    };
