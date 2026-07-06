import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Shared screen chrome driven by [ColorScheme] — cards, app bar, fields, CTAs.
/// Use across modules instead of hardcoded greys/blues.
abstract final class AppShellUi {
  static ColorScheme _scheme(BuildContext context) =>
      Theme.of(context).colorScheme;

  /// Primary brand / links / progress (from theme).
  static Color accent(BuildContext context) => _scheme(context).primary;

  static Color macroCarbs(BuildContext context) => const Color(0xFFE65100);

  static Color macroFat(BuildContext context) => const Color(0xFF6A1B9A);

  static Color macroProtein(BuildContext context) => const Color(0xFF1565C0);

  static AppBar appBar(
    BuildContext context,
    String title, {
    List<Widget>? actions,
  }) {
    final scheme = _scheme(context);
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: scheme.onSurface,
        ),
      ),
      backgroundColor: scheme.surfaceContainerLowest,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      actions: actions,
    );
  }

  static BoxDecoration cardDecoration(BuildContext context) {
    final scheme = _scheme(context);
    return BoxDecoration(
      color: scheme.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: scheme.outlineVariant),
      boxShadow: [
        BoxShadow(
          color: scheme.shadow.withValues(alpha: 0.06),
          spreadRadius: 0,
          blurRadius: 12,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  static EdgeInsets pagePadding() =>
      EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h);

  static InputDecoration filledField(
    BuildContext context, {
    required String label,
    String? hint,
    Widget? prefix,
  }) {
    final scheme = _scheme(context);
    final borderRadius = BorderRadius.circular(12.r);
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefix,
      filled: true,
      fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: scheme.primary, width: 1.5),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
    );
  }

  static InputDecoration searchField(
    BuildContext context, {
    String hint = 'Search by name',
    bool showLeadingIcon = true,
  }) {
    final scheme = _scheme(context);
    final borderRadius = BorderRadius.circular(12.r);
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: scheme.onSurfaceVariant, fontSize: 14.sp),
      prefixIcon: showLeadingIcon
          ? Icon(Icons.search, color: scheme.onSurfaceVariant, size: 22.sp)
          : null,
      filled: true,
      fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: scheme.primary, width: 1.5),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      isDense: true,
    );
  }

  static Widget sectionTitle(BuildContext context, String text) {
    final scheme = _scheme(context);
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ),
    );
  }

  static ButtonStyle outlinedActionStyle(BuildContext context) {
    final scheme = _scheme(context);
    return OutlinedButton.styleFrom(
      foregroundColor: scheme.onSurface,
      side: BorderSide(color: scheme.outline),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    );
  }

  static ButtonStyle primaryCtaStyle(BuildContext context) {
    final scheme = _scheme(context);
    return FilledButton.styleFrom(
      backgroundColor: scheme.primary,
      foregroundColor: scheme.onPrimary,
      padding: EdgeInsets.symmetric(vertical: 14.h),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    );
  }

  static Widget listRowCard(
    BuildContext context, {
    required Widget child,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      margin: margin ?? EdgeInsets.only(bottom: 10.h),
      decoration: cardDecoration(context),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: _scheme(context).surfaceContainerLowest,
        child: child,
      ),
    );
  }
}
