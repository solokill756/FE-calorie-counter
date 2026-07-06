import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';
import 'package:caloriecounter/src/modules/app/app_router.dart';
import 'package:caloriecounter/src/modules/notifications/presentation/application/notifications_cubit.dart';
import 'package:caloriecounter/src/core/utils/error_translator.dart';
import 'package:caloriecounter/src/common/widgets/unified_error_display.dart';
import 'package:caloriecounter/src/modules/dashboard/data/models/dashboard_today_response.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/application/dashboard_cubit.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/_alerts_card.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/_calories_card.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/_checklist_card.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/_exercise_card.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/_macros_card.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/_suggestion_card.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/_water_card.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/_weight_card.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/dash_card_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class DashboardHomeView extends StatelessWidget {
  const DashboardHomeView({
    super.key,
    this.onNavigateToDiary,
    this.onNavigateToProgress,
  });

  final VoidCallback? onNavigateToDiary;
  final VoidCallback? onNavigateToProgress;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              scheme.surfaceContainerLow,
              Color.lerp(
                scheme.surfaceContainerLow,
                scheme.primaryContainer,
                0.12,
              )!,
            ],
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<DashboardCubit, DashboardViewState>(
            builder: (context, state) {
              if (state is DashboardViewLoading ||
                  state is DashboardViewInitial) {
                return const _DashboardSkeleton();
              }
              if (state is DashboardViewError) {
                return UnifiedErrorDisplay(
                  message: ErrorTranslator.getMessage(state.message),
                  subtitle: 'Please retry to load your dashboard.',
                  onRetry: () =>
                      context.read<DashboardCubit>().loadTodayDashboard(),
                  primaryColor: Theme.of(context).colorScheme.primary,
                );
              }
              if (state is DashboardViewLoaded) {
                return RefreshIndicator(
                  color: scheme.primary,
                  onRefresh: () =>
                      context.read<DashboardCubit>().refreshDashboard(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: AppShellUi.pagePadding(),
                    child: _DashboardContent(
                      data: state.data,
                      isSuggestionLoading: state.isSuggestionLoading,
                      onNavigateToDiary: onNavigateToDiary,
                      onNavigateToProgress: onNavigateToProgress,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({
    required this.data,
    required this.isSuggestionLoading,
    this.onNavigateToDiary,
    this.onNavigateToProgress,
  });

  final DashboardTodayResponse data;
  final bool isSuggestionLoading;
  final VoidCallback? onNavigateToDiary;
  final VoidCallback? onNavigateToProgress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Header(user: data.user, date: data.date),
        Gap(16.h),
        CaloriesCard(
          calories: data.calories,
          onTap: () => onNavigateToDiary?.call(),
        ),
        Gap(16.h),
        MacrosCard(
          macros: data.macros,
          onTap: () => context.router.push(NutritionRoute()),
        ),
        Gap(16.h),
        _QuickActions(
          onFood: () => context.router.push(LogFoodRoute()),
          onWater: () => onNavigateToDiary?.call(),
          onExercise: () {
            final dashboardCubit = context.read<DashboardCubit>();
            context.router
                .push(const ExerciseHomeRoute())
                .then((_) => dashboardCubit.refreshDashboard());
          },
          onWeight: () => context.router.push(WeightFormRoute()),
        ),
        Gap(16.h),
        ExerciseCard(
          exercise: data.exercise,
          onTap: () {
            final dashboardCubit = context.read<DashboardCubit>();
            context.router
                .push(const ExerciseHistoryRoute())
                .then((_) => dashboardCubit.refreshDashboard());
          },
        ),
        Gap(16.h),
        WaterCard(water: data.water, onTap: () => onNavigateToDiary?.call()),
        Gap(16.h),
        WeightCard(
          weight: data.weight,
          onTap: () {
            if (onNavigateToProgress != null) {
              onNavigateToProgress!();
            } else {
              context.router.push(ProgressRoute());
            }
          },
        ),
        Gap(16.h),
        AlertsCard(alerts: data.alerts),
        Gap(16.h),
        SuggestionCard(
          suggestion: data.aiSuggestion,
          isLoading: isSuggestionLoading,
        ),
        Gap(16.h),
        ChecklistCard(checklist: data.checklist),
        Gap(24.h),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.user, required this.date});

  final DashboardUserSummary user;
  final String date;

  @override
  Widget build(BuildContext context) {
    final hour = DateTime.now().hour;
    final scheme = Theme.of(context).colorScheme;
    final greet = hour < 12
        ? 'Good Morning'
        : hour < 17
        ? 'Good Afternoon'
        : 'Good Evening';
    DateTime? parsed;
    try {
      parsed = DateTime.parse('${date}T12:00:00Z');
    } catch (_) {}
    final dateLabel = parsed != null
        ? DateFormat('MMMM d').format(parsed.toLocal())
        : date;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$greet, ${user.displayName}',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                  height: 1.2,
                ),
              ),
              Gap(6.h),
              Text(
                'TODAY · $dateLabel'.toUpperCase(),
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            final count = context.read<NotificationsCubit>().unreadCount;
            return IconButton(
              tooltip: 'Notifications',
              onPressed: () => context.router.push(const NotificationsRoute()),
              icon: Badge(
                isLabelVisible: count > 0,
                label: Text('$count'),
                child: const Icon(Icons.notifications_outlined),
              ),
            );
          },
        ),
        Gap(4.w),
        CircleAvatar(
          radius: 22.r,
          backgroundColor: scheme.primary,
          backgroundImage: user.avatarUrl != null && user.avatarUrl!.isNotEmpty
              ? CachedNetworkImageProvider(user.avatarUrl!)
              : null,
          child: user.avatarUrl == null || user.avatarUrl!.isEmpty
              ? Text(
                  user.displayName.isNotEmpty
                      ? user.displayName[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                )
              : null,
        ),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({
    required this.onFood,
    required this.onWater,
    required this.onExercise,
    required this.onWeight,
  });

  final VoidCallback onFood;
  final VoidCallback onWater;
  final VoidCallback onExercise;
  final VoidCallback onWeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppShellUi.sectionTitle(context, 'Quick actions'),
        Gap(12.h),
        GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 0.82,
          children: [
            _qa(
              context,
              Icons.restaurant_rounded,
              'Food',
              onFood,
              Theme.of(context).colorScheme.primary,
            ),
            _qa(
              context,
              Icons.water_drop_rounded,
              'Water',
              onWater,
              Theme.of(context).colorScheme.tertiary,
            ),
            _qa(
              context,
              Icons.fitness_center_rounded,
              'Exercise',
              onExercise,
              Theme.of(context).colorScheme.secondary,
            ),
            _qa(
              context,
              Icons.monitor_weight_rounded,
              'Weight',
              onWeight,
              Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      ],
    );
  }

  Widget _qa(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
    Color accent,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final r = dashCardRadius();
    return Container(
      decoration: dashCardDecoration(scheme),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: r,
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accent.withValues(alpha: 0.14),
                  ),
                  child: Icon(icon, color: accent, size: 24.sp),
                ),
                Gap(8.h),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    color: scheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardSkeleton extends StatelessWidget {
  const _DashboardSkeleton();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      baseColor: scheme.surfaceContainerHighest,
      highlightColor: scheme.surfaceContainerLowest,
      child: ListView(
        padding: AppShellUi.pagePadding(),
        children: [
          const _SkeletonHeader(),
          Gap(16.h),
          const _SkeletonCaloriesCard(),
          Gap(16.h),
          const _SkeletonMacrosCard(),
          Gap(16.h),
          const _SkeletonQuickActions(),
          Gap(16.h),
          _SkeletonInfoCard(height: 124.h, rows: 2),
          Gap(16.h),
          _SkeletonInfoCard(height: 102.h, rows: 2),
          Gap(16.h),
          _SkeletonInfoCard(height: 112.h, rows: 3),
          Gap(24.h),
        ],
      ),
    );
  }
}

class _SkeletonHeader extends StatelessWidget {
  const _SkeletonHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SkeletonBlock(width: 220.w, height: 24.h),
              Gap(10.h),
              _SkeletonBlock(width: 112.w, height: 12.h),
            ],
          ),
        ),
        Gap(16.w),
        _SkeletonBlock(width: 44.r, height: 44.r, radius: 999.r),
      ],
    );
  }
}

class _SkeletonCaloriesCard extends StatelessWidget {
  const _SkeletonCaloriesCard();

  @override
  Widget build(BuildContext context) {
    return _SkeletonCard(
      height: 168.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SkeletonTitleRow(width: 148),
          Gap(18.h),
          Row(
            children: [
              _SkeletonBlock(width: 96.r, height: 96.r, radius: 999.r),
              Gap(16.w),
              Expanded(
                child: Column(
                  children: [
                    _SkeletonMetricRow(width: 96.w),
                    Gap(12.h),
                    _SkeletonMetricRow(width: 88.w),
                    Gap(12.h),
                    _SkeletonMetricRow(width: 104.w),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SkeletonMacrosCard extends StatelessWidget {
  const _SkeletonMacrosCard();

  @override
  Widget build(BuildContext context) {
    return _SkeletonCard(
      height: 148.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SkeletonTitleRow(width: 84),
          Gap(16.h),
          const _SkeletonProgressRow(labelWidth: 72),
          Gap(12.h),
          const _SkeletonProgressRow(labelWidth: 64),
          Gap(12.h),
          const _SkeletonProgressRow(labelWidth: 52),
        ],
      ),
    );
  }
}

class _SkeletonQuickActions extends StatelessWidget {
  const _SkeletonQuickActions();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SkeletonBlock(width: 116.w, height: 18.h),
        Gap(12.h),
        Row(
          children: [
            for (var i = 0; i < 4; i++) ...[
              Expanded(
                child: _SkeletonBlock(height: 82.h, radius: 14.r),
              ),
              if (i < 3) Gap(12.w),
            ],
          ],
        ),
      ],
    );
  }
}

class _SkeletonInfoCard extends StatelessWidget {
  const _SkeletonInfoCard({required this.height, required this.rows});

  final double height;
  final int rows;

  @override
  Widget build(BuildContext context) {
    return _SkeletonCard(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SkeletonTitleRow(width: 118),
          Gap(16.h),
          for (var i = 0; i < rows; i++) ...[
            _SkeletonBlock(width: double.infinity, height: 12.h),
            if (i < rows - 1) Gap(10.h),
          ],
        ],
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard({required this.height, required this.child});

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: dashCardDecoration(Theme.of(context).colorScheme),
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
      child: child,
    );
  }
}

class _SkeletonTitleRow extends StatelessWidget {
  const _SkeletonTitleRow({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SkeletonBlock(width: 22.r, height: 22.r, radius: 8.r),
        Gap(10.w),
        _SkeletonBlock(width: width.w, height: 18.h),
      ],
    );
  }
}

class _SkeletonMetricRow extends StatelessWidget {
  const _SkeletonMetricRow({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _SkeletonBlock(width: 72.w, height: 12.h),
        _SkeletonBlock(width: width, height: 14.h),
      ],
    );
  }
}

class _SkeletonProgressRow extends StatelessWidget {
  const _SkeletonProgressRow({required this.labelWidth});

  final double labelWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _SkeletonBlock(width: labelWidth.w, height: 12.h),
            _SkeletonBlock(width: 86.w, height: 12.h),
          ],
        ),
        Gap(8.h),
        _SkeletonBlock(width: double.infinity, height: 8.h, radius: 999.r),
      ],
    );
  }
}

class _SkeletonBlock extends StatelessWidget {
  const _SkeletonBlock({required this.height, this.width, this.radius});

  final double height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radius ?? 8.r),
      ),
    );
  }
}
