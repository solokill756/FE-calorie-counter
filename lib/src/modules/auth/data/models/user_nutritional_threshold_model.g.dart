// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_nutritional_threshold_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserNutritionalThresholdImpl _$$UserNutritionalThresholdImplFromJson(
        Map<String, dynamic> json) =>
    _$UserNutritionalThresholdImpl(
      nutrient: json['nutrient'] as String,
      minAmount: (json['minAmount'] as num?)?.toDouble(),
      maxAmount: (json['maxAmount'] as num?)?.toDouble(),
      unit: json['unit'] as String? ?? 'g',
    );

Map<String, dynamic> _$$UserNutritionalThresholdImplToJson(
        _$UserNutritionalThresholdImpl instance) =>
    <String, dynamic>{
      'nutrient': instance.nutrient,
      'minAmount': instance.minAmount,
      'maxAmount': instance.maxAmount,
      'unit': instance.unit,
    };
