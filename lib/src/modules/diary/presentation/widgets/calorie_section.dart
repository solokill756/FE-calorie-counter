import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/diary_entity.dart';

class CalorieSection extends StatelessWidget {
  const CalorieSection({super.key, required this.diary});
  final DiaryEntity diary;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 0.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Calories Remaining',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              Icon(Icons.more_horiz, color: Colors.grey),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCalItem('${diary.caloriesGoal}', 'Goal'),
              Text('-',
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
              _buildCalItem('${diary.caloriesConsumed}', 'Food'),
              Text('+',
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
              _buildCalItem('${diary.caloriesBurned}', 'Exercise'),
              Text('=',
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
              _buildCalItem('${diary.caloriesRemaining}', 'Remaining',
                  isHL: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalItem(String value, String label, {bool isHL = false}) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: isHL ? 24.sp : 18.sp,
            fontWeight: FontWeight.bold,
            color: isHL ? Colors.blue : Colors.black,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
