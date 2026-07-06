import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/theme/app_shell_ui.dart';
import '../../../auth/presentation/application/cubit/user_profile_access.dart';
import '../../domain/entities/diary_entity.dart';

class MacroSection extends StatelessWidget {
  const MacroSection({super.key, required this.diary});
  final DiaryEntity diary;

  @override
  Widget build(BuildContext context) {
    final userProfile = readServerProfile();
    final macroGoals = userProfile?.macroGoals ??
        {'carbsG': 278.0, 'proteinG': 111.0, 'fatG': 74.0};

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
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
              Text('Macros',
                  style: TextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.w600)),
              Icon(Icons.more_horiz, color: Colors.grey),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMacroCircle(
                'Carbs',
                diary.carbsConsumed.toInt(),
                (macroGoals['carbsG'] as num).toInt(),
                AppShellUi.macroCarbs(context),
              ),
              _buildMacroCircle(
                'Fat',
                diary.fatConsumed.toInt(),
                (macroGoals['fatG'] as num).toInt(),
                AppShellUi.macroFat(context),
              ),
              _buildMacroCircle(
                'Protein',
                diary.proteinConsumed.toInt(),
                (macroGoals['proteinG'] as num).toInt(),
                AppShellUi.macroProtein(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroCircle(
      String label, int consumed, int goal, Color color) {
    final progress = goal > 0 ? (consumed / goal).clamp(0.0, 1.0) : 0.0;
    final remaining = (goal - consumed).clamp(0, goal);

    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: color),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: 70.w,
            height: 70.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 70.w,
                  height: 70.w,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 6.w,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text('$consumed',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold)),
                    ),
                    Flexible(
                      child: Text('/${goal}g',
                          style: TextStyle(
                              fontSize: 9.sp, color: Colors.grey[600])),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '${remaining}g left',
            style: TextStyle(fontSize: 9.sp, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
