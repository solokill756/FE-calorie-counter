import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/theme/app_shell_ui.dart';
import '../../domain/entities/diary_entity.dart';

class WaterSection extends StatelessWidget {
  const WaterSection({super.key, required this.diary});
  final DiaryEntity diary;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final waterTarget =
        diary.waterTargetMl <= 0 ? 2500 : diary.waterTargetMl;
    final progress =
        (diary.waterAmountMl / waterTarget).clamp(0.0, 1.0);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
      decoration: AppShellUi.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Water',
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.w600)),
                if (diary.waterAmountMl > 0)
                  Text(
                    '${diary.waterAmountMl} / $waterTarget ml',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500),
                  ),
              ],
            ),
          ),
          Container(height: 1.h, color: Colors.grey[200]),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999.r),
              child: SizedBox(
                height: 10.h,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ColoredBox(color: scheme.outlineVariant),
                    FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress,
                      child: ColoredBox(color: scheme.tertiary),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Text(
              'ADD WATER',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: scheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
