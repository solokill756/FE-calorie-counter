import 'package:caloriecounter/src/modules/dashboard/data/models/dashboard_today_response.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/dash_card_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CaloriesCard extends StatelessWidget {
  const CaloriesCard({super.key, required this.calories, this.onTap});

  final DashboardCaloriesSection calories;
  final VoidCallback? onTap;

  Color _statusColor(BuildContext context) {
    switch (calories.status) {
      case 'exceeded':
        return Colors.red.shade700;
      case 'close':
        return Colors.orange.shade800;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  String _statusText() {
    switch (calories.status) {
      case 'exceeded':
        return 'You exceeded your calorie target';
      case 'close':
        return 'You are close to your daily goal';
      default:
        return 'You are on track today';
    }
  }

  @override
  Widget build(BuildContext context) {
    final target = calories.target <= 0 ? 1 : calories.target;
    final progress = (calories.consumed / target).clamp(0.0, 1.0);
    final c = _statusColor(context);

    return DashCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dashCardTitleRow(
            context,
            icon: Icons.local_fire_department_outlined,
            title: 'Calories budget',
          ),
          Gap(14.h),
          Row(
            children: [
              SizedBox(
                width: 96.r,
                height: 96.r,
                child: CustomPaint(
                  painter: CalorieRingPainter(
                    progress: progress,
                    trackColor: Colors.grey.shade200,
                    progressColor: c,
                    strokeWidth: 9,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${calories.remaining}',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade900,
                            height: 1,
                          ),
                        ),
                        Gap(2.h),
                        Text(
                          'kcal left',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _kv('Consumed', '${calories.consumed} kcal'),
                    _kv('Burned', '${calories.burned} kcal'),
                    _kv('Remaining', '${calories.remaining} kcal'),
                  ],
                ),
              ),
            ],
          ),
          Gap(12.h),
          Text(
            _statusText(),
            style: TextStyle(
              fontSize: 13.sp,
              color: c,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            k,
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          ),
          Text(
            v,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
