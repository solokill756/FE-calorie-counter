// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'waist_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WaistModel _$WaistModelFromJson(Map<String, dynamic> json) {
  return _WaistModel.fromJson(json);
}

/// @nodoc
mixin _$WaistModel {
  DateTime get recordedAt => throw _privateConstructorUsedError;
  double get waistCm => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WaistModelCopyWith<WaistModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaistModelCopyWith<$Res> {
  factory $WaistModelCopyWith(
          WaistModel value, $Res Function(WaistModel) then) =
      _$WaistModelCopyWithImpl<$Res, WaistModel>;
  @useResult
  $Res call({DateTime recordedAt, double waistCm, int? id});
}

/// @nodoc
class _$WaistModelCopyWithImpl<$Res, $Val extends WaistModel>
    implements $WaistModelCopyWith<$Res> {
  _$WaistModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recordedAt = null,
    Object? waistCm = null,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      waistCm: null == waistCm
          ? _value.waistCm
          : waistCm // ignore: cast_nullable_to_non_nullable
              as double,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WaistModelImplCopyWith<$Res>
    implements $WaistModelCopyWith<$Res> {
  factory _$$WaistModelImplCopyWith(
          _$WaistModelImpl value, $Res Function(_$WaistModelImpl) then) =
      __$$WaistModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime recordedAt, double waistCm, int? id});
}

/// @nodoc
class __$$WaistModelImplCopyWithImpl<$Res>
    extends _$WaistModelCopyWithImpl<$Res, _$WaistModelImpl>
    implements _$$WaistModelImplCopyWith<$Res> {
  __$$WaistModelImplCopyWithImpl(
      _$WaistModelImpl _value, $Res Function(_$WaistModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recordedAt = null,
    Object? waistCm = null,
    Object? id = freezed,
  }) {
    return _then(_$WaistModelImpl(
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      waistCm: null == waistCm
          ? _value.waistCm
          : waistCm // ignore: cast_nullable_to_non_nullable
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
class _$WaistModelImpl implements _WaistModel {
  const _$WaistModelImpl(
      {required this.recordedAt, required this.waistCm, this.id});

  factory _$WaistModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WaistModelImplFromJson(json);

  @override
  final DateTime recordedAt;
  @override
  final double waistCm;
  @override
  final int? id;

  @override
  String toString() {
    return 'WaistModel(recordedAt: $recordedAt, waistCm: $waistCm, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaistModelImpl &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt) &&
            (identical(other.waistCm, waistCm) || other.waistCm == waistCm) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, recordedAt, waistCm, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WaistModelImplCopyWith<_$WaistModelImpl> get copyWith =>
      __$$WaistModelImplCopyWithImpl<_$WaistModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WaistModelImplToJson(
      this,
    );
  }
}

abstract class _WaistModel implements WaistModel {
  const factory _WaistModel(
      {required final DateTime recordedAt,
      required final double waistCm,
      final int? id}) = _$WaistModelImpl;

  factory _WaistModel.fromJson(Map<String, dynamic> json) =
      _$WaistModelImpl.fromJson;

  @override
  DateTime get recordedAt;
  @override
  double get waistCm;
  @override
  int? get id;
  @override
  @JsonKey(ignore: true)
  _$$WaistModelImplCopyWith<_$WaistModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
