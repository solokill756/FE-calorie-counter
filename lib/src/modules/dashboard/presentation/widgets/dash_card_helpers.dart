import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

BorderRadius dashCardRadius() => BorderRadius.circular(16.r);

BoxDecoration dashCardDecoration(ColorScheme scheme) {
  return BoxDecoration(
    color: scheme.surfaceContainerLowest,
    borderRadius: dashCardRadius(),
    border: Border.all(color: scheme.outlineVariant),
    boxShadow: [
      BoxShadow(
        color: scheme.shadow.withValues(alpha: 0.06),
        blurRadius: 16,
        offset: const Offset(0, 4),
      ),
    ],
  );
}

BoxDecoration dashAiCardDecoration(ColorScheme scheme) {
  return BoxDecoration(
    borderRadius: dashCardRadius(),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        scheme.surfaceContainerLowest,
        Color.lerp(
          scheme.surfaceContainerLowest,
          scheme.primaryContainer,
          0.4,
        )!,
      ],
    ),
    border: Border.all(color: scheme.outlineVariant),
    boxShadow: [
      BoxShadow(
        color: scheme.shadow.withValues(alpha: 0.05),
        blurRadius: 14,
        offset: const Offset(0, 3),
      ),
    ],
  );
}

TextStyle dashCardTitleStyle(ColorScheme scheme) => TextStyle(
  fontSize: 17.sp,
  fontWeight: FontWeight.w600,
  color: scheme.onSurface,
);

Widget dashCardTitleRow(
  BuildContext context, {
  required IconData icon,
  required String title,
}) {
  final scheme = Theme.of(context).colorScheme;
  return Row(
    children: [
      Icon(icon, size: 22.sp, color: scheme.primary),
      Gap(10.w),
      Expanded(child: Text(title, style: dashCardTitleStyle(scheme))),
    ],
  );
}

/// Per-macro accent (dashboard-only).
const Color macroProtein = Color(0xFF1565C0);
const Color macroCarbs = Color(0xFFE65100);
const Color macroFat = Color(0xFF6A1B9A);

class DashCard extends StatelessWidget {
  const DashCard({super.key, required this.child, this.onTap, this.decoration});

  final Widget child;
  final VoidCallback? onTap;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final dec = decoration ?? dashCardDecoration(Theme.of(context).colorScheme);
    return Container(
      decoration: dec,
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: dashCardRadius(),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
            child: child,
          ),
        ),
      ),
    );
  }
}

class CalorieRingPainter extends CustomPainter {
  CalorieRingPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    this.strokeWidth = 10,
  });

  final double progress;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    final sweep = 2 * math.pi * progress.clamp(0.0, 1.0);
    if (sweep <= 0) return;
    final arcPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    const startAngle = -math.pi / 2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweep,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CalorieRingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.trackColor != trackColor ||
      oldDelegate.progressColor != progressColor ||
      oldDelegate.strokeWidth != strokeWidth;
}
