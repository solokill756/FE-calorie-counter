// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_progress_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProgressEntryImpl _$$UserProgressEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$UserProgressEntryImpl(
      steaksConsumed: (json['steaksConsumed'] as num).toInt(),
      weight: WeightFormModel.fromJson(json['weight'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserProgressEntryImplToJson(
        _$UserProgressEntryImpl instance) =>
    <String, dynamic>{
      'steaksConsumed': instance.steaksConsumed,
      'weight': instance.weight.toJson(),
    };
