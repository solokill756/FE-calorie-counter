// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_item_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FoodItemEntity {
  String get name => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FoodItemEntityCopyWith<FoodItemEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodItemEntityCopyWith<$Res> {
  factory $FoodItemEntityCopyWith(
          FoodItemEntity value, $Res Function(FoodItemEntity) then) =
      _$FoodItemEntityCopyWithImpl<$Res, FoodItemEntity>;
  @useResult
  $Res call({String name, double total});
}

/// @nodoc
class _$FoodItemEntityCopyWithImpl<$Res, $Val extends FoodItemEntity>
    implements $FoodItemEntityCopyWith<$Res> {
  _$FoodItemEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? total = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FoodItemEntityImplCopyWith<$Res>
    implements $FoodItemEntityCopyWith<$Res> {
  factory _$$FoodItemEntityImplCopyWith(_$FoodItemEntityImpl value,
          $Res Function(_$FoodItemEntityImpl) then) =
      __$$FoodItemEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, double total});
}

/// @nodoc
class __$$FoodItemEntityImplCopyWithImpl<$Res>
    extends _$FoodItemEntityCopyWithImpl<$Res, _$FoodItemEntityImpl>
    implements _$$FoodItemEntityImplCopyWith<$Res> {
  __$$FoodItemEntityImplCopyWithImpl(
      _$FoodItemEntityImpl _value, $Res Function(_$FoodItemEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? total = null,
  }) {
    return _then(_$FoodItemEntityImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$FoodItemEntityImpl implements _FoodItemEntity {
  const _$FoodItemEntityImpl({required this.name, required this.total});

  @override
  final String name;
  @override
  final double total;

  @override
  String toString() {
    return 'FoodItemEntity(name: $name, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodItemEntityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.total, total) || other.total == total));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, total);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodItemEntityImplCopyWith<_$FoodItemEntityImpl> get copyWith =>
      __$$FoodItemEntityImplCopyWithImpl<_$FoodItemEntityImpl>(
          this, _$identity);
}

abstract class _FoodItemEntity implements FoodItemEntity {
  const factory _FoodItemEntity(
      {required final String name,
      required final double total}) = _$FoodItemEntityImpl;

  @override
  String get name;
  @override
  double get total;
  @override
  @JsonKey(ignore: true)
  _$$FoodItemEntityImplCopyWith<_$FoodItemEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
