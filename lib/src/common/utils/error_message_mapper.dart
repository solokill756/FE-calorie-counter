import '../../core/data/remote/base/api_error.dart';

class ErrorMessageMapper {
  ErrorMessageMapper._();

  static String messageFor(
    Object error, {
    String fallbackMessage = 'Something went wrong. Please try again.',
    String? featureLabel,
  }) {
    if (error is ApiError) {
      final message = error.message.trim();
      if (message.isNotEmpty) {
        return message;
      }
      return fallbackMessage;
    }

    final raw = error
        .toString()
        .replaceFirst(RegExp(r'^Exception:\s*'), '')
        .trim();
    if (raw.isEmpty) {
      return fallbackMessage;
    }

    final legacyPattern = RegExp(r'^Diary API error \(([^)]+)\):\s*(.+)$');
    final legacyMatch = legacyPattern.firstMatch(raw);
    if (legacyMatch != null) {
      final statusCode = legacyMatch.group(1)?.trim();
      final detail = legacyMatch.group(2)?.trim();

      if (statusCode == '500') {
        return featureLabel == null
            ? 'Unable to load data. Please try again later.'
            : 'Unable to load $featureLabel data. Please try again later.';
      }

      if (detail != null &&
          detail.isNotEmpty &&
          detail.toLowerCase() != 'unexpected error') {
        return detail;
      }

      return featureLabel == null
          ? 'Unable to load data. Please try again.'
          : 'Unable to load $featureLabel data. Please try again.';
    }

    if (raw.toLowerCase() == 'unexpected error') {
      return fallbackMessage;
    }

    return raw;
  }
}
