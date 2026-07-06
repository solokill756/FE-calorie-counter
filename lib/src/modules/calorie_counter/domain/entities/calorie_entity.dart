import 'package:freezed_annotation/freezed_annotation.dart';

part 'calorie_entity.freezed.dart';
part 'calorie_entity.g.dart';

@freezed
class CalorieEntity with _$CalorieEntity {
  const factory CalorieEntity({
    required int goal,
    required int consumed,
    required int burned,
    required int remaining,
    required DateTime date,
  }) = _CalorieEntity;

  factory CalorieEntity.fromJson(Map<String, dynamic> json) =>
      _$CalorieEntityFromJson(json);
}

@freezed
class MacroEntity with _$MacroEntity {
  const factory MacroEntity({
    required double carbs,
    required double protein,
    required double fat,
    required double fiber,
    required double sugar,
  }) = _MacroEntity;

  factory MacroEntity.fromJson(Map<String, dynamic> json) =>
      _$MacroEntityFromJson(json);
}

@freezed
class ActivityEntity with _$ActivityEntity {
  const factory ActivityEntity({
    required String type,
    required int calories,
    required Duration duration,
    required DateTime date,
  }) = _ActivityEntity;

  factory ActivityEntity.fromJson(Map<String, dynamic> json) =>
      _$ActivityEntityFromJson(json);
}

@freezed
class WeightEntity with _$WeightEntity {
  const factory WeightEntity({
    required double weight,
    required DateTime date,
  }) = _WeightEntity;

  factory WeightEntity.fromJson(Map<String, dynamic> json) =>
      _$WeightEntityFromJson(json);
} 