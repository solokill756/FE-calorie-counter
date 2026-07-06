import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';
import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:caloriecounter/src/modules/exercise/domain/repository/exercise_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';

@RoutePage()
class ExerciseFormPage extends StatefulWidget {
  const ExerciseFormPage({super.key, this.exerciseId});

  /// When null, creates a new catalog exercise; otherwise edits existing.
  final int? exerciseId;

  @override
  State<ExerciseFormPage> createState() => _ExerciseFormPageState();
}

class _ExerciseFormPageState extends State<ExerciseFormPage> {
  final _name = TextEditingController();
  final _met = TextEditingController();
  final _defaultCal = TextEditingController();
  final _notes = TextEditingController();
  String _type = 'cardio';
  bool _loading = false;
  bool _loadError = false;
  bool _readOnly = false;

  bool get _isEdit => widget.exerciseId != null;

  @override
  void initState() {
    super.initState();
    if (_isEdit) {
      _load();
    }
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _loadError = false;
    });
    try {
      final ex = await getIt<ExerciseRepository>().getExercise(
        widget.exerciseId!,
      );
      _name.text = ex.name;
      _type = ex.type;
      if (ex.met != null) _met.text = ex.met!.toString();
      if (ex.defaultCalPerMin != null) {
        _defaultCal.text = ex.defaultCalPerMin!.toString();
      }
      if (ex.notes != null && ex.notes!.isNotEmpty) _notes.text = ex.notes!;
      setState(() {
        _loading = false;
        _readOnly = !ex.isOwned;
      });
      if (_readOnly && mounted) {
        AppDialogs.showWarningSnackBar(
          message: 'Only exercises you created can be edited',
        );
      }
    } catch (_) {
      setState(() {
        _loading = false;
        _loadError = true;
      });
      AppDialogs.showErrorSnackBar(message: 'Could not load exercise');
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _met.dispose();
    _defaultCal.dispose();
    _notes.dispose();
    super.dispose();
  }

  double? _tryParseOptionalNumber(
    String raw,
    String label, {
    bool allowEmpty = true,
  }) {
    final t = raw.trim();
    if (t.isEmpty) return allowEmpty ? null : double.nan;
    final v = double.tryParse(t);
    if (v == null || v <= 0) {
      _invalidNumber(label);
      return double.nan;
    }
    return v;
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) {
      AppDialogs.showWarningSnackBar(message: 'Please enter a name');
      return;
    }

    final met = _tryParseOptionalNumber(_met.text, 'MET');
    if (met != null && met.isNaN) return;
    final dpm = _tryParseOptionalNumber(_defaultCal.text, 'Default cal/min');
    if (dpm != null && dpm.isNaN) return;

    final notes = _notes.text.trim();

    setState(() => _loading = true);
    try {
      if (_isEdit) {
        await getIt<ExerciseRepository>().updateExercise(
          widget.exerciseId!,
          name: name,
          type: _type,
          met: met,
          defaultCalPerMin: dpm,
          notes: notes,
        );
      } else {
        await getIt<ExerciseRepository>().createExercise(
          name: name,
          type: _type,
          met: met,
          defaultCalPerMin: dpm,
          notes: notes.isEmpty ? null : notes,
        );
      }
      if (!mounted) return;
      AppDialogs.showSuccessSnackBar(
        message: _isEdit ? 'Exercise updated' : 'Exercise created',
      );
      if (!context.mounted) return;
      context.router.maybePop(true);
    } catch (e) {
      if (!mounted) return;
      AppDialogs.showErrorSnackBar(
        message: _isEdit ? 'Failed to update exercise' : 'Failed to create exercise',
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _invalidNumber(String label) {
    AppDialogs.showWarningSnackBar(
      message: '$label must be a positive number',
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLow,
      appBar: AppShellUi.appBar(
        context,
        _isEdit ? 'Edit exercise' : 'New exercise',
      ),
      body: _loadError
          ? Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Could not load exercise.',
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    Gap(16.h),
                    FilledButton(
                      style: AppShellUi.primaryCtaStyle(context),
                      onPressed: _load,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          : _loading && _isEdit && _name.text.isEmpty
          ? Center(child: CircularProgressIndicator(color: scheme.primary))
          : AbsorbPointer(
              absorbing: _loading || _readOnly,
              child: ListView(
                padding: AppShellUi.pagePadding(),
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: AppShellUi.cardDecoration(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: _name,
                          style: TextStyle(fontSize: 15.sp),
                          decoration: AppShellUi.filledField(
                            context,
                            label: 'Name',
                          ),
                        ),
                        Gap(14.h),
                        Text(
                          'Type',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                        Gap(8.h),
                        SegmentedButton<String>(
                          style: SegmentedButton.styleFrom(
                            backgroundColor: scheme.surfaceContainerHigh,
                            foregroundColor: scheme.onSurface,
                            selectedBackgroundColor: scheme.primaryContainer,
                            selectedForegroundColor: scheme.primary,
                            side: BorderSide(color: scheme.outlineVariant),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          segments: const [
                            ButtonSegment(
                              value: 'cardio',
                              label: Text('Cardio'),
                            ),
                            ButtonSegment(
                              value: 'strength',
                              label: Text('Strength'),
                            ),
                          ],
                          selected: {_type},
                          onSelectionChanged: (s) {
                            setState(() => _type = s.first);
                          },
                        ),
                        Gap(14.h),
                        TextField(
                          controller: _met,
                          style: TextStyle(fontSize: 15.sp),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: AppShellUi.filledField(
                            context,
                            label: 'MET (optional)',
                            hint: 'e.g. 8',
                          ),
                        ),
                        Gap(14.h),
                        TextField(
                          controller: _defaultCal,
                          style: TextStyle(fontSize: 15.sp),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: AppShellUi.filledField(
                            context,
                            label: 'Default kcal/min (optional)',
                            hint: 'e.g. 10',
                          ),
                        ),
                        Gap(14.h),
                        TextField(
                          controller: _notes,
                          style: TextStyle(fontSize: 15.sp),
                          maxLines: 3,
                          decoration: AppShellUi.filledField(
                            context,
                            label: 'Notes (optional)',
                          ),
                        ),
                        if (!_isEdit) ...[
                          Gap(14.h),
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: scheme.tertiaryContainer,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.verified_outlined,
                                  color: scheme.onTertiaryContainer,
                                  size: 20.sp,
                                ),
                                Gap(10.w),
                                Expanded(
                                  child: Text(
                                    'New exercises are marked Pending review until an admin verifies them.',
                                    style: TextStyle(
                                      color: scheme.onTertiaryContainer,
                                      fontSize: 13.sp,
                                      height: 1.35,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Gap(20.h),
                  if (_readOnly)
                    Text(
                      'This exercise is from the catalog and cannot be edited here.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[700],
                        height: 1.35,
                      ),
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: AppShellUi.primaryCtaStyle(context),
                        onPressed: _loading ? null : _save,
                        child: _loading
                            ? SizedBox(
                                height: 22.h,
                                width: 22.h,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                _isEdit ? 'Save changes' : 'Create',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
