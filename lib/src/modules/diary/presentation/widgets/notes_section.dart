import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/diary_entity.dart';

class NotesSection extends StatelessWidget {
  const NotesSection(
      {super.key, required this.diary, this.onEdit});
  final DiaryEntity diary;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final note = diary.note?.trim() ?? '';

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: onEdit,
                  child: Text(note.isEmpty ? 'Add' : 'Edit'),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              note.isEmpty ? 'No notes yet' : note,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.35,
                color: note.isEmpty
                    ? scheme.onSurfaceVariant
                    : scheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
