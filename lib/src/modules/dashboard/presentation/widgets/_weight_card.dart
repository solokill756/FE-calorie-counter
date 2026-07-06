import 'package:caloriecounter/src/modules/dashboard/data/models/dashboard_today_response.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/dash_card_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class WeightCard extends StatelessWidget {
  const WeightCard({super.key, required this.weight, this.onTap});

  final DashboardWeightSection weight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final start = weight.startKg;
    final cur = weight.currentKg;
    final goal = weight.goalKg;
    final isGainGoal = start != null && goal != null && goal > start;
    final progressKg = isGainGoal
        ? weight.totalChangeKg
        : -weight.totalChangeKg;
    final progressLabel = isGainGoal ? 'Gained' : 'Lost';
    final progressPrefix = progressKg > 0 ? '+' : '';
    return DashCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dashCardTitleRow(
            context,
            icon: Icons.monitor_weight_outlined,
            title: 'Weight',
          ),
          Gap(10.h),
          Text(
            start != null
                ? 'Start: ${start.toStringAsFixed(1)} kg'
                : 'Start: -',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          ),
          Text(
            cur != null
                ? 'Current: ${cur.toStringAsFixed(1)} kg'
                : 'Current: —',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
          ),
          Text(
            goal != null ? 'Goal: ${goal.toStringAsFixed(1)} kg' : 'Goal: —',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          ),
          Text(
            '$progressLabel: $progressPrefix${progressKg.toStringAsFixed(1)} kg',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          ),
          if (weight.history.isNotEmpty) ...[
            Gap(10.h),
            SizedBox(
              height: 44.h,
              child: CustomPaint(
                painter: SparklinePainter(
                  weight.history,
                  accentColor: Theme.of(context).colorScheme.primary,
                ),
                child: const SizedBox.expand(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class SparklinePainter extends CustomPainter {
  SparklinePainter(this.points, {required this.accentColor});

  final List<DashboardWeightPoint> points;
  final Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;
    final ys = points.map((e) => e.weightKg).toList();
    final minY = ys.reduce((a, b) => a < b ? a : b);
    final maxY = ys.reduce((a, b) => a > b ? a : b);
    final dy = (maxY - minY).abs() < 1e-6 ? 1.0 : (maxY - minY);

    Offset pt(int i) {
      final x = size.width * (i / (points.length - 1));
      final ny = (points[i].weightKg - minY) / dy;
      final y = size.height - ny * size.height * 0.82 - size.height * 0.09;
      return Offset(x, y);
    }

    final linePath = Path()..moveTo(pt(0).dx, pt(0).dy);
    for (var i = 1; i < points.length; i++) {
      linePath.lineTo(pt(i).dx, pt(i).dy);
    }

    final fillPath = Path.from(linePath)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          accentColor.withValues(alpha: 0.22),
          accentColor.withValues(alpha: 0.02),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(fillPath, fillPaint);

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
    canvas.drawPath(linePath, shadowPaint);

    final linePaint = Paint()
      ..color = accentColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant SparklinePainter oldDelegate) =>
      oldDelegate.points != points || oldDelegate.accentColor != accentColor;
}
