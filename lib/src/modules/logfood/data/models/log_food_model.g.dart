// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LogFoodModelImpl _$$LogFoodModelImplFromJson(Map<String, dynamic> json) =>
    _$LogFoodModelImpl(
      brandName: json['brandName'] as String?,
      id: (json['id'] as num?)?.toInt(),
      nameFood: json['nameFood'] as String,
      nutrients: json['nutrients'] as Map<String, dynamic>,
      serving: json['serving'] as Map<String, dynamic>,
      slot: json['slot'] as String,
      source: json['source'] as String,
      time: DateTime.parse(json['time'] as String),
      foodId: (json['foodId'] as num).toInt(),
      food: FoodModel.fromJson(json['food'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$LogFoodModelImplToJson(_$LogFoodModelImpl instance) =>
    <String, dynamic>{
      'brandName': instance.brandName,
      'id': instance.id,
      'nameFood': instance.nameFood,
      'nutrients': instance.nutrients,
      'serving': instance.serving,
      'slot': instance.slot,
      'source': instance.source,
      'time': instance.time.toIso8601String(),
      'foodId': instance.foodId,
      'food': instance.food.toJson(),
    };
