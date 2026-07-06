import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddComponents {
  static Widget buildQuickAddOptions(
    BuildContext context, {
    required VoidCallback onLogFoodTap,
    required VoidCallback onBarcodeScanTap,
    required VoidCallback onVoiceLogTap,
    required VoidCallback onMealScanTap,
    required VoidCallback onWaterTap,
    required VoidCallback onWeightTap,
    required VoidCallback onExerciseTap,
    required VoidCallback onAiSuggestRecipeTap,
    required VoidCallback onAiPhotoRecipeTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Options Grid
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // First row — Log Food + Log Water
              Row(
                children: [
                  Expanded(
                    child: _buildGridOption(
                      icon: Icons.restaurant_rounded,
                      title: 'Log Food',
                      color: scheme.primary,
                      onTap: onLogFoodTap,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildGridOption(
                      icon: Icons.water_drop_rounded,
                      title: 'Log Water',
                      color: scheme.tertiary,
                      onTap: onWaterTap,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: _buildGridOption(
                      icon: Icons.auto_awesome,
                      title: 'AI Suggest Recipe',
                      color: scheme.secondary,
                      onTap: onAiSuggestRecipeTap,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildGridOption(
                      icon: Icons.image_search_outlined,
                      title: 'AI Photo Recipe',
                      color: scheme.primary,
                      onTap: onAiPhotoRecipeTap,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Fourth Row - Weight (Compact)
              _buildCompactOption(
                icon: Icons.monitor_weight,
                title: 'Weight',
                color: Colors.indigo,
                onTap: onWeightTap,
              ),
              SizedBox(height: 8.h),
              _buildCompactOption(
                icon: Icons.fitness_center,
                title: 'Exercise',
                color: Colors.deepOrange,
                onTap: onExerciseTap,
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }

  // Grid option for 4 main options (icon on top, text below)
  static Widget _buildGridOption({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 85.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20.sp),
            ),
            SizedBox(height: 8.h),
            // Text
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.1,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // Compact option for 3 bottom options (smaller size)
  static Widget _buildCompactOption({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            children: [
              // Icon Circle (smaller)
              Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 16.sp),
              ),
              SizedBox(width: 12.w),
              // Text Content
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Arrow Icon (smaller)
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 12.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
