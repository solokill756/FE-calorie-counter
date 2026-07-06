// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WaistModelImpl _$$WaistModelImplFromJson(Map<String, dynamic> json) =>
    _$WaistModelImpl(
      recordedAt: DateTime.parse(json['recordedAt'] as String),
      waistCm: (json['waistCm'] as num).toDouble(),
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$WaistModelImplToJson(_$WaistModelImpl instance) =>
    <String, dynamic>{
      'recordedAt': instance.recordedAt.toIso8601String(),
      'waistCm': instance.waistCm,
      'id': instance.id,
    };
