// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProgressEntryImpl _$$ProgressEntryImplFromJson(Map<String, dynamic> json) =>
    _$ProgressEntryImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      value: (json['value'] as num).toDouble(),
      photoUrl: json['photoUrl'] as String?,
      type: json['type'] as String,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$ProgressEntryImplToJson(_$ProgressEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'value': instance.value,
      'photoUrl': instance.photoUrl,
      'type': instance.type,
      'notes': instance.notes,
    };

_$ProgressStatsImpl _$$ProgressStatsImplFromJson(Map<String, dynamic> json) =>
    _$ProgressStatsImpl(
      currentStreak: (json['currentStreak'] as num).toInt(),
      bestStreak: (json['bestStreak'] as num).toInt(),
      total: (json['total'] as num).toDouble(),
      average: (json['average'] as num).toDouble(),
      entries: (json['entries'] as List<dynamic>)
          .map((e) => ProgressEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      startValue: (json['startValue'] as num).toDouble(),
      currentValue: (json['currentValue'] as num).toDouble(),
      changeValue: (json['changeValue'] as num).toDouble(),
      changePercentage: (json['changePercentage'] as num).toDouble(),
      totalEntries: (json['totalEntries'] as num).toInt(),
    );

Map<String, dynamic> _$$ProgressStatsImplToJson(_$ProgressStatsImpl instance) =>
    <String, dynamic>{
      'currentStreak': instance.currentStreak,
      'bestStreak': instance.bestStreak,
      'total': instance.total,
      'average': instance.average,
      'entries': instance.entries.map((e) => e.toJson()).toList(),
      'startValue': instance.startValue,
      'currentValue': instance.currentValue,
      'changeValue': instance.changeValue,
      'changePercentage': instance.changePercentage,
      'totalEntries': instance.totalEntries,
    };
