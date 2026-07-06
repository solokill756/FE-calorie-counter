import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';
import 'package:caloriecounter/src/core/utils/error_translator.dart';
import 'package:caloriecounter/src/common/widgets/data_fetch_loading_widget.dart';
import 'package:caloriecounter/src/common/widgets/unified_error_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../../../app/app_router.dart';
import '../../domain/entities/diary_entity.dart';
import '../application/diary_cubit/diary_cubit.dart';
import '../application/diary_cubit/diary_state.dart';
import '../dialogs/add_food_dialog.dart';
import '../widgets/calorie_section.dart';
import '../widgets/diary_complete_button.dart';
import '../widgets/diary_header.dart';
import '../widgets/exercise_section.dart';
import '../widgets/macro_section.dart';
import '../widgets/meal_section_widget.dart';
import '../widgets/notes_section.dart';
import '../widgets/water_section.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  @override
  void initState() {
    super.initState();
    context.read<DiaryCubit>().loadDiaryForDate(DateTime.now(), null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocListener<DiaryCubit, DiaryState>(
        listener: (context, state) {
          state.maybeWhen(
            removeFoodEntrySuccess: (selectedDate, diary, message) {
              AppDialogs.showSuccessSnackBar(message: message);
              context
                  .read<DiaryCubit>()
                  .loadDiaryForDate(selectedDate, diary);
            },
            removeFoodEntryError: (selectedDate, diary, message) {
              AppDialogs.showErrorSnackBar(message: message);
              context
                  .read<DiaryCubit>()
                  .loadDiaryForDate(selectedDate, diary);
            },
            orElse: () {},
          );
        },
        child: SafeArea(
          child: Column(
            children: [
              const DiaryHeader(),
              Expanded(
                child: BlocBuilder<DiaryCubit, DiaryState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      initial: (_) =>
                          const Center(child: CircularProgressIndicator()),
                      loading: (_, diary) {
                        if (diary != null) {
                          return _buildContent(context, diary);
                        }
                        return DataFetchLoadingWidget(
                          state: 'loading',
                          loadingMessage: 'Loading diary...',
                          loadingType: LoadingType.circular,
                          primaryColor: Colors.blue,
                        );
                      },
                      loaded: (_, diary) => _buildContent(context, diary),
                      error: (selectedDate, message, diary) {
                        if (diary != null) {
                          return _buildContent(context, diary);
                        }
                        return UnifiedErrorDisplay(
                          message: ErrorTranslator.getMessage(message),
                          subtitle: 'Please retry to load your diary.',
                          onRetry: () => context
                              .read<DiaryCubit>()
                              .loadDiaryForDate(selectedDate, null),
                          primaryColor:
                              Theme.of(context).colorScheme.primary,
                        );
                      },
                      orElse: () => const SizedBox.shrink(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DiaryEntity diary) {
    final cubit = context.read<DiaryCubit>();

    return Column(
      children: [
        CalorieSection(diary: diary),
        MacroSection(diary: diary),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () =>
                cubit.loadDiaryForDate(cubit.state.selectedDate, null),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  MealSectionWidget(
                    title: 'Breakfast',
                    mealType: 'breakfast',
                    diary: diary,
                    onAddFood: () => _navigateToLogFood('breakfast'),
                    onQuickAdd: () => _showAddFoodDialog('breakfast'),
                  ),
                  MealSectionWidget(
                    title: 'Lunch',
                    mealType: 'lunch',
                    diary: diary,
                    onAddFood: () => _navigateToLogFood('lunch'),
                    onQuickAdd: () => _showAddFoodDialog('lunch'),
                  ),
                  MealSectionWidget(
                    title: 'Dinner',
                    mealType: 'dinner',
                    diary: diary,
                    onAddFood: () => _navigateToLogFood('dinner'),
                    onQuickAdd: () => _showAddFoodDialog('dinner'),
                  ),
                  MealSectionWidget(
                    title: 'Snacks',
                    mealType: 'snacks',
                    diary: diary,
                    onAddFood: () => _navigateToLogFood('snacks'),
                    onQuickAdd: () => _showAddFoodDialog('snacks'),
                  ),
                  ExerciseSection(diary: diary),
                  WaterSection(diary: diary),
                  NotesSection(
                    diary: diary,
                    onEdit: diary.isCompleted
                        ? null
                        : () => _showNoteEditor(diary.note),
                  ),
                  DiaryCompleteButton(
                    diary: diary,
                    onComplete: diary.isCompleted
                        ? null
                        : () async {
                            final message =
                                await cubit.completeDiary();
                            if (!mounted) return;
                            if (message == null) {
                              AppDialogs.showSuccessSnackBar(
                                message: 'Diary marked as completed.',
                              );
                            } else {
                              AppDialogs.showErrorSnackBar(
                                message: message,
                              );
                            }
                          },
                  ),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToLogFood(String mealType) {
    final date = context.read<DiaryCubit>().state.selectedDate;
    context
        .pushRoute(LogFoodRoute(forDate: date, initialMeal: mealType))
        .then((_) {
      if (mounted) {
        context
            .read<DiaryCubit>()
            .loadDiaryForDate(
                context.read<DiaryCubit>().state.selectedDate, null);
      }
    });
  }

  void _showAddFoodDialog(String mealType) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => AddFoodDialog(
        onLogFood: () => _navigateToLogFood(mealType),
        onQuickAdd: () {
          Navigator.of(context).pop();
          context.pushRoute(
            QuickAddRoute(
                diaryDay:
                    context.read<DiaryCubit>().state.selectedDate),
          ).then((_) {
            if (mounted) {
              context
                  .read<DiaryCubit>()
                  .loadDiaryForDate(
                      context.read<DiaryCubit>().state.selectedDate,
                      null);
            }
          });
        },
      ),
    );
  }

  Future<void> _showNoteEditor(String? currentNote) async {
    final controller =
        TextEditingController(text: currentNote?.trim() ?? '');
    try {
      final scheme = Theme.of(context).colorScheme;
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: scheme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        builder: (sheetContext) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 16.h,
              bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 16.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: scheme.outlineVariant,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Diary note',
                  style: TextStyle(
                      fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: controller,
                  maxLines: 6,
                  maxLength: 2000,
                  decoration: InputDecoration(
                    labelText: 'Note',
                    hintText:
                        'Add anything you want to remember about this day',
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    TextButton(
                      onPressed: () =>
                          Navigator.of(sheetContext).pop(),
                      child: const Text('Cancel'),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () async {
                        final message = await context
                            .read<DiaryCubit>()
                            .clearNote();
                        if (!mounted) return;
                        Navigator.of(sheetContext).pop();
                        if (message == null) {
                          AppDialogs.showSuccessSnackBar(
                              message: 'Note cleared.');
                        } else {
                          AppDialogs.showErrorSnackBar(
                              message: message);
                        }
                      },
                      child: const Text('Clear'),
                    ),
                    SizedBox(width: 8.w),
                    FilledButton(
                      onPressed: () async {
                        final message = await context
                            .read<DiaryCubit>()
                            .updateNote(controller.text);
                        if (!mounted) return;
                        Navigator.of(sheetContext).pop();
                        if (message == null) {
                          AppDialogs.showSuccessSnackBar(
                              message: 'Note saved.');
                        } else {
                          AppDialogs.showErrorSnackBar(
                              message: message);
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    } finally {
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;
      controller.dispose();
    }
  }
}
