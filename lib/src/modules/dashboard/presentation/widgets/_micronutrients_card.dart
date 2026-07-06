import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:caloriecounter/src/modules/dashboard/presentation/widgets/dash_card_helpers.dart';

class MicronutrientsCard extends StatelessWidget {
  const MicronutrientsCard({super.key, required this.micronutrients});

  final Map<String, num> micronutrients;

  @override
  Widget build(BuildContext context) {
    final pairs = _displayPairs();
    if (pairs.isEmpty) return const SizedBox.shrink();

    return DashCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dashCardTitleRow(
            context,
            icon: Icons.flutter_dash_rounded,
            title: 'Micronutrients',
          ),
          Gap(14.h),
          ...pairs.map((p) => Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: _microRow(context, p.label, micronutrients[p.key] ?? 0, p.unit),
          )),
        ],
      ),
    );
  }

  List<_MicroPair> _displayPairs() {
    const entries = <_MicroPair>[
      _MicroPair('Calcium', 'calcium', 'mg'),
      _MicroPair('Iron', 'iron', 'mg'),
      _MicroPair('Magnesium', 'magnesium', 'mg'),
      _MicroPair('Phosphorus', 'phosphorus', 'mg'),
      _MicroPair('Zinc', 'zinc', 'mg'),
      _MicroPair('Vitamin A', 'vitaminA', 'µg'),
      _MicroPair('Vitamin C', 'vitaminC', 'mg'),
      _MicroPair('Vitamin D', 'vitaminD', 'µg'),
      _MicroPair('Vitamin E', 'vitaminE', 'mg'),
      _MicroPair('Vitamin K', 'vitaminK', 'µg'),
      _MicroPair('Vitamin B6', 'vitaminB6', 'mg'),
      _MicroPair('Vitamin B12', 'vitaminB12', 'µg'),
      _MicroPair('Folate', 'folate', 'µg'),
    ];
    return entries.where((e) => micronutrients.containsKey(e.key)).toList();
  }

  Widget _microRow(BuildContext context, String label, num value, String unit) {
    final scheme = Theme.of(context).colorScheme;
    final v = value is double ? value : value.toDouble();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
        ),
        Text(
          '${v.toStringAsFixed(v.truncateToDouble() == v ? 0 : 1)} $unit',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _MicroPair {
  const _MicroPair(this.label, this.key, this.unit);
  final String label;
  final String key;
  final String unit;
}
