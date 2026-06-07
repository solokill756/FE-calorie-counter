import 'dart:async';
import 'dart:io';

import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:caloriecounter/src/modules/app/app_router.dart';
import 'package:caloriecounter/src/modules/diary/domain/entities/diary_entity.dart';
import 'package:caloriecounter/src/modules/diary/domain/repository/diary_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MealLogReminderService {
  MealLogReminderService._();

  static final MealLogReminderService instance = MealLogReminderService._();

  static const _channelId = 'meal_log_reminders';
  static const _channelName = 'Meal reminders';
  static const _channelDescription = 'Reminds users to log meals';
  static const _payloadPrefix = 'meal-reminder';
  static const _rollingWindowDays = 3;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  bool _timezoneConfigured = false;
  Future<void>? _scheduleInFlight;

  static const List<_MealReminder> _meals = [
    _MealReminder(
      slug: 'breakfast',
      title: 'Log breakfast',
      body: 'Quickly add breakfast to keep today accurate.',
      hour: 7,
      minute: 30,
      idIndex: 1,
    ),
    _MealReminder(
      slug: 'lunch',
      title: 'Log lunch',
      body: 'Add lunch now so your remaining targets stay useful.',
      hour: 12,
      minute: 0,
      idIndex: 2,
    ),
    _MealReminder(
      slug: 'snacks',
      title: 'Log snack',
      body: 'Track your snack while it is fresh in mind.',
      hour: 15,
      minute: 30,
      idIndex: 3,
    ),
    _MealReminder(
      slug: 'dinner',
      title: 'Log dinner',
      body: 'Finish the day by logging dinner.',
      hour: 18,
      minute: 30,
      idIndex: 4,
    ),
  ];

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
      final date = today.add(Duration(days: offset));
      for (final meal in _meals) {
        await _plugin.cancel(_notificationId(date, meal.slug));
      }
    }
  }

  Future<void> markMealLogged(DateTime date, String mealSlug) async {
    await init();
    await _plugin.cancel(_notificationId(date, _normalizeMealSlug(mealSlug)));
  }

  Future<void> markMealsLogged(Iterable<DateTime> dates, String mealSlug) async {
    await init();
    final normalized = _normalizeMealSlug(mealSlug);
    for (final date in dates) {
      await _plugin.cancel(_notificationId(date, normalized));
    }
  }

  Future<void> _scheduleRollingWindow() async {
    await init();
    final now = DateTime.now();
    final today = _dateOnly(now);

    for (var offset = 0; offset < _rollingWindowDays; offset++) {
      final date = today.add(Duration(days: offset));
      DiaryEntity? diary;
      try {
        diary = await getIt<DiaryRepository>().getDiaryForDate(date);
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Meal reminders: diary sync skipped for $date: $e');
        }
      }

      for (final meal in _meals) {
        final scheduledAt = DateTime(
          date.year,
          date.month,
          date.day,
          meal.hour,
          meal.minute,
        );
        final id = _notificationId(date, meal.slug);

        if (!scheduledAt.isAfter(now) || _isMealLogged(diary, meal.slug)) {
          await _plugin.cancel(id);
          continue;
        }

        await _plugin.zonedSchedule(
          id,
          meal.title,
          meal.body,
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
          payload: _payloadFor(date, meal.slug),
        );
      }
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
    final parsed = _parsePayload(response.payload);
    if (parsed == null) return;
    unawaited(
      getIt<AppRouter>().push<void>(
        LogFoodRoute(forDate: parsed.date, initialMeal: parsed.mealSlug),
      ),
    );
  }

  bool _isMealLogged(DiaryEntity? diary, String mealSlug) {
    if (diary == null) return false;
    switch (_normalizeMealSlug(mealSlug)) {
      case 'breakfast':
        return diary.breakfast.isNotEmpty;
      case 'lunch':
        return diary.lunch.isNotEmpty;
      case 'dinner':
        return diary.dinner.isNotEmpty;
      case 'snacks':
        return diary.snacks.isNotEmpty;
      default:
        return false;
    }
  }

  int _notificationId(DateTime date, String mealSlug) {
    final meal = _meals.firstWhere(
      (item) => item.slug == _normalizeMealSlug(mealSlug),
      orElse: () => _meals.first,
    );
    final d = _dateOnly(date);
    return (d.year * 10000 + d.month * 100 + d.day) * 10 + meal.idIndex;
  }

  String _payloadFor(DateTime date, String mealSlug) {
    final d = _dateOnly(date);
    final dateKey =
        '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    return '$_payloadPrefix:$dateKey:${_normalizeMealSlug(mealSlug)}';
  }

  _MealReminderPayload? _parsePayload(String? payload) {
    if (payload == null || payload.isEmpty) return null;
    final parts = payload.split(':');
    if (parts.length != 3 || parts[0] != _payloadPrefix) return null;
    final date = DateTime.tryParse(parts[1]);
    if (date == null) return null;
    return _MealReminderPayload(
      date: _dateOnly(date),
      mealSlug: _normalizeMealSlug(parts[2]),
    );
  }

  String _normalizeMealSlug(String mealSlug) {
    final normalized = mealSlug.trim().toLowerCase();
    return normalized == 'snack' ? 'snacks' : normalized;
  }

  DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);
}

class _MealReminder {
  const _MealReminder({
    required this.slug,
    required this.title,
    required this.body,
    required this.hour,
    required this.minute,
    required this.idIndex,
  });

  final String slug;
  final String title;
  final String body;
  final int hour;
  final int minute;
  final int idIndex;
}

class _MealReminderPayload {
  const _MealReminderPayload({required this.date, required this.mealSlug});

  final DateTime date;
  final String mealSlug;
}
