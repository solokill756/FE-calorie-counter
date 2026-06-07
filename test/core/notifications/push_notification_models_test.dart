import 'package:caloriecounter/src/core/notifications/push_notification_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('NotificationPreference maps from and to json', () {
    final preference = NotificationPreference.fromJson(const {
      'type': 'water',
      'enabled': true,
      'hour': 9,
      'minute': 15,
      'timezone': 'Asia/Saigon',
    });

    expect(preference.type, NotificationReminderType.water);
    expect(preference.toJson(), {
      'type': 'water',
      'enabled': true,
      'hour': 9,
      'minute': 15,
      'timezone': 'Asia/Saigon',
    });
  });
}
