import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/modules/app/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../application/exercise_cubit/exercise_cubit.dart';
import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';

@RoutePage()
class ExerciseHomePage extends StatefulWidget {
  const ExerciseHomePage({super.key});

  @override
  State<ExerciseHomePage> createState() => _ExerciseHomePageState();
}

class _ExerciseHomePageState extends State<ExerciseHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExerciseCubit>().refreshHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLow,
      appBar: AppShellUi.appBar(context, 'Exercise'),
      body: RefreshIndicator(
        color: scheme.primary,
        onRefresh: () => context.read<ExerciseCubit>().refreshHome(),
        child: BlocBuilder<ExerciseCubit, ExerciseUiState>(
          builder: (context, s) {
            if (s.homeLoading && s.today == null) {
              return Center(
                child: CircularProgressIndicator(color: scheme.primary),
              );
            }
            if (s.error != null && s.today == null) {
              return ListView(
                padding: AppShellUi.pagePadding(),
                children: [
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: AppShellUi.cardDecoration(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red[700], size: 40.sp),
                        Gap(12.h),
                        Text(
                          s.error!,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 14.sp,
                            height: 1.4,
                          ),
                        ),
                        Gap(16.h),
                        FilledButton(
                          style: AppShellUi.primaryCtaStyle(context),
                          onPressed: () => context.read<ExerciseCubit>().refreshHome(),
                          child: Text('Retry', style: TextStyle(fontSize: 15.sp)),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            final t = s.today;
            return ListView(
              padding: AppShellUi.pagePadding(),
              children: [
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: AppShellUi.cardDecoration(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.local_fire_department_outlined,
                              color: scheme.primary, size: 22.sp),
                          Gap(8.w),
                          Text(
                            'Today',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[900],
                            ),
                          ),
                        ],
                      ),
                      Gap(12.h),
                      if (t != null) ...[
                        Text(
                          '${t.totalCaloriesBurned.toStringAsFixed(0)} kcal burned',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: scheme.primary,
                            letterSpacing: -0.3,
                          ),
                        ),
                        Gap(8.h),
                        Text(
                          '${t.totalMinutes.toStringAsFixed(0)} min · ${t.totalLogs} logs',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[700],
                            height: 1.35,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Gap(16.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: AppShellUi.outlinedActionStyle(context),
                        onPressed: () =>
                            context.router.push(const ExerciseCatalogRoute()),
                        icon: Icon(Icons.search, size: 20.sp, color: scheme.primary),
                        label: Text('Browse', style: TextStyle(fontSize: 14.sp)),
                      ),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: AppShellUi.outlinedActionStyle(context),
                        onPressed: () =>
                            context.router.push(const ExerciseHistoryRoute()),
                        icon: Icon(Icons.history, size: 20.sp, color: scheme.primary),
                        label: Text('History', style: TextStyle(fontSize: 14.sp)),
                      ),
                    ),
                  ],
                ),
                Gap(20.h),
                AppShellUi.sectionTitle(context, 'Recent (this day)'),
                Gap(10.h),
                if (s.recentLogsToday.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
                    decoration: AppShellUi.cardDecoration(context),
                    child: Text(
                      'No logs yet. Tap Add log to choose an exercise.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.sp,
                        height: 1.4,
                      ),
                    ),
                  )
                else
                  ...s.recentLogsToday.map(
                    (e) => AppShellUi.listRowCard(
                      context,
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                        title: Text(
                          e.exerciseName,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: Colors.grey[900],
                          ),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 4.h),
                          child: Text(
                            '${e.minutesPerformed.toStringAsFixed(0)} min · '
                            '${e.caloriesBurned.toStringAsFixed(0)} kcal',
                            style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
                          ),
                        ),
                        trailing: Text(
                          '${e.startedAt.toLocal().hour.toString().padLeft(2, '0')}:'
                          '${e.startedAt.toLocal().minute.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                Gap(72.h),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: scheme.tertiary,
        foregroundColor: scheme.onTertiary,
        elevation: 2,
        icon: Icon(Icons.add, size: 22.sp),
        label: Text('Add log', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
        onPressed: () => context.router.push(const ExerciseCatalogRoute()),
      ),
    );
  }
}
