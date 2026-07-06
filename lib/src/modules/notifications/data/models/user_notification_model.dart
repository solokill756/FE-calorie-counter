class UserNotificationModel {
  const UserNotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.payload,
    required this.readAt,
    required this.createdAt,
  });

  final int id;
  final String type;
  final String title;
  final String body;
  final Map<String, dynamic>? payload;
  final DateTime? readAt;
  final DateTime createdAt;

  bool get isUnread => readAt == null;

  factory UserNotificationModel.fromJson(Map<String, dynamic> json) {
    return UserNotificationModel(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      payload: json['payload'] as Map<String, dynamic>?,
      readAt: json['readAt'] == null ? null : DateTime.parse(json['readAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

class NotificationListResult {
  const NotificationListResult({required this.items, required this.hasMore});

  final List<UserNotificationModel> items;
  final bool hasMore;
}
