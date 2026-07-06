// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) {
  return _UserProfileModel.fromJson(json);
}

/// @nodoc
mixin _$UserProfileModel {
  String? get displayName => throw _privateConstructorUsedError;
  List<String> get goals => throw _privateConstructorUsedError;
  List<String> get barriers => throw _privateConstructorUsedError;
  List<String> get conditionTypes => throw _privateConstructorUsedError;
  List<String> get healthyHabits => throw _privateConstructorUsedError;
  String get mealPlanningFrequency => throw _privateConstructorUsedError;
  bool get wantsMealPlans => throw _privateConstructorUsedError;
  String get activityLevel => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  double get heightCm => throw _privateConstructorUsedError; // in cm
  double get currentWeightKg => throw _privateConstructorUsedError; // in kg
  double get startWeightKg => throw _privateConstructorUsedError; // in kg
  double get goalWeightKg => throw _privateConstructorUsedError; // in kg
  String get email => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  bool get isProfileComplete => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// From BE: `auth/me` nutritionTargets.targetCalories or onboarding preview.
  int get dailyCalorieTarget => throw _privateConstructorUsedError;
  double get macroCarbsG => throw _privateConstructorUsedError;
  double get macroProteinG => throw _privateConstructorUsedError;
  double get macroFatG => throw _privateConstructorUsedError;
  double get macroCarbsPercent => throw _privateConstructorUsedError;
  double get macroProteinPercent => throw _privateConstructorUsedError;
  double get macroFatPercent => throw _privateConstructorUsedError;

  /// From `auth/me` `nutritionalThresholds` (min/max bands per nutrient).
  List<UserNutritionalThreshold> get nutritionalThresholds =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserProfileModelCopyWith<UserProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileModelCopyWith<$Res> {
  factory $UserProfileModelCopyWith(
          UserProfileModel value, $Res Function(UserProfileModel) then) =
      _$UserProfileModelCopyWithImpl<$Res, UserProfileModel>;
  @useResult
  $Res call(
      {String? displayName,
      List<String> goals,
      List<String> barriers,
      List<String> conditionTypes,
      List<String> healthyHabits,
      String mealPlanningFrequency,
      bool wantsMealPlans,
      String activityLevel,
      String gender,
      int age,
      String country,
      double heightCm,
      double currentWeightKg,
      double startWeightKg,
      double goalWeightKg,
      String email,
      String? avatarUrl,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool isProfileComplete,
      String status,
      int dailyCalorieTarget,
      double macroCarbsG,
      double macroProteinG,
      double macroFatG,
      double macroCarbsPercent,
      double macroProteinPercent,
      double macroFatPercent,
      List<UserNutritionalThreshold> nutritionalThresholds});
}

/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res, $Val extends UserProfileModel>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? goals = null,
    Object? barriers = null,
    Object? conditionTypes = null,
    Object? healthyHabits = null,
    Object? mealPlanningFrequency = null,
    Object? wantsMealPlans = null,
    Object? activityLevel = null,
    Object? gender = null,
    Object? age = null,
    Object? country = null,
    Object? heightCm = null,
    Object? currentWeightKg = null,
    Object? startWeightKg = null,
    Object? goalWeightKg = null,
    Object? email = null,
    Object? avatarUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isProfileComplete = null,
    Object? status = null,
    Object? dailyCalorieTarget = null,
    Object? macroCarbsG = null,
    Object? macroProteinG = null,
    Object? macroFatG = null,
    Object? macroCarbsPercent = null,
    Object? macroProteinPercent = null,
    Object? macroFatPercent = null,
    Object? nutritionalThresholds = null,
  }) {
    return _then(_value.copyWith(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<String>,
      barriers: null == barriers
          ? _value.barriers
          : barriers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      conditionTypes: null == conditionTypes
          ? _value.conditionTypes
          : conditionTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      healthyHabits: null == healthyHabits
          ? _value.healthyHabits
          : healthyHabits // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mealPlanningFrequency: null == mealPlanningFrequency
          ? _value.mealPlanningFrequency
          : mealPlanningFrequency // ignore: cast_nullable_to_non_nullable
              as String,
      wantsMealPlans: null == wantsMealPlans
          ? _value.wantsMealPlans
          : wantsMealPlans // ignore: cast_nullable_to_non_nullable
              as bool,
      activityLevel: null == activityLevel
          ? _value.activityLevel
          : activityLevel // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      heightCm: null == heightCm
          ? _value.heightCm
          : heightCm // ignore: cast_nullable_to_non_nullable
              as double,
      currentWeightKg: null == currentWeightKg
          ? _value.currentWeightKg
          : currentWeightKg // ignore: cast_nullable_to_non_nullable
              as double,
      startWeightKg: null == startWeightKg
          ? _value.startWeightKg
          : startWeightKg // ignore: cast_nullable_to_non_nullable
              as double,
      goalWeightKg: null == goalWeightKg
          ? _value.goalWeightKg
          : goalWeightKg // ignore: cast_nullable_to_non_nullable
              as double,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isProfileComplete: null == isProfileComplete
          ? _value.isProfileComplete
          : isProfileComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      dailyCalorieTarget: null == dailyCalorieTarget
          ? _value.dailyCalorieTarget
          : dailyCalorieTarget // ignore: cast_nullable_to_non_nullable
              as int,
      macroCarbsG: null == macroCarbsG
          ? _value.macroCarbsG
          : macroCarbsG // ignore: cast_nullable_to_non_nullable
              as double,
      macroProteinG: null == macroProteinG
          ? _value.macroProteinG
          : macroProteinG // ignore: cast_nullable_to_non_nullable
              as double,
      macroFatG: null == macroFatG
          ? _value.macroFatG
          : macroFatG // ignore: cast_nullable_to_non_nullable
              as double,
      macroCarbsPercent: null == macroCarbsPercent
          ? _value.macroCarbsPercent
          : macroCarbsPercent // ignore: cast_nullable_to_non_nullable
              as double,
      macroProteinPercent: null == macroProteinPercent
          ? _value.macroProteinPercent
          : macroProteinPercent // ignore: cast_nullable_to_non_nullable
              as double,
      macroFatPercent: null == macroFatPercent
          ? _value.macroFatPercent
          : macroFatPercent // ignore: cast_nullable_to_non_nullable
              as double,
      nutritionalThresholds: null == nutritionalThresholds
          ? _value.nutritionalThresholds
          : nutritionalThresholds // ignore: cast_nullable_to_non_nullable
              as List<UserNutritionalThreshold>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfileModelImplCopyWith<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  factory _$$UserProfileModelImplCopyWith(_$UserProfileModelImpl value,
          $Res Function(_$UserProfileModelImpl) then) =
      __$$UserProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? displayName,
      List<String> goals,
      List<String> barriers,
      List<String> conditionTypes,
      List<String> healthyHabits,
      String mealPlanningFrequency,
      bool wantsMealPlans,
      String activityLevel,
      String gender,
      int age,
      String country,
      double heightCm,
      double currentWeightKg,
      double startWeightKg,
      double goalWeightKg,
      String email,
      String? avatarUrl,
      DateTime? createdAt,
      DateTime? updatedAt,
      bool isProfileComplete,
      String status,
      int dailyCalorieTarget,
      double macroCarbsG,
      double macroProteinG,
      double macroFatG,
      double macroCarbsPercent,
      double macroProteinPercent,
      double macroFatPercent,
      List<UserNutritionalThreshold> nutritionalThresholds});
}

/// @nodoc
class __$$UserProfileModelImplCopyWithImpl<$Res>
    extends _$UserProfileModelCopyWithImpl<$Res, _$UserProfileModelImpl>
    implements _$$UserProfileModelImplCopyWith<$Res> {
  __$$UserProfileModelImplCopyWithImpl(_$UserProfileModelImpl _value,
      $Res Function(_$UserProfileModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? goals = null,
    Object? barriers = null,
    Object? conditionTypes = null,
    Object? healthyHabits = null,
    Object? mealPlanningFrequency = null,
    Object? wantsMealPlans = null,
    Object? activityLevel = null,
    Object? gender = null,
    Object? age = null,
    Object? country = null,
    Object? heightCm = null,
    Object? currentWeightKg = null,
    Object? startWeightKg = null,
    Object? goalWeightKg = null,
    Object? email = null,
    Object? avatarUrl = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? isProfileComplete = null,
    Object? status = null,
    Object? dailyCalorieTarget = null,
    Object? macroCarbsG = null,
    Object? macroProteinG = null,
    Object? macroFatG = null,
    Object? macroCarbsPercent = null,
    Object? macroProteinPercent = null,
    Object? macroFatPercent = null,
    Object? nutritionalThresholds = null,
  }) {
    return _then(_$UserProfileModelImpl(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      goals: null == goals
          ? _value._goals
          : goals // ignore: cast_nullable_to_non_nullable
              as List<String>,
      barriers: null == barriers
          ? _value._barriers
          : barriers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      conditionTypes: null == conditionTypes
          ? _value._conditionTypes
          : conditionTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      healthyHabits: null == healthyHabits
          ? _value._healthyHabits
          : healthyHabits // ignore: cast_nullable_to_non_nullable
              as List<String>,
      mealPlanningFrequency: null == mealPlanningFrequency
          ? _value.mealPlanningFrequency
          : mealPlanningFrequency // ignore: cast_nullable_to_non_nullable
              as String,
      wantsMealPlans: null == wantsMealPlans
          ? _value.wantsMealPlans
          : wantsMealPlans // ignore: cast_nullable_to_non_nullable
              as bool,
      activityLevel: null == activityLevel
          ? _value.activityLevel
          : activityLevel // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      heightCm: null == heightCm
          ? _value.heightCm
          : heightCm // ignore: cast_nullable_to_non_nullable
              as double,
      currentWeightKg: null == currentWeightKg
          ? _value.currentWeightKg
          : currentWeightKg // ignore: cast_nullable_to_non_nullable
              as double,
      startWeightKg: null == startWeightKg
          ? _value.startWeightKg
          : startWeightKg // ignore: cast_nullable_to_non_nullable
              as double,
      goalWeightKg: null == goalWeightKg
          ? _value.goalWeightKg
          : goalWeightKg // ignore: cast_nullable_to_non_nullable
              as double,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isProfileComplete: null == isProfileComplete
          ? _value.isProfileComplete
          : isProfileComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      dailyCalorieTarget: null == dailyCalorieTarget
          ? _value.dailyCalorieTarget
          : dailyCalorieTarget // ignore: cast_nullable_to_non_nullable
              as int,
      macroCarbsG: null == macroCarbsG
          ? _value.macroCarbsG
          : macroCarbsG // ignore: cast_nullable_to_non_nullable
              as double,
      macroProteinG: null == macroProteinG
          ? _value.macroProteinG
          : macroProteinG // ignore: cast_nullable_to_non_nullable
              as double,
      macroFatG: null == macroFatG
          ? _value.macroFatG
          : macroFatG // ignore: cast_nullable_to_non_nullable
              as double,
      macroCarbsPercent: null == macroCarbsPercent
          ? _value.macroCarbsPercent
          : macroCarbsPercent // ignore: cast_nullable_to_non_nullable
              as double,
      macroProteinPercent: null == macroProteinPercent
          ? _value.macroProteinPercent
          : macroProteinPercent // ignore: cast_nullable_to_non_nullable
              as double,
      macroFatPercent: null == macroFatPercent
          ? _value.macroFatPercent
          : macroFatPercent // ignore: cast_nullable_to_non_nullable
              as double,
      nutritionalThresholds: null == nutritionalThresholds
          ? _value._nutritionalThresholds
          : nutritionalThresholds // ignore: cast_nullable_to_non_nullable
              as List<UserNutritionalThreshold>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileModelImpl extends _UserProfileModel {
  const _$UserProfileModelImpl(
      {this.displayName = '',
      final List<String> goals = const [],
      final List<String> barriers = const [],
      final List<String> conditionTypes = const [],
      final List<String> healthyHabits = const [],
      this.mealPlanningFrequency = '',
      this.wantsMealPlans = false,
      this.activityLevel = '',
      this.gender = '',
      this.age = 0,
      this.country = '',
      this.heightCm = 0.0,
      this.currentWeightKg = 0.0,
      this.startWeightKg = 0.0,
      this.goalWeightKg = 0.0,
      this.email = '',
      this.avatarUrl,
      this.createdAt,
      this.updatedAt,
      this.isProfileComplete = false,
      this.status = 'active',
      this.dailyCalorieTarget = 0,
      this.macroCarbsG = 0.0,
      this.macroProteinG = 0.0,
      this.macroFatG = 0.0,
      this.macroCarbsPercent = 0.0,
      this.macroProteinPercent = 0.0,
      this.macroFatPercent = 0.0,
      final List<UserNutritionalThreshold> nutritionalThresholds = const []})
      : _goals = goals,
        _barriers = barriers,
        _conditionTypes = conditionTypes,
        _healthyHabits = healthyHabits,
        _nutritionalThresholds = nutritionalThresholds,
        super._();

  factory _$UserProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileModelImplFromJson(json);

  @override
  @JsonKey()
  final String? displayName;
  final List<String> _goals;
  @override
  @JsonKey()
  List<String> get goals {
    if (_goals is EqualUnmodifiableListView) return _goals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_goals);
  }

  final List<String> _barriers;
  @override
  @JsonKey()
  List<String> get barriers {
    if (_barriers is EqualUnmodifiableListView) return _barriers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_barriers);
  }

  final List<String> _conditionTypes;
  @override
  @JsonKey()
  List<String> get conditionTypes {
    if (_conditionTypes is EqualUnmodifiableListView) return _conditionTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conditionTypes);
  }

  final List<String> _healthyHabits;
  @override
  @JsonKey()
  List<String> get healthyHabits {
    if (_healthyHabits is EqualUnmodifiableListView) return _healthyHabits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_healthyHabits);
  }

  @override
  @JsonKey()
  final String mealPlanningFrequency;
  @override
  @JsonKey()
  final bool wantsMealPlans;
  @override
  @JsonKey()
  final String activityLevel;
  @override
  @JsonKey()
  final String gender;
  @override
  @JsonKey()
  final int age;
  @override
  @JsonKey()
  final String country;
  @override
  @JsonKey()
  final double heightCm;
// in cm
  @override
  @JsonKey()
  final double currentWeightKg;
// in kg
  @override
  @JsonKey()
  final double startWeightKg;
// in kg
  @override
  @JsonKey()
  final double goalWeightKg;
// in kg
  @override
  @JsonKey()
  final String email;
  @override
  final String? avatarUrl;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  @JsonKey()
  final bool isProfileComplete;
  @override
  @JsonKey()
  final String status;

  /// From BE: `auth/me` nutritionTargets.targetCalories or onboarding preview.
  @override
  @JsonKey()
  final int dailyCalorieTarget;
  @override
  @JsonKey()
  final double macroCarbsG;
  @override
  @JsonKey()
  final double macroProteinG;
  @override
  @JsonKey()
  final double macroFatG;
  @override
  @JsonKey()
  final double macroCarbsPercent;
  @override
  @JsonKey()
  final double macroProteinPercent;
  @override
  @JsonKey()
  final double macroFatPercent;

  /// From `auth/me` `nutritionalThresholds` (min/max bands per nutrient).
  final List<UserNutritionalThreshold> _nutritionalThresholds;

  /// From `auth/me` `nutritionalThresholds` (min/max bands per nutrient).
  @override
  @JsonKey()
  List<UserNutritionalThreshold> get nutritionalThresholds {
    if (_nutritionalThresholds is EqualUnmodifiableListView)
      return _nutritionalThresholds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_nutritionalThresholds);
  }

  @override
  String toString() {
    return 'UserProfileModel(displayName: $displayName, goals: $goals, barriers: $barriers, conditionTypes: $conditionTypes, healthyHabits: $healthyHabits, mealPlanningFrequency: $mealPlanningFrequency, wantsMealPlans: $wantsMealPlans, activityLevel: $activityLevel, gender: $gender, age: $age, country: $country, heightCm: $heightCm, currentWeightKg: $currentWeightKg, startWeightKg: $startWeightKg, goalWeightKg: $goalWeightKg, email: $email, avatarUrl: $avatarUrl, createdAt: $createdAt, updatedAt: $updatedAt, isProfileComplete: $isProfileComplete, status: $status, dailyCalorieTarget: $dailyCalorieTarget, macroCarbsG: $macroCarbsG, macroProteinG: $macroProteinG, macroFatG: $macroFatG, macroCarbsPercent: $macroCarbsPercent, macroProteinPercent: $macroProteinPercent, macroFatPercent: $macroFatPercent, nutritionalThresholds: $nutritionalThresholds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileModelImpl &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            const DeepCollectionEquality().equals(other._goals, _goals) &&
            const DeepCollectionEquality().equals(other._barriers, _barriers) &&
            const DeepCollectionEquality()
                .equals(other._conditionTypes, _conditionTypes) &&
            const DeepCollectionEquality()
                .equals(other._healthyHabits, _healthyHabits) &&
            (identical(other.mealPlanningFrequency, mealPlanningFrequency) ||
                other.mealPlanningFrequency == mealPlanningFrequency) &&
            (identical(other.wantsMealPlans, wantsMealPlans) ||
                other.wantsMealPlans == wantsMealPlans) &&
            (identical(other.activityLevel, activityLevel) ||
                other.activityLevel == activityLevel) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.heightCm, heightCm) ||
                other.heightCm == heightCm) &&
            (identical(other.currentWeightKg, currentWeightKg) ||
                other.currentWeightKg == currentWeightKg) &&
            (identical(other.startWeightKg, startWeightKg) ||
                other.startWeightKg == startWeightKg) &&
            (identical(other.goalWeightKg, goalWeightKg) ||
                other.goalWeightKg == goalWeightKg) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isProfileComplete, isProfileComplete) ||
                other.isProfileComplete == isProfileComplete) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.dailyCalorieTarget, dailyCalorieTarget) ||
                other.dailyCalorieTarget == dailyCalorieTarget) &&
            (identical(other.macroCarbsG, macroCarbsG) ||
                other.macroCarbsG == macroCarbsG) &&
            (identical(other.macroProteinG, macroProteinG) ||
                other.macroProteinG == macroProteinG) &&
            (identical(other.macroFatG, macroFatG) ||
                other.macroFatG == macroFatG) &&
            (identical(other.macroCarbsPercent, macroCarbsPercent) ||
                other.macroCarbsPercent == macroCarbsPercent) &&
            (identical(other.macroProteinPercent, macroProteinPercent) ||
                other.macroProteinPercent == macroProteinPercent) &&
            (identical(other.macroFatPercent, macroFatPercent) ||
                other.macroFatPercent == macroFatPercent) &&
            const DeepCollectionEquality()
                .equals(other._nutritionalThresholds, _nutritionalThresholds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        displayName,
        const DeepCollectionEquality().hash(_goals),
        const DeepCollectionEquality().hash(_barriers),
        const DeepCollectionEquality().hash(_conditionTypes),
        const DeepCollectionEquality().hash(_healthyHabits),
        mealPlanningFrequency,
        wantsMealPlans,
        activityLevel,
        gender,
        age,
        country,
        heightCm,
        currentWeightKg,
        startWeightKg,
        goalWeightKg,
        email,
        avatarUrl,
        createdAt,
        updatedAt,
        isProfileComplete,
        status,
        dailyCalorieTarget,
        macroCarbsG,
        macroProteinG,
        macroFatG,
        macroCarbsPercent,
        macroProteinPercent,
        macroFatPercent,
        const DeepCollectionEquality().hash(_nutritionalThresholds)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      __$$UserProfileModelImplCopyWithImpl<_$UserProfileModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileModelImplToJson(
      this,
    );
  }
}

abstract class _UserProfileModel extends UserProfileModel {
  const factory _UserProfileModel(
          {final String? displayName,
          final List<String> goals,
          final List<String> barriers,
          final List<String> conditionTypes,
          final List<String> healthyHabits,
          final String mealPlanningFrequency,
          final bool wantsMealPlans,
          final String activityLevel,
          final String gender,
          final int age,
          final String country,
          final double heightCm,
          final double currentWeightKg,
          final double startWeightKg,
          final double goalWeightKg,
          final String email,
          final String? avatarUrl,
          final DateTime? createdAt,
          final DateTime? updatedAt,
          final bool isProfileComplete,
          final String status,
          final int dailyCalorieTarget,
          final double macroCarbsG,
          final double macroProteinG,
          final double macroFatG,
          final double macroCarbsPercent,
          final double macroProteinPercent,
          final double macroFatPercent,
          final List<UserNutritionalThreshold> nutritionalThresholds}) =
      _$UserProfileModelImpl;
  const _UserProfileModel._() : super._();

  factory _UserProfileModel.fromJson(Map<String, dynamic> json) =
      _$UserProfileModelImpl.fromJson;

  @override
  String? get displayName;
  @override
  List<String> get goals;
  @override
  List<String> get barriers;
  @override
  List<String> get conditionTypes;
  @override
  List<String> get healthyHabits;
  @override
  String get mealPlanningFrequency;
  @override
  bool get wantsMealPlans;
  @override
  String get activityLevel;
  @override
  String get gender;
  @override
  int get age;
  @override
  String get country;
  @override
  double get heightCm;
  @override // in cm
  double get currentWeightKg;
  @override // in kg
  double get startWeightKg;
  @override // in kg
  double get goalWeightKg;
  @override // in kg
  String get email;
  @override
  String? get avatarUrl;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  bool get isProfileComplete;
  @override
  String get status;
  @override

  /// From BE: `auth/me` nutritionTargets.targetCalories or onboarding preview.
  int get dailyCalorieTarget;
  @override
  double get macroCarbsG;
  @override
  double get macroProteinG;
  @override
  double get macroFatG;
  @override
  double get macroCarbsPercent;
  @override
  double get macroProteinPercent;
  @override
  double get macroFatPercent;
  @override

  /// From `auth/me` `nutritionalThresholds` (min/max bands per nutrient).
  List<UserNutritionalThreshold> get nutritionalThresholds;
  @override
  @JsonKey(ignore: true)
  _$$UserProfileModelImplCopyWith<_$UserProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
