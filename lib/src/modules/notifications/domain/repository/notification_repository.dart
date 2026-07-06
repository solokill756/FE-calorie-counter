import '../../data/models/user_notification_model.dart';

abstract class NotificationRepository {
  Future<int> fetchUnreadCount();
  Future<NotificationListResult> fetchNotifications({int limit = 50, int? beforeId});
  Future<void> markRead(int id);
}
