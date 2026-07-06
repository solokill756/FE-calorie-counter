import 'package:caloriecounter/src/modules/water_log/presentation/widgets/custom_water_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// Shows a bottom sheet with quick-add buttons and a custom amount option.
///
/// [onAdd] is called with the ml amount after the sheet is dismissed.
/// Pass a Cubit's add method (e.g. `DashboardCubit.addWater` or `WaterLogCubit.addMl`).
void showAddWaterSheet(
  BuildContext context, {
  required Future<void> Function(int ml) onAdd,
  bool isBusy = false,
}) {
  if (isBusy) return;
  final scheme = Theme.of(context).colorScheme;
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    backgroundColor: scheme.surfaceContainerLowest,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (sheetContext) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add water',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
              Gap(16.h),
              for (final ml in [250, 500, 1000])
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: FilledButton.tonal(
                    onPressed: isBusy
                        ? null
                        : () async {
                            Navigator.of(sheetContext).pop();
                            await onAdd(ml);
                          },
                    child: Text(
                      '+$ml ml',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              OutlinedButton(
                onPressed: isBusy
                    ? null
                    : () async {
                        Navigator.of(sheetContext).pop();
                        final parsed = await showCustomWaterDialog(context);
                        if (parsed != null) {
                          await onAdd(parsed);
                        }
                      },
                style: OutlinedButton.styleFrom(
                  foregroundColor: scheme.onSurface,
                  side: BorderSide(color: scheme.outline),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  'Custom amount',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
