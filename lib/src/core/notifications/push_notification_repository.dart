import 'package:dio/dio';
import 'package:injectable/injectable.dart';

import 'push_notification_models.dart';

@lazySingleton
class PushNotificationRepository {
  PushNotificationRepository(this._dio);

  final Dio _dio;

  Future<void> registerDeviceToken({
    required String token,
    required String platform,
    required String deviceId,
  }) async {
    await _dio.post<void>(
      'notifications/device-tokens',
      data: {
        'token': token,
        'platform': platform,
        'deviceId': deviceId,
      },
    );
  }

  Future<List<NotificationPreference>> getPreferences(String timezone) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'notifications/preferences',
      options: Options(headers: {'x-timezone': timezone}),
    );
    final rows = (response.data?['preferences'] as List<dynamic>? ?? const []);
    return rows
        .whereType<Map<String, dynamic>>()
        .map(NotificationPreference.fromJson)
        .toList(growable: false);
  }

  Future<List<NotificationPreference>> updatePreferences(List<NotificationPreference> preferences) async {
    final response = await _dio.put<Map<String, dynamic>>(
      'notifications/preferences',
      data: {'preferences': preferences.map((item) => item.toJson()).toList()},
    );
    final rows = (response.data?['preferences'] as List<dynamic>? ?? const []);
    return rows
        .whereType<Map<String, dynamic>>()
        .map(NotificationPreference.fromJson)
        .toList(growable: false);
  }
}
