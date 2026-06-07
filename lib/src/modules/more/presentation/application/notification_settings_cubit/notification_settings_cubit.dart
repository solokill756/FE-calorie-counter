import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/notifications/push_notification_models.dart';
import '../../../../../core/notifications/push_notification_repository.dart';
import 'notification_settings_state.dart';

@injectable
class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  NotificationSettingsCubit(this._repository) : super(const NotificationSettingsState());

  final PushNotificationRepository _repository;

  Future<void> load(String timezone) async {
    emit(state.copyWith(isLoading: true, clearError: true, saved: false));
    try {
      final preferences = await _repository.getPreferences(timezone);
      emit(state.copyWith(preferences: preferences, isLoading: false));
    } catch (_) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Failed to load notification settings'));
    }
  }

  void updateEnabled(NotificationReminderType type, bool enabled) {
    emit(state.copyWith(
      preferences: state.preferences.map((item) => item.type == type ? item.copyWith(enabled: enabled) : item).toList(),
      saved: false,
    ));
  }

  void updateTime(NotificationReminderType type, int hour, int minute) {
    emit(state.copyWith(
      preferences: state.preferences.map((item) => item.type == type ? item.copyWith(hour: hour, minute: minute) : item).toList(),
      saved: false,
    ));
  }

  Future<void> save() async {
    emit(state.copyWith(isSaving: true, clearError: true, saved: false));
    try {
      final saved = await _repository.updatePreferences(state.preferences);
      emit(state.copyWith(preferences: saved, isSaving: false, saved: true));
    } catch (_) {
      emit(state.copyWith(isSaving: false, errorMessage: 'Failed to save notification settings'));
    }
  }
}
