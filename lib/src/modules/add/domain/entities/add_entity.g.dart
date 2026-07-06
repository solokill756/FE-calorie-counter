// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddEntityImpl _$$AddEntityImplFromJson(Map<String, dynamic> json) =>
    _$AddEntityImpl(
      id: json['id'] as String? ?? '',
      type: json['type'] as String? ?? '',
      name: json['name'] as String? ?? '',
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      unit: json['unit'] as String? ?? '',
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$AddEntityImplToJson(_$AddEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'value': instance.value,
      'unit': instance.unit,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
