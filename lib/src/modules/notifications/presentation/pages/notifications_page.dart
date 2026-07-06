import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/widgets/unified_error_display.dart';
import 'package:caloriecounter/src/core/utils/error_translator.dart';
import 'package:caloriecounter/src/modules/app/app_router.dart';
import 'package:caloriecounter/src/modules/notifications/data/models/user_notification_model.dart';
import 'package:caloriecounter/src/modules/notifications/presentation/application/notifications_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

@RoutePage()
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<NotificationsCubit>().refresh(showLoading: true);
    });
  }

  Future<void> _onTapItem(UserNotificationModel item) async {
    final cubit = context.read<NotificationsCubit>();
    final result = await cubit.markReadAndNavigate(item);
    if (!mounted) return;
    if (result == NotificationTapResult.failed && item.isUnread) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: const Text('Could not mark notification as read'),
        ),
      );
      return;
    }
    if (result == NotificationTapResult.navigateNutrition) {
      await context.router.push(const NutritionRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: scheme.surfaceContainerLowest,
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading || state is NotificationsInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is NotificationsError) {
            return UnifiedErrorDisplay(
              message: ErrorTranslator.getMessage(state.message),
              subtitle: 'Pull down or tap retry.',
              onRetry: () =>
                  context.read<NotificationsCubit>().refresh(showLoading: true),
              primaryColor: scheme.primary,
            );
          }
          if (state is NotificationsLoaded) {
            if (state.items.isEmpty) {
              return RefreshIndicator(
                onRefresh: () => context.read<NotificationsCubit>().refresh(
                  showLoading: true,
                ),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(height: 120),
                    Center(child: Text('No notifications yet')),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () => context.read<NotificationsCubit>().refresh(),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.items.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: scheme.outlineVariant),
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return ListTile(
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontWeight: item.isUnread
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                    subtitle: Text(item.body),
                    trailing: Text(
                      DateFormat.MMMd().add_jm().format(
                        item.createdAt.toLocal(),
                      ),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    tileColor: item.isUnread
                        ? scheme.primaryContainer.withValues(alpha: 0.35)
                        : null,
                    onTap: () => _onTapItem(item),
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
