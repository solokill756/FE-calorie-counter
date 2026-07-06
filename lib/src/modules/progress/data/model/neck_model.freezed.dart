// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'neck_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NeckModel _$NeckModelFromJson(Map<String, dynamic> json) {
  return _NeckModel.fromJson(json);
}

/// @nodoc
mixin _$NeckModel {
  DateTime get recordedAt => throw _privateConstructorUsedError;
  double get neckCm => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NeckModelCopyWith<NeckModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NeckModelCopyWith<$Res> {
  factory $NeckModelCopyWith(NeckModel value, $Res Function(NeckModel) then) =
      _$NeckModelCopyWithImpl<$Res, NeckModel>;
  @useResult
  $Res call({DateTime recordedAt, double neckCm, int? id});
}

/// @nodoc
class _$NeckModelCopyWithImpl<$Res, $Val extends NeckModel>
    implements $NeckModelCopyWith<$Res> {
  _$NeckModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recordedAt = null,
    Object? neckCm = null,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      neckCm: null == neckCm
          ? _value.neckCm
          : neckCm // ignore: cast_nullable_to_non_nullable
              as double,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NeckModelImplCopyWith<$Res>
    implements $NeckModelCopyWith<$Res> {
  factory _$$NeckModelImplCopyWith(
          _$NeckModelImpl value, $Res Function(_$NeckModelImpl) then) =
      __$$NeckModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime recordedAt, double neckCm, int? id});
}

/// @nodoc
class __$$NeckModelImplCopyWithImpl<$Res>
    extends _$NeckModelCopyWithImpl<$Res, _$NeckModelImpl>
    implements _$$NeckModelImplCopyWith<$Res> {
  __$$NeckModelImplCopyWithImpl(
      _$NeckModelImpl _value, $Res Function(_$NeckModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recordedAt = null,
    Object? neckCm = null,
    Object? id = freezed,
  }) {
    return _then(_$NeckModelImpl(
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      neckCm: null == neckCm
          ? _value.neckCm
          : neckCm // ignore: cast_nullable_to_non_nullable
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
class _$NeckModelImpl implements _NeckModel {
  const _$NeckModelImpl(
      {required this.recordedAt, required this.neckCm, this.id});

  factory _$NeckModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NeckModelImplFromJson(json);

  @override
  final DateTime recordedAt;
  @override
  final double neckCm;
  @override
  final int? id;

  @override
  String toString() {
    return 'NeckModel(recordedAt: $recordedAt, neckCm: $neckCm, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NeckModelImpl &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt) &&
            (identical(other.neckCm, neckCm) || other.neckCm == neckCm) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, recordedAt, neckCm, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NeckModelImplCopyWith<_$NeckModelImpl> get copyWith =>
      __$$NeckModelImplCopyWithImpl<_$NeckModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NeckModelImplToJson(
      this,
    );
  }
}

abstract class _NeckModel implements NeckModel {
  const factory _NeckModel(
      {required final DateTime recordedAt,
      required final double neckCm,
      final int? id}) = _$NeckModelImpl;

  factory _NeckModel.fromJson(Map<String, dynamic> json) =
      _$NeckModelImpl.fromJson;

  @override
  DateTime get recordedAt;
  @override
  double get neckCm;
  @override
  int? get id;
  @override
  @JsonKey(ignore: true)
  _$$NeckModelImplCopyWith<_$NeckModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
