import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/ui_constants.dart';
import '../../modules/progress/presentation/pages/progress_page.dart';

class ActivityCardsWidget extends StatelessWidget {
  const ActivityCardsWidget({
    super.key,
    required this.steps,
    required this.stepGoal,
    this.onStepsTap,
    this.onExerciseTap,
  });

  final int steps;
  final int stepGoal;
  final VoidCallback? onStepsTap;
  final VoidCallback? onExerciseTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Steps Card
        Expanded(child: _buildStepsCard()),
        SizedBox(width: 16.w),
        // Exercise Card
        Expanded(child: _buildExerciseCard()),
      ],
    );
  }

  Widget _buildStepsCard() {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UIConstants.kRadius),
      ),
      child: Builder(
        builder: (context) => InkWell(
          onTap:
              onStepsTap ??
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ProgressPage(), // With AppBar for standalone
                  ),
                );
              },
          borderRadius: BorderRadius.circular(UIConstants.kRadius),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'Steps',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.h),

                // Steps count with icon
                Row(
                  children: [
                    Icon(Icons.directions_run, color: Colors.pink, size: 20.sp),
                    SizedBox(width: 8.w),
                    Text(
                      steps.toString(),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // Goal text
                Text(
                  'Goal: ${stepGoal.toString()} steps',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                ),
                SizedBox(height: 8.h),

                // Progress bar
                LinearProgressIndicator(
                  value: steps / stepGoal,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.pink),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseCard() {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(UIConstants.kRadius),
      ),
      child: InkWell(
        onTap: onExerciseTap,
        borderRadius: BorderRadius.circular(UIConstants.kRadius),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title with add icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Exercise',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Icon(Icons.add, size: 20.sp, color: Colors.grey[600]),
                ],
              ),
              SizedBox(height: 16.h),

              // Calories burned
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.orange,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '0 cal',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              // Duration
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.orange, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    '00:00 hr',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // Add space to match Steps card height
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
