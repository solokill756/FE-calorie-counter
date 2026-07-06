import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

/// A reusable date picker widget that works on both Android and iOS
/// Uses Flutter's built-in showDatePicker which automatically adapts to platform
class DatePickerWidget extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? label;
  final bool showIcon;
  final Color? iconColor;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;

  const DatePickerWidget({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
    this.firstDate,
    this.lastDate,
    this.label,
    this.showIcon = true,
    this.iconColor,
    this.backgroundColor,
    this.textStyle,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final isToday = DateUtils.isSameDay(selectedDate, DateTime.now());
    final dateText = isToday
        ? 'Today'
        : DateFormat('MMM d, yyyy').format(selectedDate);

    return GestureDetector(
      onTap: () => _showDatePicker(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showIcon) ...[
              Icon(
                Icons.calendar_today,
                size: 18.sp,
                color: iconColor ?? Colors.blue[600],
              ),
              SizedBox(width: 8.w),
            ],
            if (label != null) ...[
              Text(
                label!,
                style:
                    labelStyle ??
                    TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(width: 8.w),
            ],
            Text(
              dateText,
              style:
                  textStyle ??
                  TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.keyboard_arrow_down,
              size: 20.sp,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue[600]!,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
              secondary: Colors.blue[600]!,
              onSecondary: Colors.white,
            ),
            cardTheme: CardThemeData(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            textTheme: Theme.of(context).textTheme.copyWith(
              headlineSmall: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              bodyLarge: TextStyle(fontSize: 16.sp, color: Colors.black87),
              labelLarge: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue[600],
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: Colors.blue[600],
              headerForegroundColor: Colors.white,
              weekdayStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              dayStyle: TextStyle(fontSize: 14.sp, color: Colors.black87),
              yearStyle: TextStyle(fontSize: 14.sp, color: Colors.black87),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ), dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      onDateChanged(picked);
    }
  }
}

/// A compact date picker button widget
class DatePickerButton extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? format;

  const DatePickerButton({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
    this.firstDate,
    this.lastDate,
    this.format,
  });

  @override
  Widget build(BuildContext context) {
    final isToday = DateUtils.isSameDay(selectedDate, DateTime.now());
    final dateText = isToday
        ? 'Today'
        : (format != null
              ? DateFormat(format).format(selectedDate)
              : DateFormat('MMM d').format(selectedDate));

    return GestureDetector(
      onTap: () => _showDatePicker(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dateText,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.keyboard_arrow_down, size: 20.sp, color: Colors.grey),
        ],
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue[600]!,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
            cardTheme: CardThemeData(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue[600],
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            datePickerTheme: DatePickerThemeData(
              headerBackgroundColor: Colors.blue[600],
              headerForegroundColor: Colors.white,
            ), dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      onDateChanged(picked);
    }
  }
}
