import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/modules/logfood/helper/log_food_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../application/exercise_cubit/exercise_cubit.dart';
import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';

@RoutePage()
class ExerciseHistoryPage extends StatefulWidget {
  const ExerciseHistoryPage({super.key});

  @override
  State<ExerciseHistoryPage> createState() => _ExerciseHistoryPageState();
}

class _ExerciseHistoryPageState extends State<ExerciseHistoryPage> {
  int _preset = 0;
  late String _from;
  late String _to;

  @override
  void initState() {
    super.initState();
    _applyPreset(0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExerciseCubit>().loadHistory(_from, _to);
    });
  }

  void _applyPreset(int i) {
    final h = LogFoodHelper();
    final now = DateTime.now();
    _to = h.dateKeyFrom(now);
    switch (i) {
      case 0:
        _from = _to;
        break;
      case 1:
        _from = h.dateKeyFrom(now.subtract(const Duration(days: 7)));
        break;
      case 2:
        _from = h.dateKeyFrom(now.subtract(const Duration(days: 30)));
        break;
      default:
        _from = _to;
    }
    _preset = i;
  }

  Future<void> _pickCustomRange() async {
    final now = DateTime.now();
    final first = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: now,
    );
    if (first == null || !mounted) return;
    final last = await showDatePicker(
      context: context,
      initialDate: first,
      firstDate: first,
      lastDate: now,
    );
    if (last == null || !mounted) return;
    final h = LogFoodHelper();
    setState(() {
      _preset = 3;
      _from = h.dateKeyFrom(first);
      _to = h.dateKeyFrom(last);
    });
    if (!mounted) return;
    await context.read<ExerciseCubit>().loadHistory(_from, _to);
  }



  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final chipTheme = ChipThemeData(
      side: BorderSide(color: scheme.outlineVariant),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      labelStyle: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: scheme.onSurface,
      ),
    );

    return Scaffold(
      backgroundColor: scheme.surfaceContainerLow,
      appBar: AppShellUi.appBar(context, 'History'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
            child: Container(
              padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
              decoration: AppShellUi.cardDecoration(context),
              child: Theme(
                data: Theme.of(context).copyWith(chipTheme: chipTheme),
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    ChoiceChip(
                      label: Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: scheme.onSurface,
                        ),
                      ),
                      selected: _preset == 0,
                      selectedColor: scheme.primaryContainer,
                      checkmarkColor: scheme.primary,
                      backgroundColor: Colors.white,
                      onSelected: (_) {
                        setState(() => _applyPreset(0));
                        context.read<ExerciseCubit>().loadHistory(_from, _to);
                      },
                    ),
                    ChoiceChip(
                      backgroundColor: Colors.white,
                      label: Text(
                        '7 days',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: scheme.onSurface,
                        ),
                      ),
                      selected: _preset == 1,
                      selectedColor: scheme.primaryContainer,
                      checkmarkColor: scheme.primary,
                      onSelected: (_) {
                        setState(() => _applyPreset(1));
                        context.read<ExerciseCubit>().loadHistory(_from, _to);
                      },
                    ),
                    ChoiceChip(
                      label: Text(
                        '30 days',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: scheme.onSurface,
                        ),
                      ),
                      selected: _preset == 2,
                      selectedColor: scheme.secondaryContainer,
                      checkmarkColor: scheme.secondary,
                      backgroundColor: Colors.white,
                      onSelected: (_) {
                        setState(() => _applyPreset(2));
                        context.read<ExerciseCubit>().loadHistory(_from, _to);
                      },
                    ),
                    ActionChip(
                      label: Text(
                        'Custom…',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                      backgroundColor: scheme.surfaceContainerHighest
                          .withValues(alpha: 0.5),
                      side: BorderSide(color: scheme.outline),
                      onPressed: _pickCustomRange,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
            child: Text(
              '$_from → $_to',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Gap(8.h),
          Expanded(
            child: BlocBuilder<ExerciseCubit, ExerciseUiState>(
              builder: (context, s) {
                if (s.listLoading && s.history == null) {
                  return Center(
                    child: CircularProgressIndicator(color: scheme.primary),
                  );
                }
                final items = s.history?.items ?? [];
                if (items.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Text(
                        s.error ?? 'No logs in this range.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                          height: 1.4,
                        ),
                      ),
                    ),
                  );
                }
                return RefreshIndicator(
                  color: scheme.primary,
                  onRefresh: () =>
                      context.read<ExerciseCubit>().loadHistory(_from, _to),
                  child: ListView.builder(
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                    itemCount: items.length,
                    itemBuilder: (context, i) {
                      final e = items[i];
                      return AppShellUi.listRowCard(
                        context,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          title: Text(
                            e.exerciseName,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: Colors.grey[900],
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 6.h),
                            child: Text(
                              '${e.startedAt.toLocal().toString().split('.').first}\n'
                              '${e.minutesPerformed.toStringAsFixed(0)} min · '
                              '${e.caloriesBurned.toStringAsFixed(0)} kcal',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.grey[700],
                                height: 1.35,
                              ),
                            ),
                          ),

                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
