import '../../../../../core/notifications/push_notification_models.dart';

class NotificationSettingsState {
  const NotificationSettingsState({
    this.preferences = const [],
    this.isLoading = false,
    this.isSaving = false,
    this.errorMessage,
    this.saved = false,
  });

  final List<NotificationPreference> preferences;
  final bool isLoading;
  final bool isSaving;
  final String? errorMessage;
  final bool saved;

  NotificationSettingsState copyWith({
    List<NotificationPreference>? preferences,
    bool? isLoading,
    bool? isSaving,
    String? errorMessage,
    bool clearError = false,
    bool? saved,
  }) {
    return NotificationSettingsState(
      preferences: preferences ?? this.preferences,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      saved: saved ?? this.saved,
    );
  }
}
