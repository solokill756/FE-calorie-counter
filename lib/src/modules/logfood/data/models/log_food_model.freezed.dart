// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'log_food_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LogFoodModel _$LogFoodModelFromJson(Map<String, dynamic> json) {
  return _LogFoodModel.fromJson(json);
}

/// @nodoc
mixin _$LogFoodModel {
  String? get brandName => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  String get nameFood => throw _privateConstructorUsedError;
  Map<String, dynamic> get nutrients => throw _privateConstructorUsedError;
  Map<String, dynamic> get serving => throw _privateConstructorUsedError;
  String get slot => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  DateTime get time => throw _privateConstructorUsedError;
  int get foodId => throw _privateConstructorUsedError;
  FoodModel get food => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LogFoodModelCopyWith<LogFoodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogFoodModelCopyWith<$Res> {
  factory $LogFoodModelCopyWith(
          LogFoodModel value, $Res Function(LogFoodModel) then) =
      _$LogFoodModelCopyWithImpl<$Res, LogFoodModel>;
  @useResult
  $Res call(
      {String? brandName,
      int? id,
      String nameFood,
      Map<String, dynamic> nutrients,
      Map<String, dynamic> serving,
      String slot,
      String source,
      DateTime time,
      int foodId,
      FoodModel food});

  $FoodModelCopyWith<$Res> get food;
}

/// @nodoc
class _$LogFoodModelCopyWithImpl<$Res, $Val extends LogFoodModel>
    implements $LogFoodModelCopyWith<$Res> {
  _$LogFoodModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandName = freezed,
    Object? id = freezed,
    Object? nameFood = null,
    Object? nutrients = null,
    Object? serving = null,
    Object? slot = null,
    Object? source = null,
    Object? time = null,
    Object? foodId = null,
    Object? food = null,
  }) {
    return _then(_value.copyWith(
      brandName: freezed == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      nameFood: null == nameFood
          ? _value.nameFood
          : nameFood // ignore: cast_nullable_to_non_nullable
              as String,
      nutrients: null == nutrients
          ? _value.nutrients
          : nutrients // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      serving: null == serving
          ? _value.serving
          : serving // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      foodId: null == foodId
          ? _value.foodId
          : foodId // ignore: cast_nullable_to_non_nullable
              as int,
      food: null == food
          ? _value.food
          : food // ignore: cast_nullable_to_non_nullable
              as FoodModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FoodModelCopyWith<$Res> get food {
    return $FoodModelCopyWith<$Res>(_value.food, (value) {
      return _then(_value.copyWith(food: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LogFoodModelImplCopyWith<$Res>
    implements $LogFoodModelCopyWith<$Res> {
  factory _$$LogFoodModelImplCopyWith(
          _$LogFoodModelImpl value, $Res Function(_$LogFoodModelImpl) then) =
      __$$LogFoodModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? brandName,
      int? id,
      String nameFood,
      Map<String, dynamic> nutrients,
      Map<String, dynamic> serving,
      String slot,
      String source,
      DateTime time,
      int foodId,
      FoodModel food});

  @override
  $FoodModelCopyWith<$Res> get food;
}

/// @nodoc
class __$$LogFoodModelImplCopyWithImpl<$Res>
    extends _$LogFoodModelCopyWithImpl<$Res, _$LogFoodModelImpl>
    implements _$$LogFoodModelImplCopyWith<$Res> {
  __$$LogFoodModelImplCopyWithImpl(
      _$LogFoodModelImpl _value, $Res Function(_$LogFoodModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brandName = freezed,
    Object? id = freezed,
    Object? nameFood = null,
    Object? nutrients = null,
    Object? serving = null,
    Object? slot = null,
    Object? source = null,
    Object? time = null,
    Object? foodId = null,
    Object? food = null,
  }) {
    return _then(_$LogFoodModelImpl(
      brandName: freezed == brandName
          ? _value.brandName
          : brandName // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      nameFood: null == nameFood
          ? _value.nameFood
          : nameFood // ignore: cast_nullable_to_non_nullable
              as String,
      nutrients: null == nutrients
          ? _value._nutrients
          : nutrients // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      serving: null == serving
          ? _value._serving
          : serving // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      slot: null == slot
          ? _value.slot
          : slot // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      foodId: null == foodId
          ? _value.foodId
          : foodId // ignore: cast_nullable_to_non_nullable
              as int,
      food: null == food
          ? _value.food
          : food // ignore: cast_nullable_to_non_nullable
              as FoodModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LogFoodModelImpl extends _LogFoodModel {
  const _$LogFoodModelImpl(
      {this.brandName,
      this.id,
      required this.nameFood,
      required final Map<String, dynamic> nutrients,
      required final Map<String, dynamic> serving,
      required this.slot,
      required this.source,
      required this.time,
      required this.foodId,
      required this.food})
      : _nutrients = nutrients,
        _serving = serving,
        super._();

  factory _$LogFoodModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LogFoodModelImplFromJson(json);

  @override
  final String? brandName;
  @override
  final int? id;
  @override
  final String nameFood;
  final Map<String, dynamic> _nutrients;
  @override
  Map<String, dynamic> get nutrients {
    if (_nutrients is EqualUnmodifiableMapView) return _nutrients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_nutrients);
  }

  final Map<String, dynamic> _serving;
  @override
  Map<String, dynamic> get serving {
    if (_serving is EqualUnmodifiableMapView) return _serving;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_serving);
  }

  @override
  final String slot;
  @override
  final String source;
  @override
  final DateTime time;
  @override
  final int foodId;
  @override
  final FoodModel food;

  @override
  String toString() {
    return 'LogFoodModel(brandName: $brandName, id: $id, nameFood: $nameFood, nutrients: $nutrients, serving: $serving, slot: $slot, source: $source, time: $time, foodId: $foodId, food: $food)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogFoodModelImpl &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nameFood, nameFood) ||
                other.nameFood == nameFood) &&
            const DeepCollectionEquality()
                .equals(other._nutrients, _nutrients) &&
            const DeepCollectionEquality().equals(other._serving, _serving) &&
            (identical(other.slot, slot) || other.slot == slot) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.foodId, foodId) || other.foodId == foodId) &&
            (identical(other.food, food) || other.food == food));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      brandName,
      id,
      nameFood,
      const DeepCollectionEquality().hash(_nutrients),
      const DeepCollectionEquality().hash(_serving),
      slot,
      source,
      time,
      foodId,
      food);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LogFoodModelImplCopyWith<_$LogFoodModelImpl> get copyWith =>
      __$$LogFoodModelImplCopyWithImpl<_$LogFoodModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LogFoodModelImplToJson(
      this,
    );
  }
}

abstract class _LogFoodModel extends LogFoodModel {
  const factory _LogFoodModel(
      {final String? brandName,
      final int? id,
      required final String nameFood,
      required final Map<String, dynamic> nutrients,
      required final Map<String, dynamic> serving,
      required final String slot,
      required final String source,
      required final DateTime time,
      required final int foodId,
      required final FoodModel food}) = _$LogFoodModelImpl;
  const _LogFoodModel._() : super._();

  factory _LogFoodModel.fromJson(Map<String, dynamic> json) =
      _$LogFoodModelImpl.fromJson;

  @override
  String? get brandName;
  @override
  int? get id;
  @override
  String get nameFood;
  @override
  Map<String, dynamic> get nutrients;
  @override
  Map<String, dynamic> get serving;
  @override
  String get slot;
  @override
  String get source;
  @override
  DateTime get time;
  @override
  int get foodId;
  @override
  FoodModel get food;
  @override
  @JsonKey(ignore: true)
  _$$LogFoodModelImplCopyWith<_$LogFoodModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
