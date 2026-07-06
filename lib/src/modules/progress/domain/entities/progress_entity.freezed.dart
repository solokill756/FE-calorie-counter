// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProgressEntry _$ProgressEntryFromJson(Map<String, dynamic> json) {
  return _ProgressEntry.fromJson(json);
}

/// @nodoc
mixin _$ProgressEntry {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  double get value => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  String get type =>
      throw _privateConstructorUsedError; // 'steps', 'weight', 'calories'
  String? get notes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgressEntryCopyWith<ProgressEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressEntryCopyWith<$Res> {
  factory $ProgressEntryCopyWith(
          ProgressEntry value, $Res Function(ProgressEntry) then) =
      _$ProgressEntryCopyWithImpl<$Res, ProgressEntry>;
  @useResult
  $Res call(
      {String id,
      DateTime date,
      double value,
      String? photoUrl,
      String type,
      String? notes});
}

/// @nodoc
class _$ProgressEntryCopyWithImpl<$Res, $Val extends ProgressEntry>
    implements $ProgressEntryCopyWith<$Res> {
  _$ProgressEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? value = null,
    Object? photoUrl = freezed,
    Object? type = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProgressEntryImplCopyWith<$Res>
    implements $ProgressEntryCopyWith<$Res> {
  factory _$$ProgressEntryImplCopyWith(
          _$ProgressEntryImpl value, $Res Function(_$ProgressEntryImpl) then) =
      __$$ProgressEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime date,
      double value,
      String? photoUrl,
      String type,
      String? notes});
}

/// @nodoc
class __$$ProgressEntryImplCopyWithImpl<$Res>
    extends _$ProgressEntryCopyWithImpl<$Res, _$ProgressEntryImpl>
    implements _$$ProgressEntryImplCopyWith<$Res> {
  __$$ProgressEntryImplCopyWithImpl(
      _$ProgressEntryImpl _value, $Res Function(_$ProgressEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? value = null,
    Object? photoUrl = freezed,
    Object? type = null,
    Object? notes = freezed,
  }) {
    return _then(_$ProgressEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgressEntryImpl implements _ProgressEntry {
  const _$ProgressEntryImpl(
      {required this.id,
      required this.date,
      required this.value,
      this.photoUrl,
      required this.type,
      this.notes});

  factory _$ProgressEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgressEntryImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;
  @override
  final double value;
  @override
  final String? photoUrl;
  @override
  final String type;
// 'steps', 'weight', 'calories'
  @override
  final String? notes;

  @override
  String toString() {
    return 'ProgressEntry(id: $id, date: $date, value: $value, photoUrl: $photoUrl, type: $type, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, date, value, photoUrl, type, notes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressEntryImplCopyWith<_$ProgressEntryImpl> get copyWith =>
      __$$ProgressEntryImplCopyWithImpl<_$ProgressEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgressEntryImplToJson(
      this,
    );
  }
}

abstract class _ProgressEntry implements ProgressEntry {
  const factory _ProgressEntry(
      {required final String id,
      required final DateTime date,
      required final double value,
      final String? photoUrl,
      required final String type,
      final String? notes}) = _$ProgressEntryImpl;

  factory _ProgressEntry.fromJson(Map<String, dynamic> json) =
      _$ProgressEntryImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  double get value;
  @override
  String? get photoUrl;
  @override
  String get type;
  @override // 'steps', 'weight', 'calories'
  String? get notes;
  @override
  @JsonKey(ignore: true)
  _$$ProgressEntryImplCopyWith<_$ProgressEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProgressStats _$ProgressStatsFromJson(Map<String, dynamic> json) {
  return _ProgressStats.fromJson(json);
}

/// @nodoc
mixin _$ProgressStats {
  int get currentStreak => throw _privateConstructorUsedError;
  int get bestStreak => throw _privateConstructorUsedError;
  double get total => throw _privateConstructorUsedError;
  double get average => throw _privateConstructorUsedError;
  List<ProgressEntry> get entries => throw _privateConstructorUsedError;
  double get startValue => throw _privateConstructorUsedError;
  double get currentValue => throw _privateConstructorUsedError;
  double get changeValue => throw _privateConstructorUsedError;
  double get changePercentage => throw _privateConstructorUsedError;
  int get totalEntries => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProgressStatsCopyWith<ProgressStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgressStatsCopyWith<$Res> {
  factory $ProgressStatsCopyWith(
          ProgressStats value, $Res Function(ProgressStats) then) =
      _$ProgressStatsCopyWithImpl<$Res, ProgressStats>;
  @useResult
  $Res call(
      {int currentStreak,
      int bestStreak,
      double total,
      double average,
      List<ProgressEntry> entries,
      double startValue,
      double currentValue,
      double changeValue,
      double changePercentage,
      int totalEntries});
}

/// @nodoc
class _$ProgressStatsCopyWithImpl<$Res, $Val extends ProgressStats>
    implements $ProgressStatsCopyWith<$Res> {
  _$ProgressStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStreak = null,
    Object? bestStreak = null,
    Object? total = null,
    Object? average = null,
    Object? entries = null,
    Object? startValue = null,
    Object? currentValue = null,
    Object? changeValue = null,
    Object? changePercentage = null,
    Object? totalEntries = null,
  }) {
    return _then(_value.copyWith(
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestStreak: null == bestStreak
          ? _value.bestStreak
          : bestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      average: null == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      entries: null == entries
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<ProgressEntry>,
      startValue: null == startValue
          ? _value.startValue
          : startValue // ignore: cast_nullable_to_non_nullable
              as double,
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double,
      changeValue: null == changeValue
          ? _value.changeValue
          : changeValue // ignore: cast_nullable_to_non_nullable
              as double,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      totalEntries: null == totalEntries
          ? _value.totalEntries
          : totalEntries // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProgressStatsImplCopyWith<$Res>
    implements $ProgressStatsCopyWith<$Res> {
  factory _$$ProgressStatsImplCopyWith(
          _$ProgressStatsImpl value, $Res Function(_$ProgressStatsImpl) then) =
      __$$ProgressStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentStreak,
      int bestStreak,
      double total,
      double average,
      List<ProgressEntry> entries,
      double startValue,
      double currentValue,
      double changeValue,
      double changePercentage,
      int totalEntries});
}

/// @nodoc
class __$$ProgressStatsImplCopyWithImpl<$Res>
    extends _$ProgressStatsCopyWithImpl<$Res, _$ProgressStatsImpl>
    implements _$$ProgressStatsImplCopyWith<$Res> {
  __$$ProgressStatsImplCopyWithImpl(
      _$ProgressStatsImpl _value, $Res Function(_$ProgressStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentStreak = null,
    Object? bestStreak = null,
    Object? total = null,
    Object? average = null,
    Object? entries = null,
    Object? startValue = null,
    Object? currentValue = null,
    Object? changeValue = null,
    Object? changePercentage = null,
    Object? totalEntries = null,
  }) {
    return _then(_$ProgressStatsImpl(
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestStreak: null == bestStreak
          ? _value.bestStreak
          : bestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as double,
      average: null == average
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double,
      entries: null == entries
          ? _value._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<ProgressEntry>,
      startValue: null == startValue
          ? _value.startValue
          : startValue // ignore: cast_nullable_to_non_nullable
              as double,
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double,
      changeValue: null == changeValue
          ? _value.changeValue
          : changeValue // ignore: cast_nullable_to_non_nullable
              as double,
      changePercentage: null == changePercentage
          ? _value.changePercentage
          : changePercentage // ignore: cast_nullable_to_non_nullable
              as double,
      totalEntries: null == totalEntries
          ? _value.totalEntries
          : totalEntries // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProgressStatsImpl implements _ProgressStats {
  const _$ProgressStatsImpl(
      {required this.currentStreak,
      required this.bestStreak,
      required this.total,
      required this.average,
      required final List<ProgressEntry> entries,
      required this.startValue,
      required this.currentValue,
      required this.changeValue,
      required this.changePercentage,
      required this.totalEntries})
      : _entries = entries;

  factory _$ProgressStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgressStatsImplFromJson(json);

  @override
  final int currentStreak;
  @override
  final int bestStreak;
  @override
  final double total;
  @override
  final double average;
  final List<ProgressEntry> _entries;
  @override
  List<ProgressEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

  @override
  final double startValue;
  @override
  final double currentValue;
  @override
  final double changeValue;
  @override
  final double changePercentage;
  @override
  final int totalEntries;

  @override
  String toString() {
    return 'ProgressStats(currentStreak: $currentStreak, bestStreak: $bestStreak, total: $total, average: $average, entries: $entries, startValue: $startValue, currentValue: $currentValue, changeValue: $changeValue, changePercentage: $changePercentage, totalEntries: $totalEntries)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgressStatsImpl &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.bestStreak, bestStreak) ||
                other.bestStreak == bestStreak) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.average, average) || other.average == average) &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.startValue, startValue) ||
                other.startValue == startValue) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.changeValue, changeValue) ||
                other.changeValue == changeValue) &&
            (identical(other.changePercentage, changePercentage) ||
                other.changePercentage == changePercentage) &&
            (identical(other.totalEntries, totalEntries) ||
                other.totalEntries == totalEntries));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentStreak,
      bestStreak,
      total,
      average,
      const DeepCollectionEquality().hash(_entries),
      startValue,
      currentValue,
      changeValue,
      changePercentage,
      totalEntries);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgressStatsImplCopyWith<_$ProgressStatsImpl> get copyWith =>
      __$$ProgressStatsImplCopyWithImpl<_$ProgressStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgressStatsImplToJson(
      this,
    );
  }
}

abstract class _ProgressStats implements ProgressStats {
  const factory _ProgressStats(
      {required final int currentStreak,
      required final int bestStreak,
      required final double total,
      required final double average,
      required final List<ProgressEntry> entries,
      required final double startValue,
      required final double currentValue,
      required final double changeValue,
      required final double changePercentage,
      required final int totalEntries}) = _$ProgressStatsImpl;

  factory _ProgressStats.fromJson(Map<String, dynamic> json) =
      _$ProgressStatsImpl.fromJson;

  @override
  int get currentStreak;
  @override
  int get bestStreak;
  @override
  double get total;
  @override
  double get average;
  @override
  List<ProgressEntry> get entries;
  @override
  double get startValue;
  @override
  double get currentValue;
  @override
  double get changeValue;
  @override
  double get changePercentage;
  @override
  int get totalEntries;
  @override
  @JsonKey(ignore: true)
  _$$ProgressStatsImplCopyWith<_$ProgressStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CharData {
  List<FlSpot> get spots => throw _privateConstructorUsedError;
  double get minY => throw _privateConstructorUsedError;
  double get maxY => throw _privateConstructorUsedError;
  Color? get color => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CharDataCopyWith<CharData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharDataCopyWith<$Res> {
  factory $CharDataCopyWith(CharData value, $Res Function(CharData) then) =
      _$CharDataCopyWithImpl<$Res, CharData>;
  @useResult
  $Res call({List<FlSpot> spots, double minY, double maxY, Color? color});
}

/// @nodoc
class _$CharDataCopyWithImpl<$Res, $Val extends CharData>
    implements $CharDataCopyWith<$Res> {
  _$CharDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spots = null,
    Object? minY = null,
    Object? maxY = null,
    Object? color = freezed,
  }) {
    return _then(_value.copyWith(
      spots: null == spots
          ? _value.spots
          : spots // ignore: cast_nullable_to_non_nullable
              as List<FlSpot>,
      minY: null == minY
          ? _value.minY
          : minY // ignore: cast_nullable_to_non_nullable
              as double,
      maxY: null == maxY
          ? _value.maxY
          : maxY // ignore: cast_nullable_to_non_nullable
              as double,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CharDataImplCopyWith<$Res>
    implements $CharDataCopyWith<$Res> {
  factory _$$CharDataImplCopyWith(
          _$CharDataImpl value, $Res Function(_$CharDataImpl) then) =
      __$$CharDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FlSpot> spots, double minY, double maxY, Color? color});
}

/// @nodoc
class __$$CharDataImplCopyWithImpl<$Res>
    extends _$CharDataCopyWithImpl<$Res, _$CharDataImpl>
    implements _$$CharDataImplCopyWith<$Res> {
  __$$CharDataImplCopyWithImpl(
      _$CharDataImpl _value, $Res Function(_$CharDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? spots = null,
    Object? minY = null,
    Object? maxY = null,
    Object? color = freezed,
  }) {
    return _then(_$CharDataImpl(
      spots: null == spots
          ? _value._spots
          : spots // ignore: cast_nullable_to_non_nullable
              as List<FlSpot>,
      minY: null == minY
          ? _value.minY
          : minY // ignore: cast_nullable_to_non_nullable
              as double,
      maxY: null == maxY
          ? _value.maxY
          : maxY // ignore: cast_nullable_to_non_nullable
              as double,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
    ));
  }
}

/// @nodoc

class _$CharDataImpl implements _CharData {
  const _$CharDataImpl(
      {required final List<FlSpot> spots,
      required this.minY,
      required this.maxY,
      this.color})
      : _spots = spots;

  final List<FlSpot> _spots;
  @override
  List<FlSpot> get spots {
    if (_spots is EqualUnmodifiableListView) return _spots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_spots);
  }

  @override
  final double minY;
  @override
  final double maxY;
  @override
  final Color? color;

  @override
  String toString() {
    return 'CharData(spots: $spots, minY: $minY, maxY: $maxY, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharDataImpl &&
            const DeepCollectionEquality().equals(other._spots, _spots) &&
            (identical(other.minY, minY) || other.minY == minY) &&
            (identical(other.maxY, maxY) || other.maxY == maxY) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_spots), minY, maxY, color);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CharDataImplCopyWith<_$CharDataImpl> get copyWith =>
      __$$CharDataImplCopyWithImpl<_$CharDataImpl>(this, _$identity);
}

abstract class _CharData implements CharData {
  const factory _CharData(
      {required final List<FlSpot> spots,
      required final double minY,
      required final double maxY,
      final Color? color}) = _$CharDataImpl;

  @override
  List<FlSpot> get spots;
  @override
  double get minY;
  @override
  double get maxY;
  @override
  Color? get color;
  @override
  @JsonKey(ignore: true)
  _$$CharDataImplCopyWith<_$CharDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
