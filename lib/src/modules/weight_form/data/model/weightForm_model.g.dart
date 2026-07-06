// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weightForm_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeightFormModelImpl _$$WeightFormModelImplFromJson(
        Map<String, dynamic> json) =>
    _$WeightFormModelImpl(
      id: (json['id'] as num?)?.toInt(),
      weightKg: (json['weightKg'] as num).toDouble(),
      recordedAt: const DateTimeIso8601Converter()
          .fromJson(json['recordedAt'] as String),
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$$WeightFormModelImplToJson(
        _$WeightFormModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weightKg': instance.weightKg,
      'recordedAt':
          const DateTimeIso8601Converter().toJson(instance.recordedAt),
      'photoUrl': instance.photoUrl,
    };
