import 'dart:io';

import 'package:caloriecounter/src/modules/progress/domain/entities/progress_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class CsvExportService {
  /// Export progress entries to CSV file
  static Future<String?> exportProgressToCsv({
    required List<ProgressEntry> entries,
    required String measurementType,
  }) async {
    try {
      if (entries.isEmpty) {
        return null;
      }

      // Create CSV content
      final csvContent = _generateCsvContent(entries, measurementType);

      // Get temporary directory
      final directory = await getTemporaryDirectory();

      // Create filename with timestamp
      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final filename = '${measurementType}_progress_$timestamp.csv';
      final file = File('${directory.path}/$filename');

      // Write CSV content to file
      await file.writeAsString(csvContent);

      return file.path;
    } catch (e) {
      debugPrint('Error exporting CSV: $e');
      return null;
    }
  }

  /// Generate CSV content from progress entries
  static String _generateCsvContent(
    List<ProgressEntry> entries,
    String measurementType,
  ) {
    final buffer = StringBuffer();

    // Add header
    final unit = _getMeasurementUnit(measurementType);
    buffer.writeln('Date,Value ($unit),Type,Notes');

    // Sort entries by date (oldest first)
    final sortedEntries = List<ProgressEntry>.from(entries)
      ..sort((a, b) => a.date.compareTo(b.date));

    // Add data rows
    for (final entry in sortedEntries) {
      final date = DateFormat('yyyy-MM-dd').format(entry.date);
      final value = entry.value.toStringAsFixed(2);
      final type = entry.type;
      final notes =
          entry.notes?.replaceAll(',', ';') ?? ''; // Replace commas in notes

      buffer.writeln('$date,$value,$type,$notes');
    }

    return buffer.toString();
  }

  /// Get measurement unit for CSV header
  static String _getMeasurementUnit(String measurementType) {
    switch (measurementType.toLowerCase()) {
      case 'weights':
        return 'kg';
      case 'steps':
        return 'steps';
      case 'necks':
      case 'waists':
      case 'hips':
        return 'cm';
      case 'calories':
        return 'kcal';
      default:
        return '';
    }
  }

  /// Share CSV file
  static Future<void> shareCsvFile(String filePath, String filename) async {
    try {
      final file = XFile(filePath);
      await Share.shareXFiles(
        [file],
        text: 'Progress data export: $filename',
        subject: 'Progress Data Export',
      );
    } catch (e) {
      debugPrint('Error sharing CSV file: $e');
      rethrow;
    }
  }

  /// Export all progress types to separate CSV files
  static Future<List<String>> exportAllProgressTypes({
    required Map<String, List<ProgressEntry>> allEntries,
  }) async {
    final exportedFiles = <String>[];

    for (final entry in allEntries.entries) {
      final measurementType = entry.key;
      final entries = entry.value;

      if (entries.isNotEmpty) {
        final filePath = await exportProgressToCsv(
          entries: entries,
          measurementType: measurementType,
        );

        if (filePath != null) {
          exportedFiles.add(filePath);
        }
      }
    }

    return exportedFiles;
  }
}
