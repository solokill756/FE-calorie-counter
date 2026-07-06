// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DiaryState {
  DateTime get selectedDate => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime selectedDate) initial,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        loading,
    required TResult Function(DateTime selectedDate, DiaryEntity diary) loaded,
    required TResult Function(
            DateTime selectedDate, String message, DiaryEntity? diary)
        error,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        removeFoodEntryLoading,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntryError,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntrySuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime selectedDate)? initial,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult? Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult? Function(
            DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime selectedDate)? initial,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult Function(DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DiaryInitial value) initial,
    required TResult Function(DiaryLoading value) loading,
    required TResult Function(DiaryLoaded value) loaded,
    required TResult Function(DiaryError value) error,
    required TResult Function(_DiaryRemoveFoodEntryLoading value)
        removeFoodEntryLoading,
    required TResult Function(DiaryRemoveFoodEntryError value)
        removeFoodEntryError,
    required TResult Function(DiaryRemoveFoodEntrySuccess value)
        removeFoodEntrySuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DiaryInitial value)? initial,
    TResult? Function(DiaryLoading value)? loading,
    TResult? Function(DiaryLoaded value)? loaded,
    TResult? Function(DiaryError value)? error,
    TResult? Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult? Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult? Function(DiaryRemoveFoodEntrySuccess value)?
        removeFoodEntrySuccess,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DiaryInitial value)? initial,
    TResult Function(DiaryLoading value)? loading,
    TResult Function(DiaryLoaded value)? loaded,
    TResult Function(DiaryError value)? error,
    TResult Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult Function(DiaryRemoveFoodEntrySuccess value)? removeFoodEntrySuccess,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DiaryStateCopyWith<DiaryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryStateCopyWith<$Res> {
  factory $DiaryStateCopyWith(
          DiaryState value, $Res Function(DiaryState) then) =
      _$DiaryStateCopyWithImpl<$Res, DiaryState>;
  @useResult
  $Res call({DateTime selectedDate});
}

/// @nodoc
class _$DiaryStateCopyWithImpl<$Res, $Val extends DiaryState>
    implements $DiaryStateCopyWith<$Res> {
  _$DiaryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
  }) {
    return _then(_value.copyWith(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiaryInitialImplCopyWith<$Res>
    implements $DiaryStateCopyWith<$Res> {
  factory _$$DiaryInitialImplCopyWith(
          _$DiaryInitialImpl value, $Res Function(_$DiaryInitialImpl) then) =
      __$$DiaryInitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime selectedDate});
}

/// @nodoc
class __$$DiaryInitialImplCopyWithImpl<$Res>
    extends _$DiaryStateCopyWithImpl<$Res, _$DiaryInitialImpl>
    implements _$$DiaryInitialImplCopyWith<$Res> {
  __$$DiaryInitialImplCopyWithImpl(
      _$DiaryInitialImpl _value, $Res Function(_$DiaryInitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
  }) {
    return _then(_$DiaryInitialImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$DiaryInitialImpl implements DiaryInitial {
  const _$DiaryInitialImpl({required this.selectedDate});

  @override
  final DateTime selectedDate;

  @override
  String toString() {
    return 'DiaryState.initial(selectedDate: $selectedDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryInitialImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryInitialImplCopyWith<_$DiaryInitialImpl> get copyWith =>
      __$$DiaryInitialImplCopyWithImpl<_$DiaryInitialImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime selectedDate) initial,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        loading,
    required TResult Function(DateTime selectedDate, DiaryEntity diary) loaded,
    required TResult Function(
            DateTime selectedDate, String message, DiaryEntity? diary)
        error,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        removeFoodEntryLoading,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntryError,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntrySuccess,
  }) {
    return initial(selectedDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime selectedDate)? initial,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult? Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult? Function(
            DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
  }) {
    return initial?.call(selectedDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime selectedDate)? initial,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult Function(DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(selectedDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DiaryInitial value) initial,
    required TResult Function(DiaryLoading value) loading,
    required TResult Function(DiaryLoaded value) loaded,
    required TResult Function(DiaryError value) error,
    required TResult Function(_DiaryRemoveFoodEntryLoading value)
        removeFoodEntryLoading,
    required TResult Function(DiaryRemoveFoodEntryError value)
        removeFoodEntryError,
    required TResult Function(DiaryRemoveFoodEntrySuccess value)
        removeFoodEntrySuccess,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DiaryInitial value)? initial,
    TResult? Function(DiaryLoading value)? loading,
    TResult? Function(DiaryLoaded value)? loaded,
    TResult? Function(DiaryError value)? error,
    TResult? Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult? Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult? Function(DiaryRemoveFoodEntrySuccess value)?
        removeFoodEntrySuccess,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DiaryInitial value)? initial,
    TResult Function(DiaryLoading value)? loading,
    TResult Function(DiaryLoaded value)? loaded,
    TResult Function(DiaryError value)? error,
    TResult Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult Function(DiaryRemoveFoodEntrySuccess value)? removeFoodEntrySuccess,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class DiaryInitial implements DiaryState {
  const factory DiaryInitial({required final DateTime selectedDate}) =
      _$DiaryInitialImpl;

  @override
  DateTime get selectedDate;
  @override
  @JsonKey(ignore: true)
  _$$DiaryInitialImplCopyWith<_$DiaryInitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DiaryLoadingImplCopyWith<$Res>
    implements $DiaryStateCopyWith<$Res> {
  factory _$$DiaryLoadingImplCopyWith(
          _$DiaryLoadingImpl value, $Res Function(_$DiaryLoadingImpl) then) =
      __$$DiaryLoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime selectedDate, DiaryEntity? diary});

  $DiaryEntityCopyWith<$Res>? get diary;
}

/// @nodoc
class __$$DiaryLoadingImplCopyWithImpl<$Res>
    extends _$DiaryStateCopyWithImpl<$Res, _$DiaryLoadingImpl>
    implements _$$DiaryLoadingImplCopyWith<$Res> {
  __$$DiaryLoadingImplCopyWithImpl(
      _$DiaryLoadingImpl _value, $Res Function(_$DiaryLoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? diary = freezed,
  }) {
    return _then(_$DiaryLoadingImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      diary: freezed == diary
          ? _value.diary
          : diary // ignore: cast_nullable_to_non_nullable
              as DiaryEntity?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DiaryEntityCopyWith<$Res>? get diary {
    if (_value.diary == null) {
      return null;
    }

    return $DiaryEntityCopyWith<$Res>(_value.diary!, (value) {
      return _then(_value.copyWith(diary: value));
    });
  }
}

/// @nodoc

class _$DiaryLoadingImpl implements DiaryLoading {
  const _$DiaryLoadingImpl({required this.selectedDate, this.diary});

  @override
  final DateTime selectedDate;
  @override
  final DiaryEntity? diary;

  @override
  String toString() {
    return 'DiaryState.loading(selectedDate: $selectedDate, diary: $diary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryLoadingImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.diary, diary) || other.diary == diary));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDate, diary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryLoadingImplCopyWith<_$DiaryLoadingImpl> get copyWith =>
      __$$DiaryLoadingImplCopyWithImpl<_$DiaryLoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime selectedDate) initial,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        loading,
    required TResult Function(DateTime selectedDate, DiaryEntity diary) loaded,
    required TResult Function(
            DateTime selectedDate, String message, DiaryEntity? diary)
        error,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        removeFoodEntryLoading,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntryError,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntrySuccess,
  }) {
    return loading(selectedDate, diary);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime selectedDate)? initial,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult? Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult? Function(
            DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
  }) {
    return loading?.call(selectedDate, diary);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime selectedDate)? initial,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult Function(DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(selectedDate, diary);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DiaryInitial value) initial,
    required TResult Function(DiaryLoading value) loading,
    required TResult Function(DiaryLoaded value) loaded,
    required TResult Function(DiaryError value) error,
    required TResult Function(_DiaryRemoveFoodEntryLoading value)
        removeFoodEntryLoading,
    required TResult Function(DiaryRemoveFoodEntryError value)
        removeFoodEntryError,
    required TResult Function(DiaryRemoveFoodEntrySuccess value)
        removeFoodEntrySuccess,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DiaryInitial value)? initial,
    TResult? Function(DiaryLoading value)? loading,
    TResult? Function(DiaryLoaded value)? loaded,
    TResult? Function(DiaryError value)? error,
    TResult? Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult? Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult? Function(DiaryRemoveFoodEntrySuccess value)?
        removeFoodEntrySuccess,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DiaryInitial value)? initial,
    TResult Function(DiaryLoading value)? loading,
    TResult Function(DiaryLoaded value)? loaded,
    TResult Function(DiaryError value)? error,
    TResult Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult Function(DiaryRemoveFoodEntrySuccess value)? removeFoodEntrySuccess,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class DiaryLoading implements DiaryState {
  const factory DiaryLoading(
      {required final DateTime selectedDate,
      final DiaryEntity? diary}) = _$DiaryLoadingImpl;

  @override
  DateTime get selectedDate;
  DiaryEntity? get diary;
  @override
  @JsonKey(ignore: true)
  _$$DiaryLoadingImplCopyWith<_$DiaryLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DiaryLoadedImplCopyWith<$Res>
    implements $DiaryStateCopyWith<$Res> {
  factory _$$DiaryLoadedImplCopyWith(
          _$DiaryLoadedImpl value, $Res Function(_$DiaryLoadedImpl) then) =
      __$$DiaryLoadedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime selectedDate, DiaryEntity diary});

  $DiaryEntityCopyWith<$Res> get diary;
}

/// @nodoc
class __$$DiaryLoadedImplCopyWithImpl<$Res>
    extends _$DiaryStateCopyWithImpl<$Res, _$DiaryLoadedImpl>
    implements _$$DiaryLoadedImplCopyWith<$Res> {
  __$$DiaryLoadedImplCopyWithImpl(
      _$DiaryLoadedImpl _value, $Res Function(_$DiaryLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? diary = null,
  }) {
    return _then(_$DiaryLoadedImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      diary: null == diary
          ? _value.diary
          : diary // ignore: cast_nullable_to_non_nullable
              as DiaryEntity,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DiaryEntityCopyWith<$Res> get diary {
    return $DiaryEntityCopyWith<$Res>(_value.diary, (value) {
      return _then(_value.copyWith(diary: value));
    });
  }
}

/// @nodoc

class _$DiaryLoadedImpl implements DiaryLoaded {
  const _$DiaryLoadedImpl({required this.selectedDate, required this.diary});

  @override
  final DateTime selectedDate;
  @override
  final DiaryEntity diary;

  @override
  String toString() {
    return 'DiaryState.loaded(selectedDate: $selectedDate, diary: $diary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryLoadedImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.diary, diary) || other.diary == diary));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDate, diary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryLoadedImplCopyWith<_$DiaryLoadedImpl> get copyWith =>
      __$$DiaryLoadedImplCopyWithImpl<_$DiaryLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime selectedDate) initial,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        loading,
    required TResult Function(DateTime selectedDate, DiaryEntity diary) loaded,
    required TResult Function(
            DateTime selectedDate, String message, DiaryEntity? diary)
        error,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        removeFoodEntryLoading,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntryError,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntrySuccess,
  }) {
    return loaded(selectedDate, diary);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime selectedDate)? initial,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult? Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult? Function(
            DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
  }) {
    return loaded?.call(selectedDate, diary);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime selectedDate)? initial,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult Function(DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(selectedDate, diary);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DiaryInitial value) initial,
    required TResult Function(DiaryLoading value) loading,
    required TResult Function(DiaryLoaded value) loaded,
    required TResult Function(DiaryError value) error,
    required TResult Function(_DiaryRemoveFoodEntryLoading value)
        removeFoodEntryLoading,
    required TResult Function(DiaryRemoveFoodEntryError value)
        removeFoodEntryError,
    required TResult Function(DiaryRemoveFoodEntrySuccess value)
        removeFoodEntrySuccess,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DiaryInitial value)? initial,
    TResult? Function(DiaryLoading value)? loading,
    TResult? Function(DiaryLoaded value)? loaded,
    TResult? Function(DiaryError value)? error,
    TResult? Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult? Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult? Function(DiaryRemoveFoodEntrySuccess value)?
        removeFoodEntrySuccess,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DiaryInitial value)? initial,
    TResult Function(DiaryLoading value)? loading,
    TResult Function(DiaryLoaded value)? loaded,
    TResult Function(DiaryError value)? error,
    TResult Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult Function(DiaryRemoveFoodEntrySuccess value)? removeFoodEntrySuccess,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class DiaryLoaded implements DiaryState {
  const factory DiaryLoaded(
      {required final DateTime selectedDate,
      required final DiaryEntity diary}) = _$DiaryLoadedImpl;

  @override
  DateTime get selectedDate;
  DiaryEntity get diary;
  @override
  @JsonKey(ignore: true)
  _$$DiaryLoadedImplCopyWith<_$DiaryLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DiaryErrorImplCopyWith<$Res>
    implements $DiaryStateCopyWith<$Res> {
  factory _$$DiaryErrorImplCopyWith(
          _$DiaryErrorImpl value, $Res Function(_$DiaryErrorImpl) then) =
      __$$DiaryErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime selectedDate, String message, DiaryEntity? diary});

  $DiaryEntityCopyWith<$Res>? get diary;
}

/// @nodoc
class __$$DiaryErrorImplCopyWithImpl<$Res>
    extends _$DiaryStateCopyWithImpl<$Res, _$DiaryErrorImpl>
    implements _$$DiaryErrorImplCopyWith<$Res> {
  __$$DiaryErrorImplCopyWithImpl(
      _$DiaryErrorImpl _value, $Res Function(_$DiaryErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? message = null,
    Object? diary = freezed,
  }) {
    return _then(_$DiaryErrorImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      diary: freezed == diary
          ? _value.diary
          : diary // ignore: cast_nullable_to_non_nullable
              as DiaryEntity?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DiaryEntityCopyWith<$Res>? get diary {
    if (_value.diary == null) {
      return null;
    }

    return $DiaryEntityCopyWith<$Res>(_value.diary!, (value) {
      return _then(_value.copyWith(diary: value));
    });
  }
}

/// @nodoc

class _$DiaryErrorImpl implements DiaryError {
  const _$DiaryErrorImpl(
      {required this.selectedDate, required this.message, this.diary});

  @override
  final DateTime selectedDate;
  @override
  final String message;
  @override
  final DiaryEntity? diary;

  @override
  String toString() {
    return 'DiaryState.error(selectedDate: $selectedDate, message: $message, diary: $diary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryErrorImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.diary, diary) || other.diary == diary));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDate, message, diary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryErrorImplCopyWith<_$DiaryErrorImpl> get copyWith =>
      __$$DiaryErrorImplCopyWithImpl<_$DiaryErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime selectedDate) initial,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        loading,
    required TResult Function(DateTime selectedDate, DiaryEntity diary) loaded,
    required TResult Function(
            DateTime selectedDate, String message, DiaryEntity? diary)
        error,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        removeFoodEntryLoading,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntryError,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntrySuccess,
  }) {
    return error(selectedDate, message, diary);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime selectedDate)? initial,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult? Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult? Function(
            DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
  }) {
    return error?.call(selectedDate, message, diary);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime selectedDate)? initial,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult Function(DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(selectedDate, message, diary);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DiaryInitial value) initial,
    required TResult Function(DiaryLoading value) loading,
    required TResult Function(DiaryLoaded value) loaded,
    required TResult Function(DiaryError value) error,
    required TResult Function(_DiaryRemoveFoodEntryLoading value)
        removeFoodEntryLoading,
    required TResult Function(DiaryRemoveFoodEntryError value)
        removeFoodEntryError,
    required TResult Function(DiaryRemoveFoodEntrySuccess value)
        removeFoodEntrySuccess,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DiaryInitial value)? initial,
    TResult? Function(DiaryLoading value)? loading,
    TResult? Function(DiaryLoaded value)? loaded,
    TResult? Function(DiaryError value)? error,
    TResult? Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult? Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult? Function(DiaryRemoveFoodEntrySuccess value)?
        removeFoodEntrySuccess,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DiaryInitial value)? initial,
    TResult Function(DiaryLoading value)? loading,
    TResult Function(DiaryLoaded value)? loaded,
    TResult Function(DiaryError value)? error,
    TResult Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult Function(DiaryRemoveFoodEntrySuccess value)? removeFoodEntrySuccess,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class DiaryError implements DiaryState {
  const factory DiaryError(
      {required final DateTime selectedDate,
      required final String message,
      final DiaryEntity? diary}) = _$DiaryErrorImpl;

  @override
  DateTime get selectedDate;
  String get message;
  DiaryEntity? get diary;
  @override
  @JsonKey(ignore: true)
  _$$DiaryErrorImplCopyWith<_$DiaryErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DiaryRemoveFoodEntryLoadingImplCopyWith<$Res>
    implements $DiaryStateCopyWith<$Res> {
  factory _$$DiaryRemoveFoodEntryLoadingImplCopyWith(
          _$DiaryRemoveFoodEntryLoadingImpl value,
          $Res Function(_$DiaryRemoveFoodEntryLoadingImpl) then) =
      __$$DiaryRemoveFoodEntryLoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime selectedDate, DiaryEntity? diary});

  $DiaryEntityCopyWith<$Res>? get diary;
}

/// @nodoc
class __$$DiaryRemoveFoodEntryLoadingImplCopyWithImpl<$Res>
    extends _$DiaryStateCopyWithImpl<$Res, _$DiaryRemoveFoodEntryLoadingImpl>
    implements _$$DiaryRemoveFoodEntryLoadingImplCopyWith<$Res> {
  __$$DiaryRemoveFoodEntryLoadingImplCopyWithImpl(
      _$DiaryRemoveFoodEntryLoadingImpl _value,
      $Res Function(_$DiaryRemoveFoodEntryLoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? diary = freezed,
  }) {
    return _then(_$DiaryRemoveFoodEntryLoadingImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      diary: freezed == diary
          ? _value.diary
          : diary // ignore: cast_nullable_to_non_nullable
              as DiaryEntity?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DiaryEntityCopyWith<$Res>? get diary {
    if (_value.diary == null) {
      return null;
    }

    return $DiaryEntityCopyWith<$Res>(_value.diary!, (value) {
      return _then(_value.copyWith(diary: value));
    });
  }
}

/// @nodoc

class _$DiaryRemoveFoodEntryLoadingImpl
    implements _DiaryRemoveFoodEntryLoading {
  const _$DiaryRemoveFoodEntryLoadingImpl(
      {required this.selectedDate, this.diary});

  @override
  final DateTime selectedDate;
  @override
  final DiaryEntity? diary;

  @override
  String toString() {
    return 'DiaryState.removeFoodEntryLoading(selectedDate: $selectedDate, diary: $diary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryRemoveFoodEntryLoadingImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.diary, diary) || other.diary == diary));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDate, diary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryRemoveFoodEntryLoadingImplCopyWith<_$DiaryRemoveFoodEntryLoadingImpl>
      get copyWith => __$$DiaryRemoveFoodEntryLoadingImplCopyWithImpl<
          _$DiaryRemoveFoodEntryLoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime selectedDate) initial,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        loading,
    required TResult Function(DateTime selectedDate, DiaryEntity diary) loaded,
    required TResult Function(
            DateTime selectedDate, String message, DiaryEntity? diary)
        error,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        removeFoodEntryLoading,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntryError,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntrySuccess,
  }) {
    return removeFoodEntryLoading(selectedDate, diary);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime selectedDate)? initial,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult? Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult? Function(
            DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
  }) {
    return removeFoodEntryLoading?.call(selectedDate, diary);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime selectedDate)? initial,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult Function(DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
    required TResult orElse(),
  }) {
    if (removeFoodEntryLoading != null) {
      return removeFoodEntryLoading(selectedDate, diary);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DiaryInitial value) initial,
    required TResult Function(DiaryLoading value) loading,
    required TResult Function(DiaryLoaded value) loaded,
    required TResult Function(DiaryError value) error,
    required TResult Function(_DiaryRemoveFoodEntryLoading value)
        removeFoodEntryLoading,
    required TResult Function(DiaryRemoveFoodEntryError value)
        removeFoodEntryError,
    required TResult Function(DiaryRemoveFoodEntrySuccess value)
        removeFoodEntrySuccess,
  }) {
    return removeFoodEntryLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DiaryInitial value)? initial,
    TResult? Function(DiaryLoading value)? loading,
    TResult? Function(DiaryLoaded value)? loaded,
    TResult? Function(DiaryError value)? error,
    TResult? Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult? Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult? Function(DiaryRemoveFoodEntrySuccess value)?
        removeFoodEntrySuccess,
  }) {
    return removeFoodEntryLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DiaryInitial value)? initial,
    TResult Function(DiaryLoading value)? loading,
    TResult Function(DiaryLoaded value)? loaded,
    TResult Function(DiaryError value)? error,
    TResult Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult Function(DiaryRemoveFoodEntrySuccess value)? removeFoodEntrySuccess,
    required TResult orElse(),
  }) {
    if (removeFoodEntryLoading != null) {
      return removeFoodEntryLoading(this);
    }
    return orElse();
  }
}

abstract class _DiaryRemoveFoodEntryLoading implements DiaryState {
  const factory _DiaryRemoveFoodEntryLoading(
      {required final DateTime selectedDate,
      final DiaryEntity? diary}) = _$DiaryRemoveFoodEntryLoadingImpl;

  @override
  DateTime get selectedDate;
  DiaryEntity? get diary;
  @override
  @JsonKey(ignore: true)
  _$$DiaryRemoveFoodEntryLoadingImplCopyWith<_$DiaryRemoveFoodEntryLoadingImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DiaryRemoveFoodEntryErrorImplCopyWith<$Res>
    implements $DiaryStateCopyWith<$Res> {
  factory _$$DiaryRemoveFoodEntryErrorImplCopyWith(
          _$DiaryRemoveFoodEntryErrorImpl value,
          $Res Function(_$DiaryRemoveFoodEntryErrorImpl) then) =
      __$$DiaryRemoveFoodEntryErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime selectedDate, DiaryEntity? diary, String message});

  $DiaryEntityCopyWith<$Res>? get diary;
}

/// @nodoc
class __$$DiaryRemoveFoodEntryErrorImplCopyWithImpl<$Res>
    extends _$DiaryStateCopyWithImpl<$Res, _$DiaryRemoveFoodEntryErrorImpl>
    implements _$$DiaryRemoveFoodEntryErrorImplCopyWith<$Res> {
  __$$DiaryRemoveFoodEntryErrorImplCopyWithImpl(
      _$DiaryRemoveFoodEntryErrorImpl _value,
      $Res Function(_$DiaryRemoveFoodEntryErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? diary = freezed,
    Object? message = null,
  }) {
    return _then(_$DiaryRemoveFoodEntryErrorImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      diary: freezed == diary
          ? _value.diary
          : diary // ignore: cast_nullable_to_non_nullable
              as DiaryEntity?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DiaryEntityCopyWith<$Res>? get diary {
    if (_value.diary == null) {
      return null;
    }

    return $DiaryEntityCopyWith<$Res>(_value.diary!, (value) {
      return _then(_value.copyWith(diary: value));
    });
  }
}

/// @nodoc

class _$DiaryRemoveFoodEntryErrorImpl implements DiaryRemoveFoodEntryError {
  const _$DiaryRemoveFoodEntryErrorImpl(
      {required this.selectedDate, this.diary, required this.message});

  @override
  final DateTime selectedDate;
  @override
  final DiaryEntity? diary;
  @override
  final String message;

  @override
  String toString() {
    return 'DiaryState.removeFoodEntryError(selectedDate: $selectedDate, diary: $diary, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryRemoveFoodEntryErrorImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.diary, diary) || other.diary == diary) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDate, diary, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryRemoveFoodEntryErrorImplCopyWith<_$DiaryRemoveFoodEntryErrorImpl>
      get copyWith => __$$DiaryRemoveFoodEntryErrorImplCopyWithImpl<
          _$DiaryRemoveFoodEntryErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime selectedDate) initial,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        loading,
    required TResult Function(DateTime selectedDate, DiaryEntity diary) loaded,
    required TResult Function(
            DateTime selectedDate, String message, DiaryEntity? diary)
        error,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        removeFoodEntryLoading,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntryError,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntrySuccess,
  }) {
    return removeFoodEntryError(selectedDate, diary, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime selectedDate)? initial,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult? Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult? Function(
            DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
  }) {
    return removeFoodEntryError?.call(selectedDate, diary, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime selectedDate)? initial,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult Function(DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
    required TResult orElse(),
  }) {
    if (removeFoodEntryError != null) {
      return removeFoodEntryError(selectedDate, diary, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DiaryInitial value) initial,
    required TResult Function(DiaryLoading value) loading,
    required TResult Function(DiaryLoaded value) loaded,
    required TResult Function(DiaryError value) error,
    required TResult Function(_DiaryRemoveFoodEntryLoading value)
        removeFoodEntryLoading,
    required TResult Function(DiaryRemoveFoodEntryError value)
        removeFoodEntryError,
    required TResult Function(DiaryRemoveFoodEntrySuccess value)
        removeFoodEntrySuccess,
  }) {
    return removeFoodEntryError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DiaryInitial value)? initial,
    TResult? Function(DiaryLoading value)? loading,
    TResult? Function(DiaryLoaded value)? loaded,
    TResult? Function(DiaryError value)? error,
    TResult? Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult? Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult? Function(DiaryRemoveFoodEntrySuccess value)?
        removeFoodEntrySuccess,
  }) {
    return removeFoodEntryError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DiaryInitial value)? initial,
    TResult Function(DiaryLoading value)? loading,
    TResult Function(DiaryLoaded value)? loaded,
    TResult Function(DiaryError value)? error,
    TResult Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult Function(DiaryRemoveFoodEntrySuccess value)? removeFoodEntrySuccess,
    required TResult orElse(),
  }) {
    if (removeFoodEntryError != null) {
      return removeFoodEntryError(this);
    }
    return orElse();
  }
}

abstract class DiaryRemoveFoodEntryError implements DiaryState {
  const factory DiaryRemoveFoodEntryError(
      {required final DateTime selectedDate,
      final DiaryEntity? diary,
      required final String message}) = _$DiaryRemoveFoodEntryErrorImpl;

  @override
  DateTime get selectedDate;
  DiaryEntity? get diary;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$DiaryRemoveFoodEntryErrorImplCopyWith<_$DiaryRemoveFoodEntryErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DiaryRemoveFoodEntrySuccessImplCopyWith<$Res>
    implements $DiaryStateCopyWith<$Res> {
  factory _$$DiaryRemoveFoodEntrySuccessImplCopyWith(
          _$DiaryRemoveFoodEntrySuccessImpl value,
          $Res Function(_$DiaryRemoveFoodEntrySuccessImpl) then) =
      __$$DiaryRemoveFoodEntrySuccessImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime selectedDate, DiaryEntity? diary, String message});

  $DiaryEntityCopyWith<$Res>? get diary;
}

/// @nodoc
class __$$DiaryRemoveFoodEntrySuccessImplCopyWithImpl<$Res>
    extends _$DiaryStateCopyWithImpl<$Res, _$DiaryRemoveFoodEntrySuccessImpl>
    implements _$$DiaryRemoveFoodEntrySuccessImplCopyWith<$Res> {
  __$$DiaryRemoveFoodEntrySuccessImplCopyWithImpl(
      _$DiaryRemoveFoodEntrySuccessImpl _value,
      $Res Function(_$DiaryRemoveFoodEntrySuccessImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? diary = freezed,
    Object? message = null,
  }) {
    return _then(_$DiaryRemoveFoodEntrySuccessImpl(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      diary: freezed == diary
          ? _value.diary
          : diary // ignore: cast_nullable_to_non_nullable
              as DiaryEntity?,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $DiaryEntityCopyWith<$Res>? get diary {
    if (_value.diary == null) {
      return null;
    }

    return $DiaryEntityCopyWith<$Res>(_value.diary!, (value) {
      return _then(_value.copyWith(diary: value));
    });
  }
}

/// @nodoc

class _$DiaryRemoveFoodEntrySuccessImpl implements DiaryRemoveFoodEntrySuccess {
  const _$DiaryRemoveFoodEntrySuccessImpl(
      {required this.selectedDate, this.diary, required this.message});

  @override
  final DateTime selectedDate;
  @override
  final DiaryEntity? diary;
  @override
  final String message;

  @override
  String toString() {
    return 'DiaryState.removeFoodEntrySuccess(selectedDate: $selectedDate, diary: $diary, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiaryRemoveFoodEntrySuccessImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.diary, diary) || other.diary == diary) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDate, diary, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiaryRemoveFoodEntrySuccessImplCopyWith<_$DiaryRemoveFoodEntrySuccessImpl>
      get copyWith => __$$DiaryRemoveFoodEntrySuccessImplCopyWithImpl<
          _$DiaryRemoveFoodEntrySuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime selectedDate) initial,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        loading,
    required TResult Function(DateTime selectedDate, DiaryEntity diary) loaded,
    required TResult Function(
            DateTime selectedDate, String message, DiaryEntity? diary)
        error,
    required TResult Function(DateTime selectedDate, DiaryEntity? diary)
        removeFoodEntryLoading,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntryError,
    required TResult Function(
            DateTime selectedDate, DiaryEntity? diary, String message)
        removeFoodEntrySuccess,
  }) {
    return removeFoodEntrySuccess(selectedDate, diary, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime selectedDate)? initial,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult? Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult? Function(
            DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult? Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult? Function(
            DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
  }) {
    return removeFoodEntrySuccess?.call(selectedDate, diary, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime selectedDate)? initial,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)? loading,
    TResult Function(DateTime selectedDate, DiaryEntity diary)? loaded,
    TResult Function(DateTime selectedDate, String message, DiaryEntity? diary)?
        error,
    TResult Function(DateTime selectedDate, DiaryEntity? diary)?
        removeFoodEntryLoading,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntryError,
    TResult Function(DateTime selectedDate, DiaryEntity? diary, String message)?
        removeFoodEntrySuccess,
    required TResult orElse(),
  }) {
    if (removeFoodEntrySuccess != null) {
      return removeFoodEntrySuccess(selectedDate, diary, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DiaryInitial value) initial,
    required TResult Function(DiaryLoading value) loading,
    required TResult Function(DiaryLoaded value) loaded,
    required TResult Function(DiaryError value) error,
    required TResult Function(_DiaryRemoveFoodEntryLoading value)
        removeFoodEntryLoading,
    required TResult Function(DiaryRemoveFoodEntryError value)
        removeFoodEntryError,
    required TResult Function(DiaryRemoveFoodEntrySuccess value)
        removeFoodEntrySuccess,
  }) {
    return removeFoodEntrySuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DiaryInitial value)? initial,
    TResult? Function(DiaryLoading value)? loading,
    TResult? Function(DiaryLoaded value)? loaded,
    TResult? Function(DiaryError value)? error,
    TResult? Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult? Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult? Function(DiaryRemoveFoodEntrySuccess value)?
        removeFoodEntrySuccess,
  }) {
    return removeFoodEntrySuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DiaryInitial value)? initial,
    TResult Function(DiaryLoading value)? loading,
    TResult Function(DiaryLoaded value)? loaded,
    TResult Function(DiaryError value)? error,
    TResult Function(_DiaryRemoveFoodEntryLoading value)?
        removeFoodEntryLoading,
    TResult Function(DiaryRemoveFoodEntryError value)? removeFoodEntryError,
    TResult Function(DiaryRemoveFoodEntrySuccess value)? removeFoodEntrySuccess,
    required TResult orElse(),
  }) {
    if (removeFoodEntrySuccess != null) {
      return removeFoodEntrySuccess(this);
    }
    return orElse();
  }
}

abstract class DiaryRemoveFoodEntrySuccess implements DiaryState {
  const factory DiaryRemoveFoodEntrySuccess(
      {required final DateTime selectedDate,
      final DiaryEntity? diary,
      required final String message}) = _$DiaryRemoveFoodEntrySuccessImpl;

  @override
  DateTime get selectedDate;
  DiaryEntity? get diary;
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$DiaryRemoveFoodEntrySuccessImplCopyWith<_$DiaryRemoveFoodEntrySuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}
