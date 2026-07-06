import 'package:bloc/bloc.dart';
import 'package:caloriecounter/src/core/data/local/storage.dart';
import '../../../../auth/presentation/application/cubit/user_profile_access.dart';
import 'package:caloriecounter/src/modules/progress/domain/models/progress_trends_models.dart';
import 'package:caloriecounter/src/modules/progress/domain/repository/progress_trends_repository.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../../auth/presentation/application/cubit/user_profile_cubit.dart';
import '../../../../auth/domain/repository/auth_repository.dart';

part 'more_state.dart';
part 'more_cubit.freezed.dart';

@singleton
class MoreCubit extends Cubit<MoreState> {
  final AuthRepository _authRepository;
  final ProgressTrendsRepository _progressTrendsRepository;
  final UserProfileCubit _userProfileCubit;

  MoreCubit(
    this._authRepository,
    this._progressTrendsRepository,
    this._userProfileCubit,
  ) : super(const MoreState.initial());

  Future<void> loadMoreData() async {
    emit(const MoreState.loading());

    if (Storage.userID != null) {
      await _userProfileCubit.refresh();
    }

    final progress = await _loadProgressSnapshot();
    _emitLoadedFromStorage(progress: progress);
  }

  /// Updates weight-dependent More tab stats without a full-page loading state.
  Future<void> refreshAfterWeightChange() async {
    await _refreshProfileAndEmit();
  }

  /// Updates goal-dependent More tab display without a full-page loading state.
  Future<void> refreshAfterGoalChange() async {
    await _refreshProfileAndEmit();
  }

  Future<void> _refreshProfileAndEmit() async {
    if (Storage.userID != null) {
      await _userProfileCubit.refresh();
    }
    if (isClosed) return;

    final progress = await _loadProgressSnapshot();
    if (isClosed) return;

    _emitLoadedFromStorage(progress: progress);
  }

  void _emitLoadedFromStorage({_MoreProgressSnapshot? progress}) {
    final identity = Storage.userIdentity;
    final nameUser = identity?.displayName;
    final imageUser = identity?.avatarUrl;
    final displayName = (nameUser != null && nameUser.trim().isNotEmpty)
        ? nameUser.trim()
        : 'Guest';
    emit(
      MoreState.loaded(
        nameUser: displayName,
        imageUser: imageUser,
        steakDays: progress?.streakDays ?? 0,
        weightLost: progress?.weightProgressKg ?? 0,
      ),
    );
  }

  Future<void> deleteAccount() async {
    emit(const MoreState.deleteAccountLoading());
    final result = await _authRepository.deleteAccount();
    if (result.isSuccess()) {
      await _authRepository.signOut();
      if (!isClosed) {
        emit(const MoreState.accountDeletedSuccess());
      }
      return;
    }
    final err = result.exceptionOrNull()!;
    final msg = err.message.isNotEmpty
        ? err.message
        : 'Could not delete account';
    if (!isClosed) {
      emit(MoreState.deleteAccountError(msg));
      Future.microtask(() {
        if (!isClosed) _emitLoadedFromStorage();
      });
    }
  }

  Future<_MoreProgressSnapshot> _loadProgressSnapshot() async {
    try {
      final today = DateTime.now();
      final fromDay = today.subtract(const Duration(days: 29));
      final trends = await _progressTrendsRepository.fetchTrends(
        from: _dateKey(fromDay),
        to: _dateKey(today),
      );
      return _MoreProgressSnapshot(
        streakDays: trends.summary.currentStreak,
        weightProgressKg: _weightProgressFromTrends(trends),
      );
    } catch (e, st) {
      debugPrint('MoreCubit: progress snapshot skipped: $e\n$st');
      return const _MoreProgressSnapshot(streakDays: 0, weightProgressKg: 0);
    }
  }

  double _weightProgressFromTrends(ProgressTrendsResponse trends) {
    final profile = readServerProfile();
    final startWeight = profile?.startWeightKg ?? 0;
    if (startWeight <= 0) return 0;

    final weights = trends.days
        .where((day) => day.weightKg != null)
        .map((day) => day.weightKg!)
        .toList();
    if (weights.isEmpty) return 0;

    final currentWeight = weights.last;
    return _isWeightGainGoal()
        ? currentWeight - startWeight
        : startWeight - currentWeight;
  }

  bool _isWeightGainGoal() {
    final profile = readServerProfile();
    if (profile == null) return false;
    if (profile.currentWeightKg <= 0 || profile.goalWeightKg <= 0) {
      return false;
    }
    return profile.goalWeightKg > profile.currentWeightKg;
  }

  String _dateKey(DateTime date) {
    final local = DateTime(date.year, date.month, date.day);
    final year = local.year.toString().padLeft(4, '0');
    final month = local.month.toString().padLeft(2, '0');
    final day = local.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  Future<void> logOut() async {
    emit(const MoreState.logOutLoading());
    try {
      await _authRepository.signOut();
      emit(const MoreState.logOutSuccess());
    } catch (e) {
      debugPrint('Log out failed: $e');
      emit(MoreState.logOutError('Failed to log out'));
    }
  }

  void navigateToProfile() {
    // Navigation logic for profile
  }

  void navigateToIntermittentFasting() {
    // Navigation logic for intermittent fasting
  }

  void navigateToSleep() {
    // Navigation logic for sleep
  }

  void navigateToRecipeDiscovery() {
    // Navigation logic for recipe discovery
  }

  void navigateToWorkoutRoutines() {
    // Navigation logic for workout routines
  }

  void navigateToGoals() {
    // Navigation logic for goals
  }

  void navigateToProgress() {
    // Navigation logic for progress
  }

  void navigateToWeeklyReport() {
    // Navigation logic for weekly report
  }

  void navigateToNutrition() {
    // Navigation logic for nutrition
  }

  void navigateToMealsRecipesFoods() {
    // Navigation logic for meals, recipes & foods
  }

  void navigateToPremium() {
    // Navigation logic for premium
  }

  // Additional navigation hooks (placeholders)
  void navigateToReminders() {
    // Navigation logic for reminders
  }

  void navigateToAppsDevices() {
    // Navigation logic for apps & devices
  }

  void navigateToSteps() {
    // Navigation logic for steps
  }

  void navigateToCommunity() {
    // Navigation logic for community
  }

  void navigateToLearn() {
    // Navigation logic for learn
  }

  void navigateToFriends() {
    // Navigation logic for friends
  }

  void navigateToMessages() {
    // Navigation logic for messages
  }

  void navigateToSettings() {
    // Navigation logic for settings
  }

  void navigateToPrivacy() {
    // Navigation logic for privacy
  }

  void navigateToHelp() {
    // Navigation logic for help
  }

  void navigateToSync() {
    // Navigation logic for sync
  }
}

class _MoreProgressSnapshot {
  const _MoreProgressSnapshot({
    required this.streakDays,
    required this.weightProgressKg,
  });

  final int streakDays;
  final double weightProgressKg;
}
