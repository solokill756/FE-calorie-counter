// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_detail_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FoodDetailState {
  DateTime get currentDate => throw _privateConstructorUsedError;
  String get selectedPeriod => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime currentDate, String selectedPeriod)
        initial,
    required TResult Function(DateTime currentDate, String selectedPeriod)
        loading,
    required TResult Function(List<FoodItemEntity> foods, DateTime currentDate,
            String selectedPeriod)
        loaded,
    required TResult Function(
            String message, DateTime currentDate, String selectedPeriod)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime currentDate, String selectedPeriod)? initial,
    TResult? Function(DateTime currentDate, String selectedPeriod)? loading,
    TResult? Function(List<FoodItemEntity> foods, DateTime currentDate,
            String selectedPeriod)?
        loaded,
    TResult? Function(
            String message, DateTime currentDate, String selectedPeriod)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime currentDate, String selectedPeriod)? initial,
    TResult Function(DateTime currentDate, String selectedPeriod)? loading,
    TResult Function(List<FoodItemEntity> foods, DateTime currentDate,
            String selectedPeriod)?
        loaded,
    TResult Function(
            String message, DateTime currentDate, String selectedPeriod)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FoodDetailInitial value) initial,
    required TResult Function(FoodDetailLoading value) loading,
    required TResult Function(FoodDetailLoaded value) loaded,
    required TResult Function(FoodDetailError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FoodDetailInitial value)? initial,
    TResult? Function(FoodDetailLoading value)? loading,
    TResult? Function(FoodDetailLoaded value)? loaded,
    TResult? Function(FoodDetailError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FoodDetailInitial value)? initial,
    TResult Function(FoodDetailLoading value)? loading,
    TResult Function(FoodDetailLoaded value)? loaded,
    TResult Function(FoodDetailError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FoodDetailStateCopyWith<FoodDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodDetailStateCopyWith<$Res> {
  factory $FoodDetailStateCopyWith(
          FoodDetailState value, $Res Function(FoodDetailState) then) =
      _$FoodDetailStateCopyWithImpl<$Res, FoodDetailState>;
  @useResult
  $Res call({DateTime currentDate, String selectedPeriod});
}

/// @nodoc
class _$FoodDetailStateCopyWithImpl<$Res, $Val extends FoodDetailState>
    implements $FoodDetailStateCopyWith<$Res> {
  _$FoodDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDate = null,
    Object? selectedPeriod = null,
  }) {
    return _then(_value.copyWith(
      currentDate: null == currentDate
          ? _value.currentDate
          : currentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedPeriod: null == selectedPeriod
          ? _value.selectedPeriod
          : selectedPeriod // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FoodDetailInitialImplCopyWith<$Res>
    implements $FoodDetailStateCopyWith<$Res> {
  factory _$$FoodDetailInitialImplCopyWith(_$FoodDetailInitialImpl value,
          $Res Function(_$FoodDetailInitialImpl) then) =
      __$$FoodDetailInitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime currentDate, String selectedPeriod});
}

/// @nodoc
class __$$FoodDetailInitialImplCopyWithImpl<$Res>
    extends _$FoodDetailStateCopyWithImpl<$Res, _$FoodDetailInitialImpl>
    implements _$$FoodDetailInitialImplCopyWith<$Res> {
  __$$FoodDetailInitialImplCopyWithImpl(_$FoodDetailInitialImpl _value,
      $Res Function(_$FoodDetailInitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDate = null,
    Object? selectedPeriod = null,
  }) {
    return _then(_$FoodDetailInitialImpl(
      currentDate: null == currentDate
          ? _value.currentDate
          : currentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedPeriod: null == selectedPeriod
          ? _value.selectedPeriod
          : selectedPeriod // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FoodDetailInitialImpl implements FoodDetailInitial {
  const _$FoodDetailInitialImpl(
      {required this.currentDate, this.selectedPeriod = 'Week View'});

  @override
  final DateTime currentDate;
  @override
  @JsonKey()
  final String selectedPeriod;

  @override
  String toString() {
    return 'FoodDetailState.initial(currentDate: $currentDate, selectedPeriod: $selectedPeriod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodDetailInitialImpl &&
            (identical(other.currentDate, currentDate) ||
                other.currentDate == currentDate) &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentDate, selectedPeriod);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodDetailInitialImplCopyWith<_$FoodDetailInitialImpl> get copyWith =>
      __$$FoodDetailInitialImplCopyWithImpl<_$FoodDetailInitialImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime currentDate, String selectedPeriod)
        initial,
    required TResult Function(DateTime currentDate, String selectedPeriod)
        loading,
    required TResult Function(List<FoodItemEntity> foods, DateTime currentDate,
            String selectedPeriod)
        loaded,
    required TResult Function(
            String message, DateTime currentDate, String selectedPeriod)
        error,
  }) {
    return initial(currentDate, selectedPeriod);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime currentDate, String selectedPeriod)? initial,
    TResult? Function(DateTime currentDate, String selectedPeriod)? loading,
    TResult? Function(List<FoodItemEntity> foods, DateTime currentDate,
            String selectedPeriod)?
        loaded,
    TResult? Function(
            String message, DateTime currentDate, String selectedPeriod)?
        error,
  }) {
    return initial?.call(currentDate, selectedPeriod);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime currentDate, String selectedPeriod)? initial,
    TResult Function(DateTime currentDate, String selectedPeriod)? loading,
    TResult Function(List<FoodItemEntity> foods, DateTime currentDate,
            String selectedPeriod)?
        loaded,
    TResult Function(
            String message, DateTime currentDate, String selectedPeriod)?
        error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(currentDate, selectedPeriod);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FoodDetailInitial value) initial,
    required TResult Function(FoodDetailLoading value) loading,
    required TResult Function(FoodDetailLoaded value) loaded,
    required TResult Function(FoodDetailError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FoodDetailInitial value)? initial,
    TResult? Function(FoodDetailLoading value)? loading,
    TResult? Function(FoodDetailLoaded value)? loaded,
    TResult? Function(FoodDetailError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FoodDetailInitial value)? initial,
    TResult Function(FoodDetailLoading value)? loading,
    TResult Function(FoodDetailLoaded value)? loaded,
    TResult Function(FoodDetailError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class FoodDetailInitial implements FoodDetailState {
  const factory FoodDetailInitial(
      {required final DateTime currentDate,
      final String selectedPeriod}) = _$FoodDetailInitialImpl;

  @override
  DateTime get currentDate;
  @override
  String get selectedPeriod;
  @override
  @JsonKey(ignore: true)
  _$$FoodDetailInitialImplCopyWith<_$FoodDetailInitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FoodDetailLoadingImplCopyWith<$Res>
    implements $FoodDetailStateCopyWith<$Res> {
  factory _$$FoodDetailLoadingImplCopyWith(_$FoodDetailLoadingImpl value,
          $Res Function(_$FoodDetailLoadingImpl) then) =
      __$$FoodDetailLoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime currentDate, String selectedPeriod});
}

/// @nodoc
class __$$FoodDetailLoadingImplCopyWithImpl<$Res>
    extends _$FoodDetailStateCopyWithImpl<$Res, _$FoodDetailLoadingImpl>
    implements _$$FoodDetailLoadingImplCopyWith<$Res> {
  __$$FoodDetailLoadingImplCopyWithImpl(_$FoodDetailLoadingImpl _value,
      $Res Function(_$FoodDetailLoadingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDate = null,
    Object? selectedPeriod = null,
  }) {
    return _then(_$FoodDetailLoadingImpl(
      currentDate: null == currentDate
          ? _value.currentDate
          : currentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedPeriod: null == selectedPeriod
          ? _value.selectedPeriod
          : selectedPeriod // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FoodDetailLoadingImpl implements FoodDetailLoading {
  const _$FoodDetailLoadingImpl(
      {required this.currentDate, required this.selectedPeriod});

  @override
  final DateTime currentDate;
  @override
  final String selectedPeriod;

  @override
  String toString() {
    return 'FoodDetailState.loading(currentDate: $currentDate, selectedPeriod: $selectedPeriod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodDetailLoadingImpl &&
            (identical(other.currentDate, currentDate) ||
                other.currentDate == currentDate) &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentDate, selectedPeriod);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodDetailLoadingImplCopyWith<_$FoodDetailLoadingImpl> get copyWith =>
      __$$FoodDetailLoadingImplCopyWithImpl<_$FoodDetailLoadingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime currentDate, String selectedPeriod)
        initial,
    required TResult Function(DateTime currentDate, String selectedPeriod)
        loading,
    required TResult Function(List<FoodItemEntity> foods, DateTime currentDate,
            String selectedPeriod)
        loaded,
    required TResult Function(
            String message, DateTime currentDate, String selectedPeriod)
        error,
  }) {
    return loading(currentDate, selectedPeriod);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime currentDate, String selectedPeriod)? initial,
    TResult? Function(DateTime currentDate, String selectedPeriod)? loading,
    TResult? Function(List<FoodItemEntity> foods, DateTime currentDate,
            String selectedPeriod)?
        loaded,
    TResult? Function(
            String message, DateTime currentDate, String selectedPeriod)?
        error,
  }) {
    return loading?.call(currentDate, selectedPeriod);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime currentDate, String selectedPeriod)? initial,
    TResult Function(DateTime currentDate, String selectedPeriod)? loading,
    TResult Function(List<FoodItemEntity> foods, DateTime currentDate,
            String selectedPeriod)?
        loaded,
    TResult Function(
            String message, DateTime currentDate, String selectedPeriod)?
        error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(currentDate, selectedPeriod);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FoodDetailInitial value) initial,
    required TResult Function(FoodDetailLoading value) loading,
    required TResult Function(FoodDetailLoaded value) loaded,
    required TResult Function(FoodDetailError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FoodDetailInitial value)? initial,
    TResult? Function(FoodDetailLoading value)? loading,
    TResult? Function(FoodDetailLoaded value)? loaded,
    TResult? Function(FoodDetailError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FoodDetailInitial value)? initial,
    TResult Function(FoodDetailLoading value)? loading,
    TResult Function(FoodDetailLoaded value)? loaded,
    TResult Function(FoodDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class FoodDetailLoading implements FoodDetailState {
  const factory FoodDetailLoading(
      {required final DateTime currentDate,
      required final String selectedPeriod}) = _$FoodDetailLoadingImpl;

  @override
  DateTime get currentDate;
  @override
  String get selectedPeriod;
  @override
  @JsonKey(ignore: true)
  _$$FoodDetailLoadingImplCopyWith<_$FoodDetailLoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FoodDetailLoadedImplCopyWith<$Res>
    implements $FoodDetailStateCopyWith<$Res> {
  factory _$$FoodDetailLoadedImplCopyWith(_$FoodDetailLoadedImpl value,
          $Res Function(_$FoodDetailLoadedImpl) then) =
      __$$FoodDetailLoadedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<FoodItemEntity> foods,
      DateTime currentDate,
      String selectedPeriod});
}

/// @nodoc
class __$$FoodDetailLoadedImplCopyWithImpl<$Res>
    extends _$FoodDetailStateCopyWithImpl<$Res, _$FoodDetailLoadedImpl>
    implements _$$FoodDetailLoadedImplCopyWith<$Res> {
  __$$FoodDetailLoadedImplCopyWithImpl(_$FoodDetailLoadedImpl _value,
      $Res Function(_$FoodDetailLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foods = null,
    Object? currentDate = null,
    Object? selectedPeriod = null,
  }) {
    return _then(_$FoodDetailLoadedImpl(
      foods: null == foods
          ? _value._foods
          : foods // ignore: cast_nullable_to_non_nullable
              as List<FoodItemEntity>,
      currentDate: null == currentDate
          ? _value.currentDate
          : currentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedPeriod: null == selectedPeriod
          ? _value.selectedPeriod
          : selectedPeriod // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FoodDetailLoadedImpl implements FoodDetailLoaded {
  const _$FoodDetailLoadedImpl(
      {required final List<FoodItemEntity> foods,
      required this.currentDate,
      required this.selectedPeriod})
      : _foods = foods;

  final List<FoodItemEntity> _foods;
  @override
  List<FoodItemEntity> get foods {
    if (_foods is EqualUnmodifiableListView) return _foods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foods);
  }

  @override
  final DateTime currentDate;
  @override
  final String selectedPeriod;

  @override
  String toString() {
    return 'FoodDetailState.loaded(foods: $foods, currentDate: $currentDate, selectedPeriod: $selectedPeriod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodDetailLoadedImpl &&
            const DeepCollectionEquality().equals(other._foods, _foods) &&
            (identical(other.currentDate, currentDate) ||
                other.currentDate == currentDate) &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_foods), currentDate, selectedPeriod);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodDetailLoadedImplCopyWith<_$FoodDetailLoadedImpl> get copyWith =>
      __$$FoodDetailLoadedImplCopyWithImpl<_$FoodDetailLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime currentDate, String selectedPeriod)
        initial,
    required TResult Function(DateTime currentDate, String selectedPeriod)
        loading,
    required TResult Function(List<FoodItemEntity> foods, DateTime currentDate,
            String selectedPeriod)
        loaded,
    required TResult Function(
            String message, DateTime currentDate, String selectedPeriod)
        error,
  }) {
    return loaded(foods, currentDate, selectedPeriod);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime currentDate, String selectedPeriod)? initial,
    TResult? Function(DateTime currentDate, String selectedPeriod)? loading,
    TResult? Function(List<FoodItemEntity> foods, DateTime currentDate,
            String selectedPeriod)?
        loaded,
    TResult? Function(
            String message, DateTime currentDate, String selectedPeriod)?
        error,
  }) {
    return loaded?.call(foods, currentDate, selectedPeriod);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime currentDate, String selectedPeriod)? initial,
    TResult Function(DateTime currentDate, String selectedPeriod)? loading,
    TResult Function(List<FoodItemEntity> foods, DateTime currentDate,
            String selectedPeriod)?
        loaded,
    TResult Function(
            String message, DateTime currentDate, String selectedPeriod)?
        error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(foods, currentDate, selectedPeriod);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FoodDetailInitial value) initial,
    required TResult Function(FoodDetailLoading value) loading,
    required TResult Function(FoodDetailLoaded value) loaded,
    required TResult Function(FoodDetailError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FoodDetailInitial value)? initial,
    TResult? Function(FoodDetailLoading value)? loading,
    TResult? Function(FoodDetailLoaded value)? loaded,
    TResult? Function(FoodDetailError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FoodDetailInitial value)? initial,
    TResult Function(FoodDetailLoading value)? loading,
    TResult Function(FoodDetailLoaded value)? loaded,
    TResult Function(FoodDetailError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class FoodDetailLoaded implements FoodDetailState {
  const factory FoodDetailLoaded(
      {required final List<FoodItemEntity> foods,
      required final DateTime currentDate,
      required final String selectedPeriod}) = _$FoodDetailLoadedImpl;

  List<FoodItemEntity> get foods;
  @override
  DateTime get currentDate;
  @override
  String get selectedPeriod;
  @override
  @JsonKey(ignore: true)
  _$$FoodDetailLoadedImplCopyWith<_$FoodDetailLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FoodDetailErrorImplCopyWith<$Res>
    implements $FoodDetailStateCopyWith<$Res> {
  factory _$$FoodDetailErrorImplCopyWith(_$FoodDetailErrorImpl value,
          $Res Function(_$FoodDetailErrorImpl) then) =
      __$$FoodDetailErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, DateTime currentDate, String selectedPeriod});
}

/// @nodoc
class __$$FoodDetailErrorImplCopyWithImpl<$Res>
    extends _$FoodDetailStateCopyWithImpl<$Res, _$FoodDetailErrorImpl>
    implements _$$FoodDetailErrorImplCopyWith<$Res> {
  __$$FoodDetailErrorImplCopyWithImpl(
      _$FoodDetailErrorImpl _value, $Res Function(_$FoodDetailErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? currentDate = null,
    Object? selectedPeriod = null,
  }) {
    return _then(_$FoodDetailErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      currentDate: null == currentDate
          ? _value.currentDate
          : currentDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      selectedPeriod: null == selectedPeriod
          ? _value.selectedPeriod
          : selectedPeriod // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FoodDetailErrorImpl implements FoodDetailError {
  const _$FoodDetailErrorImpl(
      {required this.message,
      required this.currentDate,
      required this.selectedPeriod});

  @override
  final String message;
  @override
  final DateTime currentDate;
  @override
  final String selectedPeriod;

  @override
  String toString() {
    return 'FoodDetailState.error(message: $message, currentDate: $currentDate, selectedPeriod: $selectedPeriod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodDetailErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.currentDate, currentDate) ||
                other.currentDate == currentDate) &&
            (identical(other.selectedPeriod, selectedPeriod) ||
                other.selectedPeriod == selectedPeriod));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, currentDate, selectedPeriod);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodDetailErrorImplCopyWith<_$FoodDetailErrorImpl> get copyWith =>
      __$$FoodDetailErrorImplCopyWithImpl<_$FoodDetailErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(DateTime currentDate, String selectedPeriod)
        initial,
    required TResult Function(DateTime currentDate, String selectedPeriod)
        loading,
    required TResult Function(List<FoodItemEntity> foods, DateTime currentDate,
            String selectedPeriod)
        loaded,
    required TResult Function(
            String message, DateTime currentDate, String selectedPeriod)
        error,
  }) {
    return error(message, currentDate, selectedPeriod);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(DateTime currentDate, String selectedPeriod)? initial,
    TResult? Function(DateTime currentDate, String selectedPeriod)? loading,
    TResult? Function(List<FoodItemEntity> foods, DateTime currentDate,
            String selectedPeriod)?
        loaded,
    TResult? Function(
            String message, DateTime currentDate, String selectedPeriod)?
        error,
  }) {
    return error?.call(message, currentDate, selectedPeriod);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(DateTime currentDate, String selectedPeriod)? initial,
    TResult Function(DateTime currentDate, String selectedPeriod)? loading,
    TResult Function(List<FoodItemEntity> foods, DateTime currentDate,
            String selectedPeriod)?
        loaded,
    TResult Function(
            String message, DateTime currentDate, String selectedPeriod)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, currentDate, selectedPeriod);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FoodDetailInitial value) initial,
    required TResult Function(FoodDetailLoading value) loading,
    required TResult Function(FoodDetailLoaded value) loaded,
    required TResult Function(FoodDetailError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FoodDetailInitial value)? initial,
    TResult? Function(FoodDetailLoading value)? loading,
    TResult? Function(FoodDetailLoaded value)? loaded,
    TResult? Function(FoodDetailError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FoodDetailInitial value)? initial,
    TResult Function(FoodDetailLoading value)? loading,
    TResult Function(FoodDetailLoaded value)? loaded,
    TResult Function(FoodDetailError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class FoodDetailError implements FoodDetailState {
  const factory FoodDetailError(
      {required final String message,
      required final DateTime currentDate,
      required final String selectedPeriod}) = _$FoodDetailErrorImpl;

  String get message;
  @override
  DateTime get currentDate;
  @override
  String get selectedPeriod;
  @override
  @JsonKey(ignore: true)
  _$$FoodDetailErrorImplCopyWith<_$FoodDetailErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
