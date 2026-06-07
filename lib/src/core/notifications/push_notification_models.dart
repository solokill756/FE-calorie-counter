enum NotificationReminderType {
  water('water', 'Water', true, 10, 0),
  mealLog('meal_log', 'Meal logging', true, 19, 30),
  weight('weight', 'Weight', false, 8, 0),
  exercise('exercise', 'Exercise', false, 18, 0);

  const NotificationReminderType(
    this.apiValue,
    this.label,
    this.defaultEnabled,
    this.defaultHour,
    this.defaultMinute,
  );

  final String apiValue;
  final String label;
  final bool defaultEnabled;
  final int defaultHour;
  final int defaultMinute;

  static NotificationReminderType fromApiValue(String value) {
    return NotificationReminderType.values.firstWhere(
      (item) => item.apiValue == value,
      orElse: () => NotificationReminderType.water,
    );
  }
}

class NotificationPreference {
  const NotificationPreference({
    required this.type,
    required this.enabled,
    required this.hour,
    required this.minute,
    required this.timezone,
  });

  final NotificationReminderType type;
  final bool enabled;
  final int hour;
  final int minute;
  final String timezone;

  factory NotificationPreference.fromJson(Map<String, dynamic> json) {
    return NotificationPreference(
      type: NotificationReminderType.fromApiValue(json['type'] as String? ?? 'water'),
      enabled: json['enabled'] as bool? ?? false,
      hour: json['hour'] as int? ?? 0,
      minute: json['minute'] as int? ?? 0,
      timezone: json['timezone'] as String? ?? 'UTC',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type.apiValue,
      'enabled': enabled,
      'hour': hour,
      'minute': minute,
      'timezone': timezone,
    };
  }

  NotificationPreference copyWith({
    bool? enabled,
    int? hour,
    int? minute,
    String? timezone,
  }) {
    return NotificationPreference(
      type: type,
      enabled: enabled ?? this.enabled,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      timezone: timezone ?? this.timezone,
    );
  }
}
