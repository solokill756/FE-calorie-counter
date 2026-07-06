import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationButtons extends StatelessWidget {
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final bool isNextEnabled;
  final String nextButtonText;
  final bool showBackButton;

  const NavigationButtons({
    super.key,
    this.onNext,
    this.onBack,
    this.isNextEnabled = true,
    this.nextButtonText = 'Next',
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBackButton) ...[
          // Back Button
          Container(
            width: 56.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: onBack,
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black87,
                size: 24.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
        ],

        // Next Button
        Expanded(
          child: SizedBox(
            height: 50.h,
            child: ElevatedButton(
              onPressed: isNextEnabled ? onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E88E5),
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                elevation: 0,
              ),
              child: Text(
                nextButtonText,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
