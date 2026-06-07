import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';
import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';
import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:gap/gap.dart';

import '../application/notification_settings_cubit/notification_settings_cubit.dart';
import '../application/notification_settings_cubit/notification_settings_state.dart';

@RoutePage()
class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NotificationSettingsCubit>()..load('Asia/Saigon'),
      child: const _NotificationSettingsView(),
    );
  }
}

class _NotificationSettingsView extends StatefulWidget {
  const _NotificationSettingsView();

  @override
  State<_NotificationSettingsView> createState() => _NotificationSettingsViewState();
}

class _NotificationSettingsViewState extends State<_NotificationSettingsView> {
  @override
  void initState() {
    super.initState();
    _reloadWithTimezone();
  }

  Future<void> _reloadWithTimezone() async {
    try {
      final timezone = await FlutterTimezone.getLocalTimezone();
      if (!mounted) return;
      await context.read<NotificationSettingsCubit>().load(timezone.identifier);
    } catch (_) {
      if (!mounted) return;
      await context.read<NotificationSettingsCubit>().load('UTC');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: BlocConsumer<NotificationSettingsCubit, NotificationSettingsState>(
        listener: (context, state) {
          if (state.saved) {
            AppDialogs.showSnackBar(message: 'Notification settings saved');
          }
          if (state.errorMessage != null) {
            AppDialogs.showSnackBar(
              message: state.errorMessage!,
              backgroundColor: theme.colorScheme.error,
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final preference in state.preferences) ...[
                DecoratedBox(
                  decoration: AppShellUi.cardDecoration(context),
                  child: ListTile(
                    title: Text(preference.type.label),
                    subtitle: Text('${preference.hour.toString().padLeft(2, '0')}:${preference.minute.toString().padLeft(2, '0')}'),
                    leading: Icon(Icons.notifications_active_outlined, color: theme.colorScheme.primary),
                    trailing: Switch(
                      value: preference.enabled,
                      onChanged: (value) => context.read<NotificationSettingsCubit>().updateEnabled(preference.type, value),
                    ),
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: preference.hour, minute: preference.minute),
                      );
                      if (picked != null && context.mounted) {
                        context.read<NotificationSettingsCubit>().updateTime(preference.type, picked.hour, picked.minute);
                      }
                    },
                  ),
                ),
                const Gap(12),
              ],
              FilledButton(
                onPressed: state.isSaving ? null : () => context.read<NotificationSettingsCubit>().save(),
                child: state.isSaving ? const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Save'),
              ),
            ],
          );
        },
      ),
    );
  }
}
