// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_progress_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProgressEntry _$UserProgressEntryFromJson(Map<String, dynamic> json) {
  return _UserProgressEntry.fromJson(json);
}

/// @nodoc
mixin _$UserProgressEntry {
  int get steaksConsumed => throw _privateConstructorUsedError;
  WeightFormModel get weight => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserProgressEntryCopyWith<UserProgressEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProgressEntryCopyWith<$Res> {
  factory $UserProgressEntryCopyWith(
          UserProgressEntry value, $Res Function(UserProgressEntry) then) =
      _$UserProgressEntryCopyWithImpl<$Res, UserProgressEntry>;
  @useResult
  $Res call({int steaksConsumed, WeightFormModel weight});

  $WeightFormModelCopyWith<$Res> get weight;
}

/// @nodoc
class _$UserProgressEntryCopyWithImpl<$Res, $Val extends UserProgressEntry>
    implements $UserProgressEntryCopyWith<$Res> {
  _$UserProgressEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steaksConsumed = null,
    Object? weight = null,
  }) {
    return _then(_value.copyWith(
      steaksConsumed: null == steaksConsumed
          ? _value.steaksConsumed
          : steaksConsumed // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as WeightFormModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $WeightFormModelCopyWith<$Res> get weight {
    return $WeightFormModelCopyWith<$Res>(_value.weight, (value) {
      return _then(_value.copyWith(weight: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProgressEntryImplCopyWith<$Res>
    implements $UserProgressEntryCopyWith<$Res> {
  factory _$$UserProgressEntryImplCopyWith(_$UserProgressEntryImpl value,
          $Res Function(_$UserProgressEntryImpl) then) =
      __$$UserProgressEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int steaksConsumed, WeightFormModel weight});

  @override
  $WeightFormModelCopyWith<$Res> get weight;
}

/// @nodoc
class __$$UserProgressEntryImplCopyWithImpl<$Res>
    extends _$UserProgressEntryCopyWithImpl<$Res, _$UserProgressEntryImpl>
    implements _$$UserProgressEntryImplCopyWith<$Res> {
  __$$UserProgressEntryImplCopyWithImpl(_$UserProgressEntryImpl _value,
      $Res Function(_$UserProgressEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? steaksConsumed = null,
    Object? weight = null,
  }) {
    return _then(_$UserProgressEntryImpl(
      steaksConsumed: null == steaksConsumed
          ? _value.steaksConsumed
          : steaksConsumed // ignore: cast_nullable_to_non_nullable
              as int,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as WeightFormModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProgressEntryImpl implements _UserProgressEntry {
  const _$UserProgressEntryImpl(
      {required this.steaksConsumed, required this.weight});

  factory _$UserProgressEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProgressEntryImplFromJson(json);

  @override
  final int steaksConsumed;
  @override
  final WeightFormModel weight;

  @override
  String toString() {
    return 'UserProgressEntry(steaksConsumed: $steaksConsumed, weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProgressEntryImpl &&
            (identical(other.steaksConsumed, steaksConsumed) ||
                other.steaksConsumed == steaksConsumed) &&
            (identical(other.weight, weight) || other.weight == weight));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, steaksConsumed, weight);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProgressEntryImplCopyWith<_$UserProgressEntryImpl> get copyWith =>
      __$$UserProgressEntryImplCopyWithImpl<_$UserProgressEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProgressEntryImplToJson(
      this,
    );
  }
}

abstract class _UserProgressEntry implements UserProgressEntry {
  const factory _UserProgressEntry(
      {required final int steaksConsumed,
      required final WeightFormModel weight}) = _$UserProgressEntryImpl;

  factory _UserProgressEntry.fromJson(Map<String, dynamic> json) =
      _$UserProgressEntryImpl.fromJson;

  @override
  int get steaksConsumed;
  @override
  WeightFormModel get weight;
  @override
  @JsonKey(ignore: true)
  _$$UserProgressEntryImplCopyWith<_$UserProgressEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
