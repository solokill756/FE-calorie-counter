// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiaryEntityImpl _$$DiaryEntityImplFromJson(Map<String, dynamic> json) =>
    _$DiaryEntityImpl(
      date: DateTime.parse(json['date'] as String),
      caloriesGoal: (json['caloriesGoal'] as num).toInt(),
      caloriesConsumed: (json['caloriesConsumed'] as num).toInt(),
      caloriesBurned: (json['caloriesBurned'] as num).toInt(),
      carbsConsumed: (json['carbsConsumed'] as num).toDouble(),
      proteinConsumed: (json['proteinConsumed'] as num).toDouble(),
      fatConsumed: (json['fatConsumed'] as num).toDouble(),
      sodiumConsumedMg: (json['sodiumConsumedMg'] as num?)?.toDouble() ?? 0.0,
      fiberConsumedG: (json['fiberConsumedG'] as num?)?.toDouble() ?? 0.0,
      sugarConsumedG: (json['sugarConsumedG'] as num?)?.toDouble() ?? 0.0,
      saturatedFatConsumedG:
          (json['saturatedFatConsumedG'] as num?)?.toDouble() ?? 0.0,
      cholesterolConsumedMg:
          (json['cholesterolConsumedMg'] as num?)?.toDouble() ?? 0.0,
      potassiumConsumedMg:
          (json['potassiumConsumedMg'] as num?)?.toDouble() ?? 0.0,
      totalCalciumMg: (json['totalCalciumMg'] as num?)?.toDouble() ?? 0.0,
      totalIronMg: (json['totalIronMg'] as num?)?.toDouble() ?? 0.0,
      totalMagnesiumMg: (json['totalMagnesiumMg'] as num?)?.toDouble() ?? 0.0,
      totalPhosphorusMg: (json['totalPhosphorusMg'] as num?)?.toDouble() ?? 0.0,
      totalZincMg: (json['totalZincMg'] as num?)?.toDouble() ?? 0.0,
      totalVitaminAUg: (json['totalVitaminAUg'] as num?)?.toDouble() ?? 0.0,
      totalVitaminCMg: (json['totalVitaminCMg'] as num?)?.toDouble() ?? 0.0,
      totalVitaminDUg: (json['totalVitaminDUg'] as num?)?.toDouble() ?? 0.0,
      totalVitaminEMg: (json['totalVitaminEMg'] as num?)?.toDouble() ?? 0.0,
      totalVitaminKUg: (json['totalVitaminKUg'] as num?)?.toDouble() ?? 0.0,
      totalVitaminB6Mg: (json['totalVitaminB6Mg'] as num?)?.toDouble() ?? 0.0,
      totalVitaminB12Ug: (json['totalVitaminB12Ug'] as num?)?.toDouble() ?? 0.0,
      totalFolateDfeUg: (json['totalFolateDfeUg'] as num?)?.toDouble() ?? 0.0,
      breakfast: (json['breakfast'] as List<dynamic>)
          .map((e) => FoodEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      lunch: (json['lunch'] as List<dynamic>)
          .map((e) => FoodEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      dinner: (json['dinner'] as List<dynamic>)
          .map((e) => FoodEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      snacks: (json['snacks'] as List<dynamic>)
          .map((e) => FoodEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => ExerciseEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      waterGlasses: (json['waterGlasses'] as num).toInt(),
      waterAmountMl: (json['waterAmountMl'] as num?)?.toInt() ?? 0,
      waterTargetMl: (json['waterTargetMl'] as num?)?.toInt() ?? 2500,
      isFasting: json['isFasting'] as bool,
      isCompleted: json['isCompleted'] as bool? ?? false,
      note: json['note'] as String?,
      fastingStartTime: json['fastingStartTime'] == null
          ? null
          : DateTime.parse(json['fastingStartTime'] as String),
      fastingEndTime: json['fastingEndTime'] == null
          ? null
          : DateTime.parse(json['fastingEndTime'] as String),
    );

Map<String, dynamic> _$$DiaryEntityImplToJson(_$DiaryEntityImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'caloriesGoal': instance.caloriesGoal,
      'caloriesConsumed': instance.caloriesConsumed,
      'caloriesBurned': instance.caloriesBurned,
      'carbsConsumed': instance.carbsConsumed,
      'proteinConsumed': instance.proteinConsumed,
      'fatConsumed': instance.fatConsumed,
      'sodiumConsumedMg': instance.sodiumConsumedMg,
      'fiberConsumedG': instance.fiberConsumedG,
      'sugarConsumedG': instance.sugarConsumedG,
      'saturatedFatConsumedG': instance.saturatedFatConsumedG,
      'cholesterolConsumedMg': instance.cholesterolConsumedMg,
      'potassiumConsumedMg': instance.potassiumConsumedMg,
      'totalCalciumMg': instance.totalCalciumMg,
      'totalIronMg': instance.totalIronMg,
      'totalMagnesiumMg': instance.totalMagnesiumMg,
      'totalPhosphorusMg': instance.totalPhosphorusMg,
      'totalZincMg': instance.totalZincMg,
      'totalVitaminAUg': instance.totalVitaminAUg,
      'totalVitaminCMg': instance.totalVitaminCMg,
      'totalVitaminDUg': instance.totalVitaminDUg,
      'totalVitaminEMg': instance.totalVitaminEMg,
      'totalVitaminKUg': instance.totalVitaminKUg,
      'totalVitaminB6Mg': instance.totalVitaminB6Mg,
      'totalVitaminB12Ug': instance.totalVitaminB12Ug,
      'totalFolateDfeUg': instance.totalFolateDfeUg,
      'breakfast': instance.breakfast.map((e) => e.toJson()).toList(),
      'lunch': instance.lunch.map((e) => e.toJson()).toList(),
      'dinner': instance.dinner.map((e) => e.toJson()).toList(),
      'snacks': instance.snacks.map((e) => e.toJson()).toList(),
      'exercises': instance.exercises.map((e) => e.toJson()).toList(),
      'waterGlasses': instance.waterGlasses,
      'waterAmountMl': instance.waterAmountMl,
      'waterTargetMl': instance.waterTargetMl,
      'isFasting': instance.isFasting,
      'isCompleted': instance.isCompleted,
      'note': instance.note,
      'fastingStartTime': instance.fastingStartTime?.toIso8601String(),
      'fastingEndTime': instance.fastingEndTime?.toIso8601String(),
    };

_$FoodEntryImpl _$$FoodEntryImplFromJson(Map<String, dynamic> json) =>
    _$FoodEntryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      calories: (json['calories'] as num).toInt(),
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String,
      carbs: (json['carbs'] as num?)?.toDouble() ?? 0.0,
      protein: (json['protein'] as num?)?.toDouble() ?? 0.0,
      fat: (json['fat'] as num?)?.toDouble() ?? 0.0,
      sodiumMg: (json['sodiumMg'] as num?)?.toDouble() ?? 0.0,
      fiberG: (json['fiberG'] as num?)?.toDouble() ?? 0.0,
      sugarG: (json['sugarG'] as num?)?.toDouble() ?? 0.0,
      saturatedFatG: (json['saturatedFatG'] as num?)?.toDouble() ?? 0.0,
      cholesterolMg: (json['cholesterolMg'] as num?)?.toDouble() ?? 0.0,
      potassiumMg: (json['potassiumMg'] as num?)?.toDouble() ?? 0.0,
      calciumMg: (json['calciumMg'] as num?)?.toDouble() ?? 0.0,
      ironMg: (json['ironMg'] as num?)?.toDouble() ?? 0.0,
      magnesiumMg: (json['magnesiumMg'] as num?)?.toDouble() ?? 0.0,
      phosphorusMg: (json['phosphorusMg'] as num?)?.toDouble() ?? 0.0,
      zincMg: (json['zincMg'] as num?)?.toDouble() ?? 0.0,
      vitaminAUg: (json['vitaminAUg'] as num?)?.toDouble() ?? 0.0,
      vitaminCMg: (json['vitaminCMg'] as num?)?.toDouble() ?? 0.0,
      vitaminDUg: (json['vitaminDUg'] as num?)?.toDouble() ?? 0.0,
      vitaminEMg: (json['vitaminEMg'] as num?)?.toDouble() ?? 0.0,
      vitaminKUg: (json['vitaminKUg'] as num?)?.toDouble() ?? 0.0,
      vitaminB6Mg: (json['vitaminB6Mg'] as num?)?.toDouble() ?? 0.0,
      vitaminB12Ug: (json['vitaminB12Ug'] as num?)?.toDouble() ?? 0.0,
      folateDfeUg: (json['folateDfeUg'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$FoodEntryImplToJson(_$FoodEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'calories': instance.calories,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'carbs': instance.carbs,
      'protein': instance.protein,
      'fat': instance.fat,
      'sodiumMg': instance.sodiumMg,
      'fiberG': instance.fiberG,
      'sugarG': instance.sugarG,
      'saturatedFatG': instance.saturatedFatG,
      'cholesterolMg': instance.cholesterolMg,
      'potassiumMg': instance.potassiumMg,
      'calciumMg': instance.calciumMg,
      'ironMg': instance.ironMg,
      'magnesiumMg': instance.magnesiumMg,
      'phosphorusMg': instance.phosphorusMg,
      'zincMg': instance.zincMg,
      'vitaminAUg': instance.vitaminAUg,
      'vitaminCMg': instance.vitaminCMg,
      'vitaminDUg': instance.vitaminDUg,
      'vitaminEMg': instance.vitaminEMg,
      'vitaminKUg': instance.vitaminKUg,
      'vitaminB6Mg': instance.vitaminB6Mg,
      'vitaminB12Ug': instance.vitaminB12Ug,
      'folateDfeUg': instance.folateDfeUg,
    };

_$ExerciseEntryImpl _$$ExerciseEntryImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseEntryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      caloriesBurned: (json['caloriesBurned'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
    );

Map<String, dynamic> _$$ExerciseEntryImplToJson(_$ExerciseEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'caloriesBurned': instance.caloriesBurned,
      'duration': instance.duration,
    };
