class DateHelper {
  static String formatDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  static String formatDateForApi(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  static String getDayLabel(DateTime date) {
    final weekday = date.weekday;
    final day = date.day;

    final weekdayLetter = _getWeekdayLetter(weekday);
    return '$weekdayLetter\n$day';
  }

  static String _getWeekdayLetter(int weekday) {
    switch (weekday) {
      case 1:
        return 'M';
      case 2:
        return 'T';
      case 3:
        return 'W';
      case 4:
        return 'T';
      case 5:
        return 'F';
      case 6:
        return 'S';
      case 7:
        return 'S';
      default:
        return '';
    }
  }

  static DateTime getStartOfWeek(DateTime endDate) {
    return DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
    ).subtract(const Duration(days: 6));
  }

  static DateTime getEndOfWeek(DateTime endDate) {
    return DateTime(endDate.year, endDate.month, endDate.day + 1);
  }

  static DateTime getStartOfMonth(DateTime endDate) {
    return DateTime(endDate.year, endDate.month - 1, endDate.day);
  }

  static DateTime getEndOfMonth(DateTime endDate) {
    return DateTime(endDate.year, endDate.month, endDate.day + 1);
  }
}
