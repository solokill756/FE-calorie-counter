// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodModelImpl _$$FoodModelImplFromJson(Map<String, dynamic> json) =>
    _$FoodModelImpl(
      name: json['name'] as String,
      servingPerContainer: (json['servingPerContainer'] as num).toDouble(),
      units: (json['units'] as List<dynamic>).map((e) => e as String).toList(),
      unitSizes: (json['unitSizes'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      unitShowIndex: (json['unitShowIndex'] as num).toInt(),
      quantity: (json['quantity'] as num).toDouble(),
      id: (json['id'] as num?)?.toInt(),
      mealTemplateId: (json['mealTemplateId'] as num?)?.toInt(),
      brand: json['brand'] as String?,
      description: json['description'] as String?,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      loggedAt: json['loggedAt'] == null
          ? null
          : DateTime.parse(json['loggedAt'] as String),
      isVerified: json['isVerified'] as bool? ?? false,
      nutrients: (json['nutrients'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      baseNutrients: (json['baseNutrients'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
    );

Map<String, dynamic> _$$FoodModelImplToJson(_$FoodModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'servingPerContainer': instance.servingPerContainer,
      'units': instance.units,
      'unitSizes': instance.unitSizes,
      'unitShowIndex': instance.unitShowIndex,
      'quantity': instance.quantity,
      'id': instance.id,
      'mealTemplateId': instance.mealTemplateId,
      'brand': instance.brand,
      'description': instance.description,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt?.toIso8601String(),
      'loggedAt': instance.loggedAt?.toIso8601String(),
      'isVerified': instance.isVerified,
      'nutrients': instance.nutrients,
      'baseNutrients': instance.baseNutrients,
    };
