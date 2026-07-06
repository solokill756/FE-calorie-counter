// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weightForm_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeightFormModel _$WeightFormModelFromJson(Map<String, dynamic> json) {
  return _WeightFormModel.fromJson(json);
}

/// @nodoc
mixin _$WeightFormModel {
  int? get id => throw _privateConstructorUsedError;
  double get weightKg =>
      throw _privateConstructorUsedError; // Use a JsonConverter to serialize DateTime as ISO8601 string
  @DateTimeIso8601Converter()
  DateTime get recordedAt => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeightFormModelCopyWith<WeightFormModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeightFormModelCopyWith<$Res> {
  factory $WeightFormModelCopyWith(
          WeightFormModel value, $Res Function(WeightFormModel) then) =
      _$WeightFormModelCopyWithImpl<$Res, WeightFormModel>;
  @useResult
  $Res call(
      {int? id,
      double weightKg,
      @DateTimeIso8601Converter() DateTime recordedAt,
      String? photoUrl});
}

/// @nodoc
class _$WeightFormModelCopyWithImpl<$Res, $Val extends WeightFormModel>
    implements $WeightFormModelCopyWith<$Res> {
  _$WeightFormModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? weightKg = null,
    Object? recordedAt = null,
    Object? photoUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      weightKg: null == weightKg
          ? _value.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeightFormModelImplCopyWith<$Res>
    implements $WeightFormModelCopyWith<$Res> {
  factory _$$WeightFormModelImplCopyWith(_$WeightFormModelImpl value,
          $Res Function(_$WeightFormModelImpl) then) =
      __$$WeightFormModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      double weightKg,
      @DateTimeIso8601Converter() DateTime recordedAt,
      String? photoUrl});
}

/// @nodoc
class __$$WeightFormModelImplCopyWithImpl<$Res>
    extends _$WeightFormModelCopyWithImpl<$Res, _$WeightFormModelImpl>
    implements _$$WeightFormModelImplCopyWith<$Res> {
  __$$WeightFormModelImplCopyWithImpl(
      _$WeightFormModelImpl _value, $Res Function(_$WeightFormModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? weightKg = null,
    Object? recordedAt = null,
    Object? photoUrl = freezed,
  }) {
    return _then(_$WeightFormModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      weightKg: null == weightKg
          ? _value.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double,
      recordedAt: null == recordedAt
          ? _value.recordedAt
          : recordedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeightFormModelImpl extends _WeightFormModel {
  const _$WeightFormModelImpl(
      {this.id,
      required this.weightKg,
      @DateTimeIso8601Converter() required this.recordedAt,
      this.photoUrl})
      : super._();

  factory _$WeightFormModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeightFormModelImplFromJson(json);

  @override
  final int? id;
  @override
  final double weightKg;
// Use a JsonConverter to serialize DateTime as ISO8601 string
  @override
  @DateTimeIso8601Converter()
  final DateTime recordedAt;
  @override
  final String? photoUrl;

  @override
  String toString() {
    return 'WeightFormModel(id: $id, weightKg: $weightKg, recordedAt: $recordedAt, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeightFormModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weightKg, weightKg) ||
                other.weightKg == weightKg) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, weightKg, recordedAt, photoUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeightFormModelImplCopyWith<_$WeightFormModelImpl> get copyWith =>
      __$$WeightFormModelImplCopyWithImpl<_$WeightFormModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeightFormModelImplToJson(
      this,
    );
  }
}

abstract class _WeightFormModel extends WeightFormModel {
  const factory _WeightFormModel(
      {final int? id,
      required final double weightKg,
      @DateTimeIso8601Converter() required final DateTime recordedAt,
      final String? photoUrl}) = _$WeightFormModelImpl;
  const _WeightFormModel._() : super._();

  factory _WeightFormModel.fromJson(Map<String, dynamic> json) =
      _$WeightFormModelImpl.fromJson;

  @override
  int? get id;
  @override
  double get weightKg;
  @override // Use a JsonConverter to serialize DateTime as ISO8601 string
  @DateTimeIso8601Converter()
  DateTime get recordedAt;
  @override
  String? get photoUrl;
  @override
  @JsonKey(ignore: true)
  _$$WeightFormModelImplCopyWith<_$WeightFormModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
