import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/widgets/calories_carousel_widget.dart';
import '../../../../common/widgets/activity_cards_widget.dart';
import '../../../../common/widgets/weight_charts_widget.dart';
import '../application/calorie_cubit/calorie_cubit.dart';
import 'discover_section_widget.dart';

class DashboardContentWidget extends StatelessWidget {
  final VoidCallback? onNavigateToDiary;
  final VoidCallback? onNavigateToProgress;
  final CalorieState state;

  const DashboardContentWidget({
    super.key,
    this.onNavigateToDiary,
    this.onNavigateToProgress,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return state.maybeWhen(
      loaded:
          (
            isLoading,
            isError,
            errorMessage,
            todayCalories,
            todayMacros,
            todayActivities,
            weightHistory,
            steps,
            stepGoal,
          ) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  // Today Section
                  _buildTodaySection(),
                  SizedBox(height: 16.h),

                  // Calories Carousel with animation
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 800),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: 0.8 + (0.2 * value),
                        child: Opacity(
                          opacity: value,
                          child: CaloriesCarouselWidget(
                            calories: {
                              'goal': todayCalories?.goal ?? 2220,
                              'consumed': todayCalories?.consumed ?? 0,
                              'burned': todayCalories?.burned ?? 0,
                              'remaining': todayCalories?.remaining ?? 2220,
                            },
                            todayMacros: todayMacros,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Activity Cards with staggered animation
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1000),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 50 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: ActivityCardsWidget(
                            steps: 8432,
                            stepGoal: 10000,
                            onExerciseTap: () {
                              onNavigateToDiary?.call();
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Weight Charts with delay animation
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1200),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 50 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: WeightChartsWidget(
                            onAddTap: () {
                              // Handle add weight tap
                            },
                            onViewDetailsTap: onNavigateToProgress,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16.h),

                  // Discover Section
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 1400),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 50 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: const DiscoverSectionWidget(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildTodaySection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Today',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 200),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Edit',
                style: TextStyle(color: Colors.blue, fontSize: 14.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
