// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_nutritional_threshold_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserNutritionalThreshold _$UserNutritionalThresholdFromJson(
    Map<String, dynamic> json) {
  return _UserNutritionalThreshold.fromJson(json);
}

/// @nodoc
mixin _$UserNutritionalThreshold {
  String get nutrient => throw _privateConstructorUsedError;
  double? get minAmount => throw _privateConstructorUsedError;
  double? get maxAmount => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserNutritionalThresholdCopyWith<UserNutritionalThreshold> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserNutritionalThresholdCopyWith<$Res> {
  factory $UserNutritionalThresholdCopyWith(UserNutritionalThreshold value,
          $Res Function(UserNutritionalThreshold) then) =
      _$UserNutritionalThresholdCopyWithImpl<$Res, UserNutritionalThreshold>;
  @useResult
  $Res call(
      {String nutrient, double? minAmount, double? maxAmount, String unit});
}

/// @nodoc
class _$UserNutritionalThresholdCopyWithImpl<$Res,
        $Val extends UserNutritionalThreshold>
    implements $UserNutritionalThresholdCopyWith<$Res> {
  _$UserNutritionalThresholdCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nutrient = null,
    Object? minAmount = freezed,
    Object? maxAmount = freezed,
    Object? unit = null,
  }) {
    return _then(_value.copyWith(
      nutrient: null == nutrient
          ? _value.nutrient
          : nutrient // ignore: cast_nullable_to_non_nullable
              as String,
      minAmount: freezed == minAmount
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      maxAmount: freezed == maxAmount
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserNutritionalThresholdImplCopyWith<$Res>
    implements $UserNutritionalThresholdCopyWith<$Res> {
  factory _$$UserNutritionalThresholdImplCopyWith(
          _$UserNutritionalThresholdImpl value,
          $Res Function(_$UserNutritionalThresholdImpl) then) =
      __$$UserNutritionalThresholdImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String nutrient, double? minAmount, double? maxAmount, String unit});
}

/// @nodoc
class __$$UserNutritionalThresholdImplCopyWithImpl<$Res>
    extends _$UserNutritionalThresholdCopyWithImpl<$Res,
        _$UserNutritionalThresholdImpl>
    implements _$$UserNutritionalThresholdImplCopyWith<$Res> {
  __$$UserNutritionalThresholdImplCopyWithImpl(
      _$UserNutritionalThresholdImpl _value,
      $Res Function(_$UserNutritionalThresholdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nutrient = null,
    Object? minAmount = freezed,
    Object? maxAmount = freezed,
    Object? unit = null,
  }) {
    return _then(_$UserNutritionalThresholdImpl(
      nutrient: null == nutrient
          ? _value.nutrient
          : nutrient // ignore: cast_nullable_to_non_nullable
              as String,
      minAmount: freezed == minAmount
          ? _value.minAmount
          : minAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      maxAmount: freezed == maxAmount
          ? _value.maxAmount
          : maxAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserNutritionalThresholdImpl implements _UserNutritionalThreshold {
  const _$UserNutritionalThresholdImpl(
      {required this.nutrient,
      this.minAmount,
      this.maxAmount,
      this.unit = 'g'});

  factory _$UserNutritionalThresholdImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserNutritionalThresholdImplFromJson(json);

  @override
  final String nutrient;
  @override
  final double? minAmount;
  @override
  final double? maxAmount;
  @override
  @JsonKey()
  final String unit;

  @override
  String toString() {
    return 'UserNutritionalThreshold(nutrient: $nutrient, minAmount: $minAmount, maxAmount: $maxAmount, unit: $unit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserNutritionalThresholdImpl &&
            (identical(other.nutrient, nutrient) ||
                other.nutrient == nutrient) &&
            (identical(other.minAmount, minAmount) ||
                other.minAmount == minAmount) &&
            (identical(other.maxAmount, maxAmount) ||
                other.maxAmount == maxAmount) &&
            (identical(other.unit, unit) || other.unit == unit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, nutrient, minAmount, maxAmount, unit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserNutritionalThresholdImplCopyWith<_$UserNutritionalThresholdImpl>
      get copyWith => __$$UserNutritionalThresholdImplCopyWithImpl<
          _$UserNutritionalThresholdImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserNutritionalThresholdImplToJson(
      this,
    );
  }
}

abstract class _UserNutritionalThreshold implements UserNutritionalThreshold {
  const factory _UserNutritionalThreshold(
      {required final String nutrient,
      final double? minAmount,
      final double? maxAmount,
      final String unit}) = _$UserNutritionalThresholdImpl;

  factory _UserNutritionalThreshold.fromJson(Map<String, dynamic> json) =
      _$UserNutritionalThresholdImpl.fromJson;

  @override
  String get nutrient;
  @override
  double? get minAmount;
  @override
  double? get maxAmount;
  @override
  String get unit;
  @override
  @JsonKey(ignore: true)
  _$$UserNutritionalThresholdImplCopyWith<_$UserNutritionalThresholdImpl>
      get copyWith => throw _privateConstructorUsedError;
}
