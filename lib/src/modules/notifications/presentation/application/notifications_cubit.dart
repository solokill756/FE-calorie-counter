import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:caloriecounter/src/modules/auth/presentation/application/cubit/user_profile_cubit.dart';

import '../../data/models/user_notification_model.dart';
import '../../domain/repository/notification_repository.dart';

sealed class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  NotificationsLoaded({
    required this.unreadCount,
    required this.items,
  });

  final int unreadCount;
  final List<UserNotificationModel> items;
}

class NotificationsError extends NotificationsState {
  NotificationsError(this.message);

  final String message;
}

enum NotificationTapResult { markedReadOnly, navigateNutrition, failed }

@lazySingleton
class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repository) : super(NotificationsInitial());

  final NotificationRepository _repository;

  int get unreadCount {
    final current = state;
    return current is NotificationsLoaded ? current.unreadCount : 0;
  }

  Future<void> refresh({bool showLoading = false}) async {
    if (showLoading) emit(NotificationsLoading());
    try {
      final results = await Future.wait([
        _repository.fetchUnreadCount(),
        _repository.fetchNotifications(),
      ]);
      emit(NotificationsLoaded(
        unreadCount: results[0] as int,
        items: (results[1] as NotificationListResult).items,
      ));
    } catch (e) {
      if (state is NotificationsLoaded && !showLoading) return;
      emit(NotificationsError(e.toString()));
    }
  }

  Future<NotificationTapResult> markReadAndNavigate(UserNotificationModel item) async {
    final current = state;
    if (current is! NotificationsLoaded) return NotificationTapResult.failed;

    try {
      if (item.isUnread) {
        await _repository.markRead(item.id);
      }
      final updatedItems = current.items.map((row) {
        if (row.id != item.id) return row;
        return UserNotificationModel(
          id: row.id,
          type: row.type,
          title: row.title,
          body: row.body,
          payload: row.payload,
          readAt: row.readAt ?? DateTime.now(),
          createdAt: row.createdAt,
        );
      }).toList();
      final wasUnread = item.isUnread;
      emit(NotificationsLoaded(
        unreadCount: wasUnread ? (current.unreadCount - 1).clamp(0, 999) : current.unreadCount,
        items: updatedItems,
      ));
      if (item.type == 'threshold_adjusted') {
        unawaited(getIt<UserProfileCubit>().refresh());
      }
      return item.payload?['deepLink'] == 'nutrition'
          ? NotificationTapResult.navigateNutrition
          : NotificationTapResult.markedReadOnly;
    } catch (_) {
      return NotificationTapResult.failed;
    }
  }
}
