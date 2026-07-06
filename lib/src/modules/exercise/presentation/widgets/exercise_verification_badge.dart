import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExerciseVerificationBadge extends StatelessWidget {
  const ExerciseVerificationBadge({super.key, required this.isVerified});

  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final background = isVerified
        ? scheme.primaryContainer
        : scheme.tertiaryContainer;
    final foreground = isVerified
        ? scheme.onPrimaryContainer
        : scheme.onTertiaryContainer;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        isVerified ? 'Verified' : 'Pending review',
        style: TextStyle(
          color: foreground,
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
