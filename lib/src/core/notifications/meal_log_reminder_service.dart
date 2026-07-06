import 'dart:async';
import 'dart:io';

import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:caloriecounter/src/modules/app/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Schedules one local reminder per day to log food — no diary sync.
class MealLogReminderService {
  MealLogReminderService._();

  static final MealLogReminderService instance = MealLogReminderService._();

  static const _channelId = 'meal_log_reminders';
  static const _channelName = 'Meal reminders';
  static const _channelDescription = 'Daily reminder to log food';
  static const _payloadPrefix = 'daily-log-reminder';
  static const _rollingWindowDays = 7;
  static const _reminderHour = 0;
  static const _reminderMinute = 0;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  bool _timezoneConfigured = false;
  Future<void>? _scheduleInFlight;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    await _configureLocalTimezone();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );

    final androidImpl = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidImpl?.requestNotificationsPermission();
  }

  Future<void> scheduleRollingWindow() {
    _scheduleInFlight ??= _scheduleRollingWindow().whenComplete(() {
      _scheduleInFlight = null;
    });
    return _scheduleInFlight!;
  }

  Future<void> cancelMealReminders() async {
    await init();
    final today = _dateOnly(DateTime.now());
    for (var offset = -1; offset < _rollingWindowDays + 1; offset++) {
      await _plugin.cancel(_notificationId(today.add(Duration(days: offset))));
    }
  }

  Future<void> _scheduleRollingWindow() async {
    await init();
    final now = DateTime.now();
    final today = _dateOnly(now);

    for (var offset = 0; offset < _rollingWindowDays; offset++) {
      final date = today.add(Duration(days: offset));
      final scheduledAt = DateTime(
        date.year,
        date.month,
        date.day,
        _reminderHour,
        _reminderMinute,
      );
      final id = _notificationId(date);

      if (!scheduledAt.isAfter(now)) {
        await _plugin.cancel(id);
        continue;
      }

      await _plugin.zonedSchedule(
        id,
        'Log your meals',
        'Start the day by logging what you eat.',
        tz.TZDateTime.from(scheduledAt, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: _channelDescription,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: _payloadFor(date),
      );
    }
  }

  Future<void> _configureLocalTimezone() async {
    if (_timezoneConfigured || kIsWeb || Platform.isLinux) return;
    _timezoneConfigured = true;
    tz.initializeTimeZones();
    try {
      final timeZone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZone.identifier));
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Meal reminders: timezone fallback to local default: $e');
      }
    }
  }

  void _onNotificationResponse(NotificationResponse response) {
    final date = _parsePayloadDate(response.payload);
    if (date == null) return;
    unawaited(getIt<AppRouter>().push<void>(LogFoodRoute(forDate: date)));
  }

  int _notificationId(DateTime date) {
    final d = _dateOnly(date);
    return d.year * 10000 + d.month * 100 + d.day;
  }

  String _payloadFor(DateTime date) {
    final d = _dateOnly(date);
    final dateKey =
        '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    return '$_payloadPrefix:$dateKey';
  }

  DateTime? _parsePayloadDate(String? payload) {
    if (payload == null || payload.isEmpty) return null;
    final parts = payload.split(':');
    if (parts.length != 2 || parts[0] != _payloadPrefix) return null;
    final date = DateTime.tryParse(parts[1]);
    if (date == null) return null;
    return _dateOnly(date);
  }

  DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);
}
