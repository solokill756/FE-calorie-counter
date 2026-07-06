import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';
import 'package:caloriecounter/src/common/widgets/loading_widget.dart';
import 'package:caloriecounter/src/common/utils/getit_utils.dart';
import 'package:caloriecounter/src/modules/logfood/data/models/food_model.dart';
import 'package:caloriecounter/src/modules/logfood/data/models/meal_detail_model.dart';
import 'package:caloriecounter/src/modules/logfood/domain/repository/food_repository.dart';
import 'package:caloriecounter/src/modules/logfood/presentation/application/cubit/logfood_page_cubit.dart';
import 'package:caloriecounter/src/modules/logfood/presentation/pages/edit_meal_page.dart';
import 'package:caloriecounter/src/modules/logfood/presentation/widgets/ai_estimated_food_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../application/cubit/meal_detail_cubit.dart';
import '../application/cubit/meal_detail_state.dart';

@RoutePage()
class MealDetailPage extends StatefulWidget {
  const MealDetailPage({super.key, required this.mealId});

  final int mealId;

  @override
  State<MealDetailPage> createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  late final MealDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = MealDetailCubit(
      foodRepository: getIt<FoodRepository>(),
      mealId: widget.mealId,
    )..loadMealDetail();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  List<FoodModel> _browseFoods(BuildContext context) {
    try {
      final s = context.read<LogFoodPageCubit>().state;
      if (s is LogFoodPageLoaded) {
        return [
          ...s.myFoods,
          ...s.suggestedFoods.where((f) => !s.myFoods.any((m) => m.id == f.id)),
        ];
      }
    } catch (_) {}
    return const [];
  }

  Future<void> _openEditMeal(BuildContext context, MealDetail meal) async {
    LogFoodPageCubit? cubit;
    try {
      cubit = context.read<LogFoodPageCubit>();
    } catch (_) {}
    final browse = _browseFoods(context);
    final ok = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) {
          final page = EditMealPage(
            mealId: widget.mealId,
            availableFoods: browse,
          );
          if (cubit != null) {
            return BlocProvider.value(value: cubit, child: page);
          }
          return page;
        },
      ),
    );
    if (ok == true && mounted) {
      await _cubit.loadMealDetail();
      try {
        await cubit?.reloadTab('My Meals');
      } catch (_) {}
    }
  }

  double _macroCalories(MealNutritionTotals n) =>
      (n.carbs * 4) + (n.fat * 9) + (n.protein * 4);

  String _quantityLabel(double value) {
    return value == value.roundToDouble()
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return BlocBuilder<MealDetailCubit, MealDetailState>(
      bloc: _cubit,
      builder: (context, state) {
        final MealDetail? meal = state.maybeWhen(
          loaded: (meal) => meal,
          orElse: () => null,
        );
        return Scaffold(
          backgroundColor: scheme.surfaceContainerLowest,
          appBar: AppShellUi.appBar(
            context,
            meal?.name.isNotEmpty == true ? meal!.name : 'Meal',
            actions: [
              IconButton(
                tooltip: 'Edit meal',
                icon: const Icon(Icons.edit_outlined),
                onPressed: meal == null ? null : () => _openEditMeal(context, meal),
              ),
            ],
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(MealDetailState state) {
    final scheme = Theme.of(context).colorScheme;
    return state.when(
      initial: () => const Center(child: LoadingWidget()),
      loading: () => const Center(child: LoadingWidget()),
      error: (error) => Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Could not load meal.',
                style: TextStyle(fontSize: 16.sp, color: scheme.onSurface),
              ),
              SizedBox(height: 16.h),
              FilledButton(
                onPressed: () => _cubit.loadMealDetail(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      loaded: (meal) {
        final n = meal.nutritionSummary;
        final macroDenom = _macroCalories(n);
        final cPct = macroDenom <= 0 ? 0.0 : (n.carbs * 4) / macroDenom;
        final fPct = macroDenom <= 0 ? 0.0 : (n.fat * 9) / macroDenom;
        final pPct = macroDenom <= 0 ? 0.0 : (n.protein * 4) / macroDenom;

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          children: [
            _mealHeaderCard(meal, macroDenom),
            if (meal.directions != null && meal.directions!.trim().isNotEmpty) ...[
              SizedBox(height: 14.h),
              _detailSectionCard(
                title: 'Directions',
                child: _directionsContent(meal.directions!.trim()),
              ),
            ],
            SizedBox(height: 14.h),
            _detailSectionCard(
              title: 'Nutrition',
              child: _mealNutritionSection(n, cPct, fPct, pPct, macroDenom),
            ),
            SizedBox(height: 14.h),
            _detailSectionCard(
              title: 'Foods in this meal',
              trailing: '${meal.items.length} items',
              child: _mealFoodsSection(meal.items),
            ),
            SizedBox(height: 24.h),
          ],
        );
      },
    );
  }

  Widget _mealHeaderCard(MealDetail meal, double macroCalories) {
    final scheme = Theme.of(context).colorScheme;
    final hasImage = meal.imageUrl != null && meal.imageUrl!.trim().isNotEmpty;
    return Container(
      decoration: AppShellUi.cardDecoration(context),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasImage)
            Image.network(
              meal.imageUrl!.trim(),
              height: 180.h,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 180.h,
                alignment: Alignment.center,
                color: scheme.surfaceContainerHighest,
                child: Icon(
                  Icons.broken_image_outlined,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name.trim().isEmpty ? 'Meal' : meal.name.trim(),
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    _metaChip(
                      icon: Icons.restaurant_menu_outlined,
                      label: '${meal.items.length} foods',
                    ),
                    _metaChip(
                      icon: Icons.local_fire_department_outlined,
                      label: meal.nutritionSummary.hasCaloriesLine
                          ? '${meal.nutritionSummary.calories.round()} kcal'
                          : '${macroCalories.round()} macro kcal',
                    ),
                    if (meal.shareWith == 2)
                      _metaChip(icon: Icons.group_outlined, label: 'Shared'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailSectionCard({
    required String title,
    String? trailing,
    required Widget child,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: AppShellUi.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
              ),
              if (trailing != null)
                Text(
                  trailing,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
          SizedBox(height: 10.h),
          child,
        ],
      ),
    );
  }

  Widget _directionsContent(String directions) {
    final scheme = Theme.of(context).colorScheme;
    final text = directions.replaceAll('\r\n', '\n').trim();
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: scheme.secondaryContainer.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.notes_outlined,
              size: 18.sp,
              color: scheme.onSecondaryContainer,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                color: scheme.onSurface,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mealNutritionSection(
    MealNutritionTotals n,
    double cPct,
    double fPct,
    double pPct,
    double macroDenom,
  ) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        _MealTotalsCard(
          calories: n.calories.round(),
          carbsPercent: cPct,
          fatPercent: fPct,
          proteinPercent: pPct,
          carbsG: n.carbs,
          fatG: n.fat,
          proteinG: n.protein,
          showCaloriesPlaceholder: !n.hasCaloriesLine && macroDenom > 0,
        ),
        SizedBox(height: 8.h),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            iconColor: scheme.primary,
            collapsedIconColor: scheme.onSurfaceVariant,
            title: Text(
              'More nutrition',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: scheme.onSurface,
              ),
            ),
            children: [
              SizedBox(height: 4.h),
              _MealNutritionFactsCard(
                calories: n.calories,
                carbs: n.carbs,
                fat: n.fat,
                protein: n.protein,
                fiber: n.fiber,
                sugar: n.sugar,
                saturatedFat: n.saturatedFat,
                cholesterol: n.cholesterol,
                sodium: n.sodium,
                potassium: n.potassium,
                micronutrients: n.micronutrients,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _mealFoodsSection(List<MealLineItem> items) {
    final scheme = Theme.of(context).colorScheme;
    if (items.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text(
          'No foods added yet.',
          style: TextStyle(fontSize: 14.sp, color: scheme.onSurfaceVariant),
        ),
      );
    }
    return Column(children: items.map(_mealLineTile).toList());
  }

  Widget _metaChip({required IconData icon, required String label}) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15.sp, color: scheme.onPrimaryContainer),
          SizedBox(width: 5.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: scheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }

  Widget _mealLineTile(MealLineItem line) {
    final scheme = Theme.of(context).colorScheme;
    final qtyLabel = _quantityLabel(line.quantity);
    final sizeLabel =
        line.food?.servingSize != null &&
            line.food?.servingSize!.isNotEmpty == true
        ? '${line.food?.servingSize} ${line.food?.servingUnit}'
        : '';
    final kcal = line.lineCalories > 0
        ? '${line.lineCalories.round()} kcal'
        : '—';

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Icon(
              Icons.restaurant_outlined,
              size: 16.sp,
              color: scheme.onSurfaceVariant,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        line.displayName,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                    if (line.food?.isAiEstimated == true) ...[
                      SizedBox(width: 6.w),
                      const AiEstimatedFoodChip(compact: true),
                    ],
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  'Qty $qtyLabel ${sizeLabel.isNotEmpty ? '/ $sizeLabel' : ''}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            kcal,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: scheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _MealTotalsCard extends StatelessWidget {
  const _MealTotalsCard({
    required this.calories,
    required this.carbsPercent,
    required this.fatPercent,
    required this.proteinPercent,
    required this.carbsG,
    required this.fatG,
    required this.proteinG,
    required this.showCaloriesPlaceholder,
  });

  final int calories;
  final double carbsPercent;
  final double fatPercent;
  final double proteinPercent;
  final double carbsG;
  final double fatG;
  final double proteinG;
  final bool showCaloriesPlaceholder;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final carbsColor = AppShellUi.macroCarbs(context);
    final fatColor = AppShellUi.macroFat(context);
    final proteinColor = AppShellUi.macroProtein(context);
    final calLabel = showCaloriesPlaceholder ? '—' : '$calories';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _MealCaloriesDonut(
            caloriesLabel: calLabel,
            carbsPercent: carbsPercent,
            fatPercent: fatPercent,
            proteinPercent: proteinPercent,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _MacroLine(
                  percent: (carbsPercent * 100).round(),
                  grams: (carbsG * 10).round() / 10,
                  label: 'Carbs',
                  color: carbsColor,
                ),
                const SizedBox(height: 8),
                _MacroLine(
                  percent: (fatPercent * 100).round(),
                  grams: (fatG * 10).round() / 10,
                  label: 'Fat',
                  color: fatColor,
                ),
                const SizedBox(height: 8),
                _MacroLine(
                  percent: (proteinPercent * 100).round(),
                  grams: (proteinG * 10).round() / 10,
                  label: 'Protein',
                  color: proteinColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MealNutritionFactsCard extends StatelessWidget {
  const _MealNutritionFactsCard({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
    required this.fiber,
    required this.sugar,
    required this.saturatedFat,
    required this.cholesterol,
    required this.sodium,
    required this.potassium,
    required this.micronutrients,
  });

  final double calories;
  final double carbs;
  final double fat;
  final double protein;
  final double fiber;
  final double sugar;
  final double saturatedFat;
  final double cholesterol;
  final double sodium;
  final double potassium;
  final Map<String, double> micronutrients;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: [
          _MealFactRow(
            name: 'Energy',
            value: '${calories.toStringAsFixed(1)} kcal',
          ),
          _MealFactRow(
            name: 'Carbohydrate',
            value: '${carbs.toStringAsFixed(1)} g',
          ),
          _MealFactRow(name: 'Fat', value: '${fat.toStringAsFixed(1)} g'),
          _MealFactRow(
            name: 'Protein',
            value: '${protein.toStringAsFixed(1)} g',
          ),
          _MealFactRow(name: 'Fiber', value: '${fiber.toStringAsFixed(1)} g'),
          _MealFactRow(name: 'Sugar', value: '${sugar.toStringAsFixed(1)} g'),
          _MealFactRow(
            name: 'Saturated Fat',
            value: '${saturatedFat.toStringAsFixed(1)} g',
          ),
          _MealFactRow(
            name: 'Cholesterol',
            value: '${cholesterol.toStringAsFixed(1)} mg',
          ),
          _MealFactRow(
            name: 'Sodium',
            value: '${sodium.toStringAsFixed(1)} mg',
          ),
          _MealFactRow(
            name: 'Potassium',
            value: '${potassium.toStringAsFixed(1)} mg',
          ),
          for (final field in AppNutrients.micronutrients)
            _MealFactRow(
              name: field.label,
              value:
                  '${(micronutrients[field.key] ?? 0).toStringAsFixed(1)} ${field.unit}',
            ),
        ],
      ),
    );
  }
}

class _MealFactRow extends StatelessWidget {
  const _MealFactRow({required this.name, required this.value});

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 13.sp,
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              color: scheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _MealCaloriesDonut extends StatelessWidget {
  const _MealCaloriesDonut({
    required this.caloriesLabel,
    required this.carbsPercent,
    required this.fatPercent,
    required this.proteinPercent,
  });

  final String caloriesLabel;
  final double carbsPercent;
  final double fatPercent;
  final double proteinPercent;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final carbsColor = AppShellUi.macroCarbs(context);
    final fatColor = AppShellUi.macroFat(context);
    final proteinColor = AppShellUi.macroProtein(context);
    const size = 110.0;
    const stroke = 10.0;
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _MealMacroDonutPainter(
          carbsPercent: carbsPercent,
          fatPercent: fatPercent,
          proteinPercent: proteinPercent,
          trackColor: scheme.outlineVariant,
          carbsColor: carbsColor,
          fatColor: fatColor,
          proteinColor: proteinColor,
          strokeWidth: stroke,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                caloriesLabel,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: scheme.onSurface,
                ),
              ),
              Text(
                'kcal',
                style: TextStyle(fontSize: 11, color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MealMacroDonutPainter extends CustomPainter {
  _MealMacroDonutPainter({
    required this.carbsPercent,
    required this.fatPercent,
    required this.proteinPercent,
    required this.trackColor,
    required this.carbsColor,
    required this.fatColor,
    required this.proteinColor,
    required this.strokeWidth,
  });

  final double carbsPercent;
  final double fatPercent;
  final double proteinPercent;
  final Color trackColor;
  final Color carbsColor;
  final Color fatColor;
  final Color proteinColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = -90 * 3.1415926535 / 180;
    double currentAngle = startAngle;

    if (carbsPercent > 0) {
      final paint = Paint()
        ..color = carbsColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      final sweepAngle = 2 * 3.1415926535 * carbsPercent;
      canvas.drawArc(rect, currentAngle, sweepAngle, false, paint);
      currentAngle += sweepAngle;
    }

    if (fatPercent > 0) {
      final paint = Paint()
        ..color = fatColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      final sweepAngle = 2 * 3.1415926535 * fatPercent;
      canvas.drawArc(rect, currentAngle, sweepAngle, false, paint);
      currentAngle += sweepAngle;
    }

    if (proteinPercent > 0) {
      final paint = Paint()
        ..color = proteinColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      final sweepAngle = 2 * 3.1415926535 * proteinPercent;
      canvas.drawArc(rect, currentAngle, sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _MealMacroDonutPainter oldDelegate) {
    return oldDelegate.carbsPercent != carbsPercent ||
        oldDelegate.fatPercent != fatPercent ||
        oldDelegate.proteinPercent != proteinPercent ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class _MacroLine extends StatelessWidget {
  const _MacroLine({
    required this.percent,
    required this.grams,
    required this.label,
    required this.color,
  });

  final int percent;
  final double grams;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: scheme.onSurface,
            ),
          ),
        ),
        Text(
          '${grams}g',
          style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 36,
          child: Text(
            '$percent%',
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}
