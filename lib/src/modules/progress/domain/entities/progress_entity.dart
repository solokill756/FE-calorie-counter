import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../weight_form/data/model/weightForm_model.dart';
import '../../data/model/hip_model.dart';
import '../../data/model/neck_model.dart';
import '../../data/model/waist_model.dart';

part 'progress_entity.freezed.dart';
part 'progress_entity.g.dart';

@freezed
class ProgressEntry with _$ProgressEntry {
  const factory ProgressEntry({
    required String id,
    required DateTime date,
    required double value,
    String? photoUrl,
    required String type, // 'steps', 'weight', 'calories'
    String? notes,
  }) = _ProgressEntry;

  factory ProgressEntry.fromJson(Map<String, dynamic> json) =>
      _$ProgressEntryFromJson(json);

  static ProgressEntry convertToProgressEntry(dynamic data, String type) {
    switch (type.toLowerCase()) {
      case 'weights':
        final weightModel = WeightFormModel.fromJson(data);
        return ProgressEntry(
          id: weightModel.id?.toString() ?? '',
          date: weightModel.recordedAt,
          value: weightModel.weightKg,
          type: 'weights',
          photoUrl: weightModel.photoUrl,
        );
      case 'steps':
        // Assume steps API returns similar structure

        return ProgressEntry.fromJson(data);
      case 'calories':
        // Assume calories API returns similar structure
        return ProgressEntry.fromJson(data);
      case 'necks':
        final neckModel = NeckModel.fromJson(data);
        return ProgressEntry(
          id: neckModel.id?.toString() ?? '',
          date: neckModel.recordedAt,
          value: neckModel.neckCm,
          type: 'necks',
        );
      case 'waists':
        final waistModel = WaistModel.fromJson(data);
        return ProgressEntry(
          id: waistModel.id?.toString() ?? '',
          date: waistModel.recordedAt,
          value: waistModel.waistCm,
          type: 'waists',
        );
      case 'hips':
        final hipModel = HipModel.fromJson(data);
        return ProgressEntry(
          id: hipModel.id?.toString() ?? '',
          date: hipModel.recordedAt,
          value: hipModel.hipsCm,
          type: 'hips',
        );
      default:
        return ProgressEntry.fromJson(data);
    }
  }
}

@freezed
class ProgressStats with _$ProgressStats {
  const factory ProgressStats({
    required int currentStreak,
    required int bestStreak,
    required double total,
    required double average,
    required List<ProgressEntry> entries,
    required double startValue,
    required double currentValue,
    required double changeValue,
    required double changePercentage,
    required int totalEntries,
  }) = _ProgressStats;

  factory ProgressStats.fromJson(Map<String, dynamic> json) =>
      _$ProgressStatsFromJson(json);

  static ProgressStats convertToProgressStats(
    dynamic data,
    String type,
    int totalEntries,
  ) {
    try {
      // Nếu response đã là ProgressStats format
      if (data is Map<String, dynamic> &&
          data.containsKey('currentStreak') &&
          data.containsKey('bestStreak')) {
        return ProgressStats.fromJson(data);
      }

      if (data is Map<String, dynamic> && data['items'] is List) {
        final entries = (data['items'] as List)
            .map((item) => ProgressEntry.convertToProgressEntry(item, type))
            .toList();

        entries.sort((a, b) => a.date.compareTo(b.date));

        final responseStats = data['stats'];
        if (responseStats is Map<String, dynamic>) {
          final startValue =
              (responseStats['startValue'] as num?)?.toDouble() ??
              (entries.isNotEmpty ? entries.first.value : 0.0);
          final currentValue =
              (responseStats['currentValue'] as num?)?.toDouble() ??
              (entries.isNotEmpty ? entries.last.value : 0.0);
          final changeValue =
              (responseStats['changeValue'] as num?)?.toDouble() ??
              (entries.isNotEmpty ? currentValue - startValue : 0.0);
          final changePercentage =
              (responseStats['changePercentage'] as num?)?.toDouble() ??
              (startValue != 0 ? (changeValue / startValue) * 100 : 0.0);
          final entryTotal = (data['total'] as num?)?.toInt() ?? totalEntries;
          final total = entries.fold(0.0, (sum, entry) => sum + entry.value);
          final average = entries.isNotEmpty ? total / entries.length : 0.0;
          final streaks = _calculateStreaks(entries);

          return ProgressStats(
            currentStreak: streaks['current'] ?? 0,
            bestStreak: streaks['best'] ?? 0,
            total: total,
            average: average,
            entries: entries,
            startValue: startValue,
            currentValue: currentValue,
            changeValue: changeValue,
            changePercentage: changePercentage,
            totalEntries: entryTotal,
          );
        }

        data = entries;
      }

      // Nếu response là list các entries
      if (data is List) {
        final entries = data
            .map((item) => ProgressEntry.convertToProgressEntry(item, type))
            .toList();

        entries.sort((a, b) => a.date.compareTo(b.date));

        final total = entries.fold(0.0, (sum, entry) => sum + entry.value);
        final average = entries.isNotEmpty ? total / entries.length : 0.0;

        final streaks = _calculateStreaks(entries);

        return ProgressStats(
          currentStreak: streaks['current'] ?? 0,
          bestStreak: streaks['best'] ?? 0,
          total: total,
          average: average,
          entries: entries,
          startValue: entries.isNotEmpty ? entries.first.value : 0.0,
          currentValue: entries.isNotEmpty ? entries.last.value : 0.0,
          changeValue: entries.isNotEmpty
              ? entries.last.value - entries.first.value
              : 0.0,
          changePercentage: (entries.isNotEmpty && entries.first.value != 0.0)
              ? ((entries.last.value - entries.first.value) /
                        entries.first.value) *
                    100
              : 0.0,
          totalEntries: totalEntries,
        );
      }

      // Nếu response là single entry
      final entry = ProgressEntry.convertToProgressEntry(data, type);
      return ProgressStats(
        currentStreak: 1,
        bestStreak: 1,
        total: entry.value,
        average: entry.value,
        entries: [entry],
        startValue: entry.value,
        currentValue: entry.value,
        changeValue: 0.0,
        changePercentage: 0.0,
        totalEntries: 1,
      );
    } catch (e) {
      return ProgressStats(
        currentStreak: 0,
        bestStreak: 0,
        total: 0,
        average: 0,
        entries: [],
        startValue: 0.0,
        currentValue: 0.0,
        changeValue: 0.0,
        changePercentage: 0.0,
        totalEntries: 0,
      );
    }
  }

  static Map<String, int> _calculateStreaks(List<ProgressEntry> entries) {
    if (entries.isEmpty) return {'current': 0, 'best': 0};

    final sortedEntries = List<ProgressEntry>.from(entries);
    sortedEntries.sort((a, b) => a.date.compareTo(b.date));

    int currentStreak = 0;
    int bestStreak = 0;
    int tempStreak = 1;

    for (int i = 0; i < sortedEntries.length; i++) {
      if (i == 0) {
        tempStreak = 1;
        continue;
      }

      final dayDifference = sortedEntries[i].date
          .difference(sortedEntries[i - 1].date)
          .inDays;

      if (dayDifference == 1) {
        tempStreak++;
      } else if (dayDifference > 1) {
        if (tempStreak > bestStreak) {
          bestStreak = tempStreak;
        }
        tempStreak = 1;
      }
    }

    if (tempStreak > bestStreak) {
      bestStreak = tempStreak;
    }

    final now = DateTime.now();
    final lastEntry = sortedEntries.last;
    final daysSinceLastEntry = DateTime(now.year, now.month, now.day)
        .difference(
          DateTime(
            lastEntry.date.year,
            lastEntry.date.month,
            lastEntry.date.day,
          ),
        )
        .inDays;

    if (daysSinceLastEntry <= 1) {
      currentStreak = tempStreak;
    } else {
      currentStreak = 0;
    }

    return {'current': currentStreak, 'best': bestStreak};
  }
}

@freezed
class CharData with _$CharData {
  const factory CharData({
    required List<FlSpot> spots,
    required double minY,
    required double maxY,
    Color? color,
  }) = _CharData;
}

extension ProgressEntryExtension on ProgressStats {
  String get listDate {
    if (entries.isEmpty) return '';

    final displayDates = entries.map((e) {
      final day = e.date.day.toString().padLeft(2, '0');
      final month = e.date.month.toString().padLeft(2, '0');
      return '$day/$month';
    }).toList();

    return displayDates.join(', ');
  }

  CharData get chartData {
    if (entries.isEmpty) {
      return CharData(spots: [], minY: 0, maxY: 0, color: null);
    }

    final spots = entries
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), e.value.value))
        .toList();

    final values = entries.map((e) => e.value).toList();
    final minVal = values.reduce((a, b) => a < b ? a : b);
    final maxVal = values.reduce((a, b) => a > b ? a : b);
    const double padding = 1.0;
    final minY = minVal - padding;
    final maxY = maxVal + padding;
    final color = entries.first.type.toLowerCase() == 'weights'
        ? Color(0xFF4CAF50)
        : entries.first.type.toLowerCase() == 'steps'
        ? Color(0xFF2196F3)
        : Color(0xFFFF9800);

    return CharData(spots: spots, minY: minY, maxY: maxY, color: color);
  }

  double get weightLost {
    if (entries.isEmpty) return 0.0;
    final startWeight = entries.first.value;
    final currentWeight = entries.last.value;
    return startWeight - currentWeight;
  }
}
