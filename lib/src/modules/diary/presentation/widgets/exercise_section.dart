import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../domain/entities/diary_entity.dart';
import '../application/diary_cubit/diary_cubit.dart';

class ExerciseSection extends StatelessWidget {
  const ExerciseSection({super.key, required this.diary});
  final DiaryEntity diary;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isLocked = diary.isCompleted;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text('Exercise',
                style:
                    TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600)),
          ),
          if (diary.caloriesBurned > 0)
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Icon(Icons.phone_iphone,
                        color: Colors.white, size: 16.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('iPhone calorie adjustment',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500)),
                        Text('2.417 Steps',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600])),
                      ],
                    ),
                  ),
                  Text(
                    '${diary.caloriesBurned}',
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          if (diary.exercises.isNotEmpty)
            ...diary.exercises.map((ex) => _buildExerciseEntry(context, ex, isLocked)),
          Container(height: 1.h, color: Colors.grey[200]),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: GestureDetector(
              onTap: isLocked
                  ? () => AppDialogs.showWarningSnackBar(
                        message:
                            'This diary is completed. Editing is disabled.',
                      )
                  : () {},
              child: Row(
                children: [
                  Text(
                    'ADD EXERCISE',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isLocked ? scheme.outline : scheme.primary,
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.more_horiz,
                      color: scheme.onSurfaceVariant),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseEntry(
      BuildContext context, ExerciseEntry exercise, bool isLocked) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: Colors.orange[300],
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Icon(Icons.fitness_center,
                color: Colors.white, size: 16.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exercise.name,
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.w500)),
                Text('${exercise.duration} min',
                    style: TextStyle(
                        fontSize: 14.sp, color: Colors.grey[600])),
              ],
            ),
          ),
          Text(
            '${exercise.caloriesBurned}',
            style:
                TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 8.w),
          if (!isLocked)
            GestureDetector(
              onTap: () => context
                  .read<DiaryCubit>()
                  .removeExerciseEntry(exercise.id),
              child:
                  Icon(Icons.close, size: 20.sp, color: Colors.grey[400]),
            ),
        ],
      ),
    );
  }
}
