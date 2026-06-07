import 'package:bloc_test/bloc_test.dart';
import 'package:caloriecounter/src/core/notifications/push_notification_models.dart';
import 'package:caloriecounter/src/core/notifications/push_notification_repository.dart';
import 'package:caloriecounter/src/modules/more/presentation/application/notification_settings_cubit/notification_settings_cubit.dart';
import 'package:caloriecounter/src/modules/more/presentation/application/notification_settings_cubit/notification_settings_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPushNotificationRepository extends Mock implements PushNotificationRepository {}

void main() {
  late MockPushNotificationRepository repository;

  setUp(() {
    repository = MockPushNotificationRepository();
  });

  blocTest<NotificationSettingsCubit, NotificationSettingsState>(
    'loads preferences',
    build: () {
      when(() => repository.getPreferences(any())).thenAnswer(
        (_) async => [
          const NotificationPreference(
            type: NotificationReminderType.water,
            enabled: true,
            hour: 10,
            minute: 0,
            timezone: 'Asia/Saigon',
          ),
        ],
      );
      return NotificationSettingsCubit(repository);
    },
    act: (cubit) => cubit.load('Asia/Saigon'),
    expect: () => [
      isA<NotificationSettingsState>().having((s) => s.isLoading, 'isLoading', true),
      isA<NotificationSettingsState>().having((s) => s.preferences.length, 'preferences length', 1),
    ],
  );
}
