import 'dart:async';
import 'dart:io';

import 'package:caloriecounter/src/core/data/local/storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../modules/app/app_router.dart';
import 'push_notification_repository.dart';
import 'push_notification_route_mapper.dart';

@lazySingleton
class PushNotificationService {
  PushNotificationService(this._repository, this._router);

  static const _deviceIdKey = 'push_notification_device_id';
  static const _channelId = 'push_notifications';
  static const _channelName = 'Push notifications';

  final PushNotificationRepository _repository;
  final AppRouter _router;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  StreamSubscription<String>? _tokenRefreshSub;

  Future<void> init() async {
    await _localNotifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload != null) {
          _navigateFromData({'type': payload});
        }
      },
    );

    await _messaging.requestPermission(alert: true, badge: true, sound: true);
    FirebaseMessaging.onMessage.listen(_showForegroundNotification);
    FirebaseMessaging.onMessageOpenedApp.listen((message) => _navigateFromData(message.data));

    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      unawaited(Future<void>.delayed(const Duration(milliseconds: 300), () => _navigateFromData(initial.data)));
    }

    await registerCurrentToken();
    _tokenRefreshSub?.cancel();
    _tokenRefreshSub = _messaging.onTokenRefresh.listen((token) {
      unawaited(_registerToken(token));
    });
  }

  Future<void> registerCurrentToken() async {
    final token = await _messaging.getToken();
    if (token == null || token.isEmpty) return;
    await _registerToken(token);
  }

  Future<void> _registerToken(String token) async {
    try {
      await _repository.registerDeviceToken(
        token: token,
        platform: Platform.isIOS ? 'ios' : Platform.isAndroid ? 'android' : 'unknown',
        deviceId: await _deviceId(),
      );
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('Push notification token registration failed: $e\n$st');
      }
    }
  }

  Future<String> _deviceId() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_deviceIdKey);
    if (existing != null && existing.isNotEmpty) return existing;
    final created = DateTime.now().microsecondsSinceEpoch.toString();
    await prefs.setString(_deviceIdKey, created);
    return created;
  }

  Future<void> _showForegroundNotification(RemoteMessage message) async {
    final notification = message.notification;
    final title = notification?.title ?? message.data['title'] as String? ?? 'Nutrition Coach';
    final body = notification?.body ?? message.data['body'] as String? ?? '';
    final type = message.data['type'] as String? ?? 'system';

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(presentAlert: true, presentBadge: true, presentSound: true),
      ),
      payload: type,
    );
  }

  void _navigateFromData(Map<String, dynamic> data) {
    if (Storage.userID == null) return;
    switch (PushNotificationRouteMapper.routeKeyFor(data)) {
      case PushNotificationRouteKey.water:
        unawaited(_router.push(const WaterLogRoute()));
        break;
      case PushNotificationRouteKey.mealLog:
        unawaited(_router.push(LogFoodRoute()));
        break;
      case PushNotificationRouteKey.weight:
        unawaited(_router.push(WeightFormRoute()));
        break;
      case PushNotificationRouteKey.exercise:
        unawaited(_router.push(const ExerciseHomeRoute()));
        break;
      case PushNotificationRouteKey.dashboard:
        unawaited(_router.push(DashboardRoute()));
        break;
    }
  }

  Future<void> dispose() async {
    await _tokenRefreshSub?.cancel();
  }
}
