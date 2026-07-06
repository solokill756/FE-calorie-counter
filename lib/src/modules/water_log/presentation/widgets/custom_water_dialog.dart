import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';
import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shows a dialog for entering a custom water amount.
/// Returns the amount in ml, or null if the user cancels.
Future<int?> showCustomWaterDialog(BuildContext context) async {
  final controller = TextEditingController();
  try {
    final submitted = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(
            'Add water',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: AppShellUi.filledField(
              ctx,
              label: 'Amount (ml)',
              hint: '50–3000',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              style: AppShellUi.primaryCtaStyle(ctx),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
    if (submitted != true) return null;
    final parsed = int.tryParse(controller.text.trim());
    if (parsed == null || parsed < 50 || parsed > 3000) {
      if (context.mounted) {
        AppDialogs.showWarningSnackBar(
          message: 'Enter an amount between 50 and 3000 ml',
        );
      }
      return null;
    }
    return parsed;
  } finally {
    controller.dispose();
  }
}
