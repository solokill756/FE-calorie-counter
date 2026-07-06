import 'date_helper.dart';

class NutritionDateRange {
  final DateTime start;
  final DateTime end;

  const NutritionDateRange({
    required this.start,
    required this.end,
  });

  String get startApi => DateHelper.formatDateForApi(start);
  String get endApi => DateHelper.formatDateForApi(end);
  int get dayCount => end.difference(start).inDays + 1;
}

class NutritionDateRangeHelper {
  static const String dayView = 'Day View';
  static const String weekView = 'Week View';
  static const String monthView = 'Month View';

  static const List<String> periods = [dayView, weekView, monthView];

  static DateTime dateOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  static NutritionDateRange forPeriod(DateTime anchorDate, String period) {
    final anchor = dateOnly(anchorDate);

    switch (period) {
      case dayView:
        return NutritionDateRange(start: anchor, end: anchor);
      case monthView:
        final start = DateTime(anchor.year, anchor.month, 1);
        final end = DateTime(anchor.year, anchor.month + 1, 0);
        return NutritionDateRange(start: start, end: end);
      case weekView:
      default:
        return NutritionDateRange(
          start: anchor.subtract(const Duration(days: 6)),
          end: anchor,
        );
    }
  }

  static DateTime previous(DateTime currentDate, String period) {
    switch (period) {
      case dayView:
        return dateOnly(currentDate).subtract(const Duration(days: 1));
      case monthView:
        return DateTime(currentDate.year, currentDate.month - 1, 1);
      case weekView:
      default:
        return dateOnly(currentDate).subtract(const Duration(days: 7));
    }
  }

  static DateTime next(DateTime currentDate, String period) {
    switch (period) {
      case dayView:
        return dateOnly(currentDate).add(const Duration(days: 1));
      case monthView:
        return DateTime(currentDate.year, currentDate.month + 1, 1);
      case weekView:
      default:
        return dateOnly(currentDate).add(const Duration(days: 7));
    }
  }
}
