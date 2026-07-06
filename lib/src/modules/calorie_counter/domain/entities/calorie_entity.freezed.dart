// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calorie_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CalorieEntity _$CalorieEntityFromJson(Map<String, dynamic> json) {
  return _CalorieEntity.fromJson(json);
}

/// @nodoc
mixin _$CalorieEntity {
  int get goal => throw _privateConstructorUsedError;
  int get consumed => throw _privateConstructorUsedError;
  int get burned => throw _privateConstructorUsedError;
  int get remaining => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalorieEntityCopyWith<CalorieEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalorieEntityCopyWith<$Res> {
  factory $CalorieEntityCopyWith(
          CalorieEntity value, $Res Function(CalorieEntity) then) =
      _$CalorieEntityCopyWithImpl<$Res, CalorieEntity>;
  @useResult
  $Res call({int goal, int consumed, int burned, int remaining, DateTime date});
}

/// @nodoc
class _$CalorieEntityCopyWithImpl<$Res, $Val extends CalorieEntity>
    implements $CalorieEntityCopyWith<$Res> {
  _$CalorieEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goal = null,
    Object? consumed = null,
    Object? burned = null,
    Object? remaining = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as int,
      consumed: null == consumed
          ? _value.consumed
          : consumed // ignore: cast_nullable_to_non_nullable
              as int,
      burned: null == burned
          ? _value.burned
          : burned // ignore: cast_nullable_to_non_nullable
              as int,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalorieEntityImplCopyWith<$Res>
    implements $CalorieEntityCopyWith<$Res> {
  factory _$$CalorieEntityImplCopyWith(
          _$CalorieEntityImpl value, $Res Function(_$CalorieEntityImpl) then) =
      __$$CalorieEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int goal, int consumed, int burned, int remaining, DateTime date});
}

/// @nodoc
class __$$CalorieEntityImplCopyWithImpl<$Res>
    extends _$CalorieEntityCopyWithImpl<$Res, _$CalorieEntityImpl>
    implements _$$CalorieEntityImplCopyWith<$Res> {
  __$$CalorieEntityImplCopyWithImpl(
      _$CalorieEntityImpl _value, $Res Function(_$CalorieEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goal = null,
    Object? consumed = null,
    Object? burned = null,
    Object? remaining = null,
    Object? date = null,
  }) {
    return _then(_$CalorieEntityImpl(
      goal: null == goal
          ? _value.goal
          : goal // ignore: cast_nullable_to_non_nullable
              as int,
      consumed: null == consumed
          ? _value.consumed
          : consumed // ignore: cast_nullable_to_non_nullable
              as int,
      burned: null == burned
          ? _value.burned
          : burned // ignore: cast_nullable_to_non_nullable
              as int,
      remaining: null == remaining
          ? _value.remaining
          : remaining // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalorieEntityImpl implements _CalorieEntity {
  const _$CalorieEntityImpl(
      {required this.goal,
      required this.consumed,
      required this.burned,
      required this.remaining,
      required this.date});

  factory _$CalorieEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalorieEntityImplFromJson(json);

  @override
  final int goal;
  @override
  final int consumed;
  @override
  final int burned;
  @override
  final int remaining;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'CalorieEntity(goal: $goal, consumed: $consumed, burned: $burned, remaining: $remaining, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalorieEntityImpl &&
            (identical(other.goal, goal) || other.goal == goal) &&
            (identical(other.consumed, consumed) ||
                other.consumed == consumed) &&
            (identical(other.burned, burned) || other.burned == burned) &&
            (identical(other.remaining, remaining) ||
                other.remaining == remaining) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, goal, consumed, burned, remaining, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalorieEntityImplCopyWith<_$CalorieEntityImpl> get copyWith =>
      __$$CalorieEntityImplCopyWithImpl<_$CalorieEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalorieEntityImplToJson(
      this,
    );
  }
}

abstract class _CalorieEntity implements CalorieEntity {
  const factory _CalorieEntity(
      {required final int goal,
      required final int consumed,
      required final int burned,
      required final int remaining,
      required final DateTime date}) = _$CalorieEntityImpl;

  factory _CalorieEntity.fromJson(Map<String, dynamic> json) =
      _$CalorieEntityImpl.fromJson;

  @override
  int get goal;
  @override
  int get consumed;
  @override
  int get burned;
  @override
  int get remaining;
  @override
  DateTime get date;
  @override
  @JsonKey(ignore: true)
  _$$CalorieEntityImplCopyWith<_$CalorieEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MacroEntity _$MacroEntityFromJson(Map<String, dynamic> json) {
  return _MacroEntity.fromJson(json);
}

/// @nodoc
mixin _$MacroEntity {
  double get carbs => throw _privateConstructorUsedError;
  double get protein => throw _privateConstructorUsedError;
  double get fat => throw _privateConstructorUsedError;
  double get fiber => throw _privateConstructorUsedError;
  double get sugar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MacroEntityCopyWith<MacroEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MacroEntityCopyWith<$Res> {
  factory $MacroEntityCopyWith(
          MacroEntity value, $Res Function(MacroEntity) then) =
      _$MacroEntityCopyWithImpl<$Res, MacroEntity>;
  @useResult
  $Res call(
      {double carbs, double protein, double fat, double fiber, double sugar});
}

/// @nodoc
class _$MacroEntityCopyWithImpl<$Res, $Val extends MacroEntity>
    implements $MacroEntityCopyWith<$Res> {
  _$MacroEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? carbs = null,
    Object? protein = null,
    Object? fat = null,
    Object? fiber = null,
    Object? sugar = null,
  }) {
    return _then(_value.copyWith(
      carbs: null == carbs
          ? _value.carbs
          : carbs // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      fiber: null == fiber
          ? _value.fiber
          : fiber // ignore: cast_nullable_to_non_nullable
              as double,
      sugar: null == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MacroEntityImplCopyWith<$Res>
    implements $MacroEntityCopyWith<$Res> {
  factory _$$MacroEntityImplCopyWith(
          _$MacroEntityImpl value, $Res Function(_$MacroEntityImpl) then) =
      __$$MacroEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double carbs, double protein, double fat, double fiber, double sugar});
}

/// @nodoc
class __$$MacroEntityImplCopyWithImpl<$Res>
    extends _$MacroEntityCopyWithImpl<$Res, _$MacroEntityImpl>
    implements _$$MacroEntityImplCopyWith<$Res> {
  __$$MacroEntityImplCopyWithImpl(
      _$MacroEntityImpl _value, $Res Function(_$MacroEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? carbs = null,
    Object? protein = null,
    Object? fat = null,
    Object? fiber = null,
    Object? sugar = null,
  }) {
    return _then(_$MacroEntityImpl(
      carbs: null == carbs
          ? _value.carbs
          : carbs // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      fiber: null == fiber
          ? _value.fiber
          : fiber // ignore: cast_nullable_to_non_nullable
              as double,
      sugar: null == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MacroEntityImpl implements _MacroEntity {
  const _$MacroEntityImpl(
      {required this.carbs,
      required this.protein,
      required this.fat,
      required this.fiber,
      required this.sugar});

  factory _$MacroEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$MacroEntityImplFromJson(json);

  @override
  final double carbs;
  @override
  final double protein;
  @override
  final double fat;
  @override
  final double fiber;
  @override
  final double sugar;

  @override
  String toString() {
    return 'MacroEntity(carbs: $carbs, protein: $protein, fat: $fat, fiber: $fiber, sugar: $sugar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MacroEntityImpl &&
            (identical(other.carbs, carbs) || other.carbs == carbs) &&
            (identical(other.protein, protein) || other.protein == protein) &&
            (identical(other.fat, fat) || other.fat == fat) &&
            (identical(other.fiber, fiber) || other.fiber == fiber) &&
            (identical(other.sugar, sugar) || other.sugar == sugar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, carbs, protein, fat, fiber, sugar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MacroEntityImplCopyWith<_$MacroEntityImpl> get copyWith =>
      __$$MacroEntityImplCopyWithImpl<_$MacroEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MacroEntityImplToJson(
      this,
    );
  }
}

abstract class _MacroEntity implements MacroEntity {
  const factory _MacroEntity(
      {required final double carbs,
      required final double protein,
      required final double fat,
      required final double fiber,
      required final double sugar}) = _$MacroEntityImpl;

  factory _MacroEntity.fromJson(Map<String, dynamic> json) =
      _$MacroEntityImpl.fromJson;

  @override
  double get carbs;
  @override
  double get protein;
  @override
  double get fat;
  @override
  double get fiber;
  @override
  double get sugar;
  @override
  @JsonKey(ignore: true)
  _$$MacroEntityImplCopyWith<_$MacroEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActivityEntity _$ActivityEntityFromJson(Map<String, dynamic> json) {
  return _ActivityEntity.fromJson(json);
}

/// @nodoc
mixin _$ActivityEntity {
  String get type => throw _privateConstructorUsedError;
  int get calories => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActivityEntityCopyWith<ActivityEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityEntityCopyWith<$Res> {
  factory $ActivityEntityCopyWith(
          ActivityEntity value, $Res Function(ActivityEntity) then) =
      _$ActivityEntityCopyWithImpl<$Res, ActivityEntity>;
  @useResult
  $Res call({String type, int calories, Duration duration, DateTime date});
}

/// @nodoc
class _$ActivityEntityCopyWithImpl<$Res, $Val extends ActivityEntity>
    implements $ActivityEntityCopyWith<$Res> {
  _$ActivityEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? calories = null,
    Object? duration = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityEntityImplCopyWith<$Res>
    implements $ActivityEntityCopyWith<$Res> {
  factory _$$ActivityEntityImplCopyWith(_$ActivityEntityImpl value,
          $Res Function(_$ActivityEntityImpl) then) =
      __$$ActivityEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, int calories, Duration duration, DateTime date});
}

/// @nodoc
class __$$ActivityEntityImplCopyWithImpl<$Res>
    extends _$ActivityEntityCopyWithImpl<$Res, _$ActivityEntityImpl>
    implements _$$ActivityEntityImplCopyWith<$Res> {
  __$$ActivityEntityImplCopyWithImpl(
      _$ActivityEntityImpl _value, $Res Function(_$ActivityEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? calories = null,
    Object? duration = null,
    Object? date = null,
  }) {
    return _then(_$ActivityEntityImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityEntityImpl implements _ActivityEntity {
  const _$ActivityEntityImpl(
      {required this.type,
      required this.calories,
      required this.duration,
      required this.date});

  factory _$ActivityEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityEntityImplFromJson(json);

  @override
  final String type;
  @override
  final int calories;
  @override
  final Duration duration;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'ActivityEntity(type: $type, calories: $calories, duration: $duration, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityEntityImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, calories, duration, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityEntityImplCopyWith<_$ActivityEntityImpl> get copyWith =>
      __$$ActivityEntityImplCopyWithImpl<_$ActivityEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityEntityImplToJson(
      this,
    );
  }
}

abstract class _ActivityEntity implements ActivityEntity {
  const factory _ActivityEntity(
      {required final String type,
      required final int calories,
      required final Duration duration,
      required final DateTime date}) = _$ActivityEntityImpl;

  factory _ActivityEntity.fromJson(Map<String, dynamic> json) =
      _$ActivityEntityImpl.fromJson;

  @override
  String get type;
  @override
  int get calories;
  @override
  Duration get duration;
  @override
  DateTime get date;
  @override
  @JsonKey(ignore: true)
  _$$ActivityEntityImplCopyWith<_$ActivityEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WeightEntity _$WeightEntityFromJson(Map<String, dynamic> json) {
  return _WeightEntity.fromJson(json);
}

/// @nodoc
mixin _$WeightEntity {
  double get weight => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeightEntityCopyWith<WeightEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeightEntityCopyWith<$Res> {
  factory $WeightEntityCopyWith(
          WeightEntity value, $Res Function(WeightEntity) then) =
      _$WeightEntityCopyWithImpl<$Res, WeightEntity>;
  @useResult
  $Res call({double weight, DateTime date});
}

/// @nodoc
class _$WeightEntityCopyWithImpl<$Res, $Val extends WeightEntity>
    implements $WeightEntityCopyWith<$Res> {
  _$WeightEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weight = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeightEntityImplCopyWith<$Res>
    implements $WeightEntityCopyWith<$Res> {
  factory _$$WeightEntityImplCopyWith(
          _$WeightEntityImpl value, $Res Function(_$WeightEntityImpl) then) =
      __$$WeightEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double weight, DateTime date});
}

/// @nodoc
class __$$WeightEntityImplCopyWithImpl<$Res>
    extends _$WeightEntityCopyWithImpl<$Res, _$WeightEntityImpl>
    implements _$$WeightEntityImplCopyWith<$Res> {
  __$$WeightEntityImplCopyWithImpl(
      _$WeightEntityImpl _value, $Res Function(_$WeightEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weight = null,
    Object? date = null,
  }) {
    return _then(_$WeightEntityImpl(
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeightEntityImpl implements _WeightEntity {
  const _$WeightEntityImpl({required this.weight, required this.date});

  factory _$WeightEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeightEntityImplFromJson(json);

  @override
  final double weight;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'WeightEntity(weight: $weight, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeightEntityImpl &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, weight, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeightEntityImplCopyWith<_$WeightEntityImpl> get copyWith =>
      __$$WeightEntityImplCopyWithImpl<_$WeightEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeightEntityImplToJson(
      this,
    );
  }
}

abstract class _WeightEntity implements WeightEntity {
  const factory _WeightEntity(
      {required final double weight,
      required final DateTime date}) = _$WeightEntityImpl;

  factory _WeightEntity.fromJson(Map<String, dynamic> json) =
      _$WeightEntityImpl.fromJson;

  @override
  double get weight;
  @override
  DateTime get date;
  @override
  @JsonKey(ignore: true)
  _$$WeightEntityImplCopyWith<_$WeightEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
