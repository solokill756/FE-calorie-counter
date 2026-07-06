import 'package:caloriecounter/src/modules/dashboard/data/models/dashboard_today_response.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/dash_card_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({super.key, required this.exercise, this.onTap});

  final DashboardExerciseSection exercise;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DashCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dashCardTitleRow(
            context,
            icon: Icons.directions_run_rounded,
            title: 'Exercise',
          ),
          Gap(12.h),
          Text(
            '${exercise.caloriesBurned} kcal burned',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade900,
            ),
          ),
          Text(
            '${exercise.minutes} minutes active',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          ),
          Text(
            '${exercise.workoutCount} workouts today',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          ),
          Gap(10.h),
          Text(
            'View history',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
