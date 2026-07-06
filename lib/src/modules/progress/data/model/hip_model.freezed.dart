// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HipModel _$HipModelFromJson(Map<String, dynamic> json) {
  return _HipModel.fromJson(json);
}

/// @nodoc
mixin _$HipModel {
  DateTime get recordedAt => throw _privateConstructorUsedError;
  double get hipsCm => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HipModelCopyWith<HipModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HipModelCopyWith<$Res> {
  factory $HipModelCopyWith(HipModel value, $Res Function(HipModel) then) =
      _$HipModelCopyWithImpl<$Res, HipModel>;
  @useResult
  $Res call({DateTime recordedAt, double hipsCm, int? id});
}

/// @nodoc
class _$HipModelCopyWithImpl<$Res, $Val extends HipModel>
    implements $HipModelCopyWith<$Res> {
  _$HipModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recordedAt = null,
    Object? hipsCm = null,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hipsCm: null == hipsCm
          ? _value.hipsCm
          : hipsCm // ignore: cast_nullable_to_non_nullable
              as double,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HipModelImplCopyWith<$Res>
    implements $HipModelCopyWith<$Res> {
  factory _$$HipModelImplCopyWith(
          _$HipModelImpl value, $Res Function(_$HipModelImpl) then) =
      __$$HipModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime recordedAt, double hipsCm, int? id});
}

/// @nodoc
class __$$HipModelImplCopyWithImpl<$Res>
    extends _$HipModelCopyWithImpl<$Res, _$HipModelImpl>
    implements _$$HipModelImplCopyWith<$Res> {
  __$$HipModelImplCopyWithImpl(
      _$HipModelImpl _value, $Res Function(_$HipModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recordedAt = null,
    Object? hipsCm = null,
    Object? id = freezed,
  }) {
    return _then(_$HipModelImpl(
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      hipsCm: null == hipsCm
          ? _value.hipsCm
          : hipsCm // ignore: cast_nullable_to_non_nullable
              as double,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HipModelImpl implements _HipModel {
  const _$HipModelImpl(
      {required this.recordedAt, required this.hipsCm, this.id});

  factory _$HipModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HipModelImplFromJson(json);

  @override
  final DateTime recordedAt;
  @override
  final double hipsCm;
  @override
  final int? id;

  @override
  String toString() {
    return 'HipModel(recordedAt: $recordedAt, hipsCm: $hipsCm, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HipModelImpl &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt) &&
            (identical(other.hipsCm, hipsCm) || other.hipsCm == hipsCm) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, recordedAt, hipsCm, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HipModelImplCopyWith<_$HipModelImpl> get copyWith =>
      __$$HipModelImplCopyWithImpl<_$HipModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HipModelImplToJson(
      this,
    );
  }
}

abstract class _HipModel implements HipModel {
  const factory _HipModel(
      {required final DateTime recordedAt,
      required final double hipsCm,
      final int? id}) = _$HipModelImpl;

  factory _HipModel.fromJson(Map<String, dynamic> json) =
      _$HipModelImpl.fromJson;

  @override
  DateTime get recordedAt;
  @override
  double get hipsCm;
  @override
  int? get id;
  @override
  @JsonKey(ignore: true)
  _$$HipModelImplCopyWith<_$HipModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
