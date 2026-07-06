import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';
import 'package:caloriecounter/src/modules/exercise/presentation/application/exercise_cubit/exercise_cubit.dart';
import 'package:caloriecounter/src/modules/exercise/presentation/widgets/exercise_notes_preview.dart';
import 'package:caloriecounter/src/modules/exercise/presentation/widgets/exercise_verification_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';

@RoutePage()
class ExerciseAddLogPage extends StatefulWidget {
  const ExerciseAddLogPage({super.key, required this.exerciseId});

  final int exerciseId;

  @override
  State<ExerciseAddLogPage> createState() => _ExerciseAddLogPageState();
}

class _ExerciseAddLogPageState extends State<ExerciseAddLogPage> {
  final _minutes = TextEditingController(text: '30');
  DateTime _startedAt = DateTime.now();
  bool _loading = true;
  String? _name;
  String? _notes;
  bool _isVerified = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final ex = await context.read<ExerciseCubit>().loadExerciseDetail(
        widget.exerciseId,
      );
      if (ex == null || !mounted) return;
      setState(() {
        _name = ex.name;
        _notes = ex.notes;
        _isVerified = ex.isVerified;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
      AppDialogs.showErrorSnackBar(message: 'Could not load exercise details');
    }
  }

  @override
  void dispose() {
    _minutes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final min = double.tryParse(_minutes.text.trim());
    if (min == null || min <= 0) {
      AppDialogs.showWarningSnackBar(
        message: 'Enter a valid duration in minutes',
      );
      return;
    }
    try {
      await context.read<ExerciseCubit>().createLogAndRefresh(
        exerciseId: widget.exerciseId,
        startedAt: _startedAt,
        minutesPerformed: min,
      );
      if (!mounted) return;
      AppDialogs.showSuccessSnackBar(message: 'Workout logged');
      if (!context.mounted) return;
      context.router.maybePop();
    } catch (_) {
      if (!mounted) return;
      AppDialogs.showErrorSnackBar(message: 'Failed to log workout');
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLow,
      appBar: AppShellUi.appBar(context, _name ?? 'Add log'),
      body: _loading
          ? Center(child: CircularProgressIndicator(color: scheme.primary))
          : _error != null
          ? ListView(
              padding: AppShellUi.pagePadding(),
              children: [
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: AppShellUi.cardDecoration(context),
                  child: Text(
                    _error!,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[800],
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            )
          : ListView(
              padding: AppShellUi.pagePadding(),
              children: [
                Container(
                  padding: EdgeInsets.all(18.w),
                  decoration: AppShellUi.cardDecoration(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22.r,
                            backgroundColor: scheme.primaryContainer,
                            child: Icon(
                              Icons.fitness_center,
                              color: scheme.primary,
                              size: 24.sp,
                            ),
                          ),
                          Gap(14.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _name ?? '',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[900],
                                    height: 1.25,
                                  ),
                                ),
                                Gap(6.h),
                                ExerciseVerificationBadge(isVerified: _isVerified),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (_notes != null && _notes!.trim().isNotEmpty) ...[
                        Gap(12.h),
                        ExerciseNotesPreview(notes: _notes),
                      ],
                    ],
                  ),
                ),
                Gap(16.h),
                AppShellUi.sectionTitle(context, 'Details'),
                Gap(10.h),
                AppShellUi.listRowCard(
                  context,
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    title: Text(
                      'Started at',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Text(
                        _startedAt.toLocal().toString().split('.').first,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[900],
                        ),
                      ),
                    ),
                    trailing: Icon(Icons.schedule, color: scheme.primary),
                    onTap: () async {
                      final d = await showDatePicker(
                        context: context,
                        initialDate: _startedAt,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now().add(const Duration(days: 1)),
                      );
                      if (d == null || !mounted) return;
                      if (!context.mounted) return;
                      final t = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(_startedAt),
                      );
                      if (t == null || !mounted) return;
                      setState(() {
                        _startedAt = DateTime(
                          d.year,
                          d.month,
                          d.day,
                          t.hour,
                          t.minute,
                        );
                      });
                    },
                  ),
                ),
                Gap(12.h),
                TextField(
                  controller: _minutes,
                  style: TextStyle(fontSize: 15.sp),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: AppShellUi.filledField(context, label: 'Minutes'),
                ),
                Gap(24.h),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: AppShellUi.primaryCtaStyle(context),
                    onPressed: _save,
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
