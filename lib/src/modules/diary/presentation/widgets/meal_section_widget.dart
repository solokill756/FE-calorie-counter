import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/theme/app_shell_ui.dart';
import '../../domain/entities/diary_entity.dart';
import '../application/diary_cubit/diary_cubit.dart';
import 'food_entry_tile.dart';

class MealSectionWidget extends StatelessWidget {
  const MealSectionWidget({
    super.key,
    required this.title,
    required this.mealType,
    required this.diary,
    required this.onAddFood,
    required this.onQuickAdd,
  });

  final String title;
  final String mealType;
  final DiaryEntity diary;
  final VoidCallback onAddFood;
  final VoidCallback onQuickAdd;

  List<FoodEntry> _foods() {
    switch (mealType) {
      case 'breakfast':
        return diary.breakfast;
      case 'lunch':
        return diary.lunch;
      case 'dinner':
        return diary.dinner;
      case 'snacks':
        return diary.snacks;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final foods = _foods();
    final mealCalories = foods.fold<int>(0, (sum, f) => sum + f.calories);
    final isLocked = diary.isCompleted;

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
                Text(title,
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.w600)),
                if (mealCalories > 0)
                  Text(
                    '$mealCalories cal',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500),
                  ),
              ],
            ),
          ),
          Container(height: 1.h, color: Colors.grey[200]),
          if (foods.isNotEmpty)
            ...foods.map((food) => FoodEntryTile(
                  food: food,
                  isLocked: isLocked,
                  onDelete: (id) =>
                      context.read<DiaryCubit>().removeFoodEntry(mealType, id),
                )),
          if (foods.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Text(
                'No food logged yet',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          _buildAddButton(context, isLocked),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, bool isLocked) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: isLocked
                  ? () => AppDialogs.showWarningSnackBar(
                        message:
                            'This diary is completed. Editing is disabled.',
                      )
                  : onAddFood,
              child: Text(
                'ADD FOOD',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isLocked ? Colors.grey : Colors.blue,
                ),
              ),
            ),
          ),
          if (!isLocked)
            GestureDetector(
              onTap: onQuickAdd,
              child: Icon(Icons.more_horiz, color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
