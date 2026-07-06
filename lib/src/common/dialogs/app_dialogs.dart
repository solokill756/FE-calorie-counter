import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../common/extensions/build_context_x.dart';

import '../../../generated/colors.gen.dart';
import '../widgets/button_widget.dart';

class SnackBarStyles {
  /// Default success / positive feedback (replaces brand orange for neutral success).
  static const Color successBackground = Color(0xFF2E7D32);
  static const Color errorBackground = Color(0xFFC62828);
  static const Color warningBackground = Color(0xFFEF6C00);
  static const Color infoBackground = Color(0xFF1565C0);

  static const TextStyle messageStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle actionStyle = TextStyle(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static final ShapeBorder shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  );

  static const EdgeInsets margin = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );

  static const Duration defaultDuration = Duration(seconds: 2);
}

enum AlertType {
  notice,
  warning,
  error,
  confirm,
}

class AppDialogs {
  static Future<void> show({
    // required String title,
    required String content,
    String? titleAction1,
    String? titleAction2,
    Function()? action1,
    Function()? action2,
    AlertType type = AlertType.notice,
  }) {
    return Asuka.showDialog(builder: (context) {
      return AlertDialog(
        backgroundColor: ColorName.materialPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: SizedBox(
          width: context.isTablet ? 400 : 358.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: SizedBox(
                      width: 26,
                      height: 26,
                      child: Icon(Icons.close),
                    ),
                  ),
                ],
              ),
              Center(
                child: _getIcon(type),
              ),
              const Gap(16),
              Center(
                child: Text(
                  _getTitleAlert(type).toUpperCase(),
                  style: TextStyle(
                    color: ColorName.primary,
                    fontSize: 14,
                  ),
                ),
              ),
              const Gap(16),
              Center(
                child: Text(
                  content,
                  style: TextStyle(
                    color: ColorName.black,
                    fontSize: 12,
                  ),
                ),
              ),
              const Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (titleAction2 != null)
                    Expanded(
                      flex: 1,
                      child: ButtonWidget(
                        backgroundColor: ColorName.black,
                        borderSideColor: ColorName.primary,
                        title: titleAction2,
                        onTextButtonPressed: () {
                          Navigator.of(context).pop();
                          action2?.call();
                        },
                      ),
                    ),
                  const Gap(12),
                  Expanded(
                    flex: 1,
                    child: ButtonWidget(
                      title: titleAction1 ?? 'OK',
                      onTextButtonPressed: () {
                        Navigator.of(context).pop();
                        action1?.call();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  static Icon _getIcon(AlertType type) {
    switch (type) {
      case AlertType.error:
        return Icon(Icons.error);
      case AlertType.warning:
        return Icon(Icons.warning);
      case AlertType.notice:
        return Icon(Icons.notifications_none);
      case AlertType.confirm:
        return Icon(Icons.check);
    }
  }

  static String _getTitleAlert(AlertType type) {
    switch (type) {
      case AlertType.error:
        return 'Error';
      case AlertType.warning:
        return 'Warning';
      case AlertType.notice:
        return 'Notice';
      case AlertType.confirm:
        return 'Confirm';
    }
  }

  static void showSnackBar({
    required String message,
    Color backgroundColor = SnackBarStyles.successBackground,
    Duration duration = SnackBarStyles.defaultDuration,
    SnackBarAction? action,
  }) {
    Asuka.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: SnackBarStyles.messageStyle,
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: SnackBarStyles.shape,
        margin: SnackBarStyles.margin,
      ),
    );
  }

  static void showSuccessSnackBar({
    required String message,
    Duration duration = SnackBarStyles.defaultDuration,
    SnackBarAction? action,
  }) {
    showSnackBar(
      message: message,
      backgroundColor: SnackBarStyles.successBackground,
      duration: duration,
      action: action,
    );
  }

  static void showErrorSnackBar({
    required String message,
    Duration duration = SnackBarStyles.defaultDuration,
    SnackBarAction? action,
  }) {
    showSnackBar(
      message: message,
      backgroundColor: SnackBarStyles.errorBackground,
      duration: duration,
      action: action,
    );
  }

  static void showWarningSnackBar({
    required String message,
    Duration duration = SnackBarStyles.defaultDuration,
    SnackBarAction? action,
  }) {
    showSnackBar(
      message: message,
      backgroundColor: SnackBarStyles.warningBackground,
      duration: duration,
      action: action,
    );
  }

  static void showInfoSnackBar({
    required String message,
    Duration duration = SnackBarStyles.defaultDuration,
    SnackBarAction? action,
  }) {
    showSnackBar(
      message: message,
      backgroundColor: SnackBarStyles.infoBackground,
      duration: duration,
      action: action,
    );
  }
}
