import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/diary_entity.dart';

class DiaryCompleteButton extends StatelessWidget {
  const DiaryCompleteButton(
      {super.key, required this.diary, this.onComplete});
  final DiaryEntity diary;
  final VoidCallback? onComplete;

  @override
  Widget build(BuildContext context) {
    final isCompleted = diary.isCompleted;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isCompleted ? null : onComplete,
          style: ElevatedButton.styleFrom(
            backgroundColor: isCompleted ? Colors.grey : Colors.blue,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            elevation: 0,
          ),
          child: Text(
            isCompleted ? 'DIARY COMPLETED' : 'COMPLETE DIARY',
            style:
                TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
