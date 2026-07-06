// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddEntity _$AddEntityFromJson(Map<String, dynamic> json) {
  return _AddEntity.fromJson(json);
}

/// @nodoc
mixin _$AddEntity {
  String get id => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  String get unit => throw _privateConstructorUsedError;
  DateTime? get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddEntityCopyWith<AddEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddEntityCopyWith<$Res> {
  factory $AddEntityCopyWith(AddEntity value, $Res Function(AddEntity) then) =
      _$AddEntityCopyWithImpl<$Res, AddEntity>;
  @useResult
  $Res call(
      {String id,
      String type,
      String name,
      double value,
      String unit,
      DateTime? timestamp});
}

/// @nodoc
class _$AddEntityCopyWithImpl<$Res, $Val extends AddEntity>
    implements $AddEntityCopyWith<$Res> {
  _$AddEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? value = null,
    Object? unit = null,
    Object? timestamp = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddEntityImplCopyWith<$Res>
    implements $AddEntityCopyWith<$Res> {
  factory _$$AddEntityImplCopyWith(
          _$AddEntityImpl value, $Res Function(_$AddEntityImpl) then) =
      __$$AddEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String type,
      String name,
      double value,
      String unit,
      DateTime? timestamp});
}

/// @nodoc
class __$$AddEntityImplCopyWithImpl<$Res>
    extends _$AddEntityCopyWithImpl<$Res, _$AddEntityImpl>
    implements _$$AddEntityImplCopyWith<$Res> {
  __$$AddEntityImplCopyWithImpl(
      _$AddEntityImpl _value, $Res Function(_$AddEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? name = null,
    Object? value = null,
    Object? unit = null,
    Object? timestamp = freezed,
  }) {
    return _then(_$AddEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddEntityImpl implements _AddEntity {
  const _$AddEntityImpl(
      {this.id = '',
      this.type = '',
      this.name = '',
      this.value = 0.0,
      this.unit = '',
      this.timestamp});

  factory _$AddEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddEntityImplFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String type;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final double value;
  @override
  @JsonKey()
  final String unit;
  @override
  final DateTime? timestamp;

  @override
  String toString() {
    return 'AddEntity(id: $id, type: $type, name: $name, value: $value, unit: $unit, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, name, value, unit, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddEntityImplCopyWith<_$AddEntityImpl> get copyWith =>
      __$$AddEntityImplCopyWithImpl<_$AddEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddEntityImplToJson(
      this,
    );
  }
}

abstract class _AddEntity implements AddEntity {
  const factory _AddEntity(
      {final String id,
      final String type,
      final String name,
      final double value,
      final String unit,
      final DateTime? timestamp}) = _$AddEntityImpl;

  factory _AddEntity.fromJson(Map<String, dynamic> json) =
      _$AddEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get type;
  @override
  String get name;
  @override
  double get value;
  @override
  String get unit;
  @override
  DateTime? get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$AddEntityImplCopyWith<_$AddEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
