import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressPhotoField extends StatelessWidget {
  final VoidCallback onTap;
  final String? photoPath;

  const ProgressPhotoField({super.key, required this.onTap, this.photoPath});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: scheme.outlineVariant, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Text(
              'Progress Photo',
              style: TextStyle(
                fontSize: 16.sp,
                color: scheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (photoPath == null) ...[
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 18.sp,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ] else ...[
              Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  image: DecorationImage(
                    image: FileImage(File(photoPath!)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
