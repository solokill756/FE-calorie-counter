// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calorie_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CalorieEntityImpl _$$CalorieEntityImplFromJson(Map<String, dynamic> json) =>
    _$CalorieEntityImpl(
      goal: (json['goal'] as num).toInt(),
      consumed: (json['consumed'] as num).toInt(),
      burned: (json['burned'] as num).toInt(),
      remaining: (json['remaining'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$CalorieEntityImplToJson(_$CalorieEntityImpl instance) =>
    <String, dynamic>{
      'goal': instance.goal,
      'consumed': instance.consumed,
      'burned': instance.burned,
      'remaining': instance.remaining,
      'date': instance.date.toIso8601String(),
    };

_$MacroEntityImpl _$$MacroEntityImplFromJson(Map<String, dynamic> json) =>
    _$MacroEntityImpl(
      carbs: (json['carbs'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      fiber: (json['fiber'] as num).toDouble(),
      sugar: (json['sugar'] as num).toDouble(),
    );

Map<String, dynamic> _$$MacroEntityImplToJson(_$MacroEntityImpl instance) =>
    <String, dynamic>{
      'carbs': instance.carbs,
      'protein': instance.protein,
      'fat': instance.fat,
      'fiber': instance.fiber,
      'sugar': instance.sugar,
    };

_$ActivityEntityImpl _$$ActivityEntityImplFromJson(Map<String, dynamic> json) =>
    _$ActivityEntityImpl(
      type: json['type'] as String,
      calories: (json['calories'] as num).toInt(),
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$ActivityEntityImplToJson(
        _$ActivityEntityImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'calories': instance.calories,
      'duration': instance.duration.inMicroseconds,
      'date': instance.date.toIso8601String(),
    };

_$WeightEntityImpl _$$WeightEntityImplFromJson(Map<String, dynamic> json) =>
    _$WeightEntityImpl(
      weight: (json['weight'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$WeightEntityImplToJson(_$WeightEntityImpl instance) =>
    <String, dynamic>{
      'weight': instance.weight,
      'date': instance.date.toIso8601String(),
    };
