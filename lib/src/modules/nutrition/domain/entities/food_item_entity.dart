import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_item_entity.freezed.dart';

@freezed
class FoodItemEntity with _$FoodItemEntity {
  const factory FoodItemEntity({required String name, required double total}) =
      _FoodItemEntity;
}
