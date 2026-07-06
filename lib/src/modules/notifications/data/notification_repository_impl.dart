import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../domain/repository/notification_repository.dart';
import 'models/user_notification_model.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl(this._dio);

  final Dio _dio;

  @override
  Future<int> fetchUnreadCount() async {
    final res = await _dio.get<Map<String, dynamic>>('api/notifications/unread-count');
    final data = res.data?['data'] as Map<String, dynamic>?;
    return (data?['count'] as num?)?.toInt() ?? 0;
  }

  @override
  Future<NotificationListResult> fetchNotifications({int limit = 50, int? beforeId}) async {
    final res = await _dio.get<Map<String, dynamic>>(
      'api/notifications',
      queryParameters: <String, dynamic>{
        'limit': limit,
        if (beforeId != null) 'beforeId': beforeId,
      },
    );
    final data = res.data?['data'] as Map<String, dynamic>?;
    final rawItems = (data?['items'] as List<dynamic>? ?? const []);
    return NotificationListResult(
      items: rawItems
          .whereType<Map<String, dynamic>>()
          .map(UserNotificationModel.fromJson)
          .toList(),
      hasMore: data?['hasMore'] as bool? ?? false,
    );
  }

  @override
  Future<void> markRead(int id) async {
    await _dio.patch<void>('api/notifications/$id/read');
  }
}
