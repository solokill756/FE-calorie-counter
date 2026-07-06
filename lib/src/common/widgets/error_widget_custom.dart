import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/data/remote/base/api_error.dart';

/// Enum định nghĩa các loại error
enum ErrorType {
  network,
  server,
  validation,
  unauthorized,
  notFound,
  generic,
  empty,
}

/// Widget hiển thị lỗi khi loading data - Cải thiện và tái sử dụng
///
/// Sử dụng:
/// ```dart
/// ErrorWidgetCustom(
///   message: 'Failed to load data',
///   onRetry: () => context.read<ProgressCubit>().fetchProgress(),
///   errorType: ErrorType.network,
/// )
/// ```
class ErrorWidgetCustom extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  final String? title;
  final IconData? icon;
  final bool showRetryButton;
  final ErrorType errorType;
  final Widget? customIcon;
  final List<Widget>? customActions;
  final Color? backgroundColor;
  final Color? iconColor;
  final EdgeInsets? padding;
  final double? iconSize;
  final bool showAnimation;

  const ErrorWidgetCustom({
    super.key,
    this.message,
    this.onRetry,
    this.title,
    this.icon,
    this.showRetryButton = true,
    this.errorType = ErrorType.generic,
    this.customIcon,
    this.customActions,
    this.backgroundColor,
    this.iconColor,
    this.padding,
    this.iconSize,
    this.showAnimation = true,
  });

  @override
  Widget build(BuildContext context) {
    final errorConfig = _getErrorConfig(errorType);
    final effectiveIcon =
        customIcon ??
        Icon(
          icon ?? errorConfig.icon,
          size: iconSize ?? 48.sp,
          color: iconColor ?? errorConfig.iconColor,
        );
    final effectiveTitle = title ?? errorConfig.title;
    final effectiveMessage = message ?? errorConfig.message;
    final effectiveBgColor = backgroundColor ?? errorConfig.backgroundColor;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: padding ?? EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Error Icon
              if (showAnimation)
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutBack,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: value.clamp(0.0, 1.0),
                        child: child,
                      ),
                    );
                  },
                  child: _buildIconContainer(
                    effectiveIcon,
                    effectiveBgColor,
                    errorConfig.iconColor,
                  ),
                )
              else
                _buildIconContainer(
                  effectiveIcon,
                  effectiveBgColor,
                  errorConfig.iconColor,
                ),

              SizedBox(height: 24.h),

              // Error Title
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 10 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  effectiveTitle,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 12.h),

              // Error Message
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 10 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  effectiveMessage,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(height: 32.h),

              // Custom Actions or Default Retry Button
              if (customActions != null && customActions!.isNotEmpty)
                ...customActions!
              else if (showRetryButton && onRetry != null)
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 10 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: _buildRetryButton(errorConfig),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconContainer(Widget icon, Color bgColor, Color iconColor) {
    return Container(
      width: 100.w,
      height: 100.w,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: iconColor.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Center(child: icon),
    );
  }

  Widget _buildRetryButton(_ErrorConfig config) {
    return ElevatedButton.icon(
      onPressed: onRetry,
      icon: Icon(Icons.refresh, size: 18.sp),
      label: Text(
        'Retry',
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: config.buttonColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  _ErrorConfig _getErrorConfig(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return _ErrorConfig(
          icon: Icons.wifi_off_rounded,
          title: 'No Internet Connection',
          message: 'Please check your internet connection and try again.',
          iconColor: Colors.orange,
          backgroundColor: Colors.orange[50]!,
          buttonColor: Colors.orange,
        );
      case ErrorType.server:
        return _ErrorConfig(
          icon: Icons.cloud_off_rounded,
          title: 'Server Error',
          message: 'Something went wrong on our end. Please try again later.',
          iconColor: Colors.red,
          backgroundColor: Colors.red[50]!,
          buttonColor: Colors.red,
        );
      case ErrorType.validation:
        return _ErrorConfig(
          icon: Icons.info_outline_rounded,
          title: 'Validation Error',
          message: message ?? 'Please check your input and try again.',
          iconColor: Colors.amber,
          backgroundColor: Colors.amber[50]!,
          buttonColor: Colors.amber[700]!,
        );
      case ErrorType.unauthorized:
        return _ErrorConfig(
          icon: Icons.lock_outline_rounded,
          title: 'Unauthorized',
          message: 'You don\'t have permission to access this resource.',
          iconColor: Colors.purple,
          backgroundColor: Colors.purple[50]!,
          buttonColor: Colors.purple,
        );
      case ErrorType.notFound:
        return _ErrorConfig(
          icon: Icons.search_off_rounded,
          title: 'Not Found',
          message: 'The requested resource could not be found.',
          iconColor: Colors.blueGrey,
          backgroundColor: Colors.blueGrey[50]!,
          buttonColor: Colors.blueGrey,
        );
      case ErrorType.empty:
        return _ErrorConfig(
          icon: Icons.inbox_outlined,
          title: 'No Data Available',
          message: message ?? 'There\'s nothing here yet.',
          iconColor: Colors.grey,
          backgroundColor: Colors.grey[100]!,
          buttonColor: Colors.grey[600]!,
        );
      case ErrorType.generic:
        return _ErrorConfig(
          icon: Icons.error_outline_rounded,
          title: 'Oops! Something went wrong',
          message: message ?? 'Failed to load data. Please try again.',
          iconColor: Colors.red,
          backgroundColor: Colors.red[50]!,
          buttonColor: Colors.red,
        );
    }
  }
}

class _ErrorConfig {
  final IconData icon;
  final String title;
  final String message;
  final Color iconColor;
  final Color backgroundColor;
  final Color buttonColor;

  _ErrorConfig({
    required this.icon,
    required this.title,
    required this.message,
    required this.iconColor,
    required this.backgroundColor,
    required this.buttonColor,
  });
}

/// Extension để map ApiError sang ErrorType
extension ApiErrorExtension on ApiError {
  ErrorType get errorType {
    return maybeWhen(
      orElse: () => ErrorType.generic,
      (code, message) => ErrorType.generic,
      network: (code, message) => ErrorType.network,
      server: (code, message) => ErrorType.server,
      validation: (statusCode, errors) => ErrorType.validation,
      unauthorized: (message) => ErrorType.unauthorized,
      conflict: (code, message) => ErrorType.server,
      unexpected: () => ErrorType.generic,
    );
  }
}

/// Widget hiển thị lỗi trong Dialog - Cải thiện
class ErrorDialog extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback? onRetry;
  final ErrorType errorType;
  final IconData? icon;

  const ErrorDialog({
    super.key,
    required this.message,
    this.title,
    this.onRetry,
    this.errorType = ErrorType.generic,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final errorConfig = _getErrorConfig(errorType);

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      title: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: errorConfig.backgroundColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon ?? errorConfig.icon,
              color: errorConfig.iconColor,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title ?? errorConfig.title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
      content: Text(
        message,
        style: TextStyle(fontSize: 14.sp, color: Colors.grey[700], height: 1.5),
      ),
      actions: [
        if (onRetry != null)
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onRetry?.call();
            },
            child: Text(
              'Retry',
              style: TextStyle(
                fontSize: 14.sp,
                color: errorConfig.buttonColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Close',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  _ErrorConfig _getErrorConfig(ErrorType type) {
    switch (type) {
      case ErrorType.network:
        return _ErrorConfig(
          icon: Icons.wifi_off_rounded,
          title: 'No Internet Connection',
          message: message,
          iconColor: Colors.orange,
          backgroundColor: Colors.orange[50]!,
          buttonColor: Colors.orange,
        );
      case ErrorType.server:
        return _ErrorConfig(
          icon: Icons.cloud_off_rounded,
          title: 'Server Error',
          message: message,
          iconColor: Colors.red,
          backgroundColor: Colors.red[50]!,
          buttonColor: Colors.red,
        );
      case ErrorType.validation:
        return _ErrorConfig(
          icon: Icons.info_outline_rounded,
          title: 'Validation Error',
          message: message,
          iconColor: Colors.amber,
          backgroundColor: Colors.amber[50]!,
          buttonColor: Colors.amber[700]!,
        );
      case ErrorType.unauthorized:
        return _ErrorConfig(
          icon: Icons.lock_outline_rounded,
          title: 'Unauthorized',
          message: message,
          iconColor: Colors.purple,
          backgroundColor: Colors.purple[50]!,
          buttonColor: Colors.purple,
        );
      case ErrorType.notFound:
        return _ErrorConfig(
          icon: Icons.search_off_rounded,
          title: 'Not Found',
          message: message,
          iconColor: Colors.blueGrey,
          backgroundColor: Colors.blueGrey[50]!,
          buttonColor: Colors.blueGrey,
        );
      case ErrorType.empty:
        return _ErrorConfig(
          icon: Icons.inbox_outlined,
          title: 'No Data',
          message: message,
          iconColor: Colors.grey,
          backgroundColor: Colors.grey[100]!,
          buttonColor: Colors.grey[600]!,
        );
      case ErrorType.generic:
        return _ErrorConfig(
          icon: Icons.error_outline_rounded,
          title: 'Error',
          message: message,
          iconColor: Colors.red,
          backgroundColor: Colors.red[50]!,
          buttonColor: Colors.red,
        );
    }
  }
}

/// Widget hiển thị empty state - Tái sử dụng
class EmptyStateWidget extends StatelessWidget {
  final String? message;
  final String? title;
  final IconData? icon;
  final Widget? customIcon;
  final VoidCallback? onAction;
  final String? actionLabel;
  final bool showAction;

  const EmptyStateWidget({
    super.key,
    this.message,
    this.title,
    this.icon,
    this.customIcon,
    this.onAction,
    this.actionLabel,
    this.showAction = false,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidgetCustom(
      errorType: ErrorType.empty,
      title: title,
      message: message,
      icon: icon ?? Icons.inbox_outlined,
      customIcon: customIcon,
      showRetryButton: showAction,
      onRetry: onAction,
      customActions: showAction && onAction != null
          ? [
              ElevatedButton.icon(
                onPressed: onAction,
                icon: Icon(Icons.add, size: 18.sp),
                label: Text(
                  actionLabel ?? 'Add New',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.w,
                    vertical: 14.h,
                  ),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ]
          : null,
    );
  }
}
