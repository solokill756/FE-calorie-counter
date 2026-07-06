import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/widgets/loading_widget.dart';
import '../../data/models/food_model.dart';
import '../application/cubit/logfood_page_cubit.dart';

@RoutePage()
class CreateFoodNutritionPage extends StatefulWidget {
  final FoodModel food;
  final bool isEditing;
  const CreateFoodNutritionPage({
    super.key,
    required this.food,
    this.isEditing = false,
  });

  @override
  State<CreateFoodNutritionPage> createState() =>
      _CreateFoodNutritionPageState();
}

class _CreateFoodNutritionPageState extends State<CreateFoodNutritionPage> {
  // Define the nutrition fields shown in the screenshot
  final List<_NutritionSpec> _specs = const [
    _NutritionSpec(
      label: 'Calories',
      requiredField: true,
      key: NutrientKeys.caloriesKcal,
    ),
    _NutritionSpec(label: 'Total Fat (g)', key: NutrientKeys.fatTotalG),
    _NutritionSpec(label: 'Saturated Fat (g)', key: NutrientKeys.fatSaturatedG),
    _NutritionSpec(label: 'Cholesterol (mg)', key: NutrientKeys.cholesterolMg),
    _NutritionSpec(label: 'Sodium (mg)', key: NutrientKeys.sodiumMg),
    _NutritionSpec(
      label: 'Total Carbohydrates (g)',
      key: NutrientKeys.carbsTotalG,
    ),
    _NutritionSpec(label: 'Dietary Fiber (g)', key: NutrientKeys.fiberG),
    _NutritionSpec(label: 'Sugars (g)', key: NutrientKeys.sugarsG),
    _NutritionSpec(label: 'Protein (g)', key: NutrientKeys.proteinG),
    _NutritionSpec(label: 'Potassium (mg)', key: NutrientKeys.potassiumMg),
  ];

  final List<_NutritionSpec> _mineralSpecs = [
    for (final field in AppNutrients.minerals)
      _NutritionSpec(label: '${field.label} (${field.unit})', key: field.key),
  ];

  final List<_NutritionSpec> _vitaminSpecs = [
    for (final field in AppNutrients.vitamins)
      _NutritionSpec(label: '${field.label} (${field.unit})', key: field.key),
  ];

  late final List<_NutritionSpec> _allSpecs = [
    ..._specs,
    ..._mineralSpecs,
    ..._vitaminSpecs,
  ];

  late final Map<String, TextEditingController> _controllers = {
    for (final s in _allSpecs) s.label: TextEditingController(),
  };

  @override
  void initState() {
    super.initState();

    for (final spec in _allSpecs) {
      _controllers[spec.label]?.text =
          widget.food.nutrients[spec.key]?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  double? _numberFor(String label) {
    final raw = _controllers[label]?.text.trim();
    if (raw == null || raw.isEmpty) return null;
    return double.tryParse(raw);
  }

  bool _hasValue(String label) {
    return _controllers[label]?.text.trim().isNotEmpty ?? false;
  }

  String? _validateMacroCalories() {
    final calories = _numberFor('Calories');
    if (calories == null) {
      return 'Calories must be a valid number.';
    }
    if (calories <= 0) {
      return 'Calories must be greater than zero.';
    }

    for (final spec in _allSpecs) {
      final value = _numberFor(spec.label);
      if (_hasValue(spec.label)) {
        if (value == null) {
          return '${spec.label} must be a valid number.';
        }
        if (value < 0) {
          return '${spec.label} must be zero or greater.';
        }
      }
    }

    final carbs = _numberFor('Total Carbohydrates (g)') ?? 0;
    final fat = _numberFor('Total Fat (g)') ?? 0;
    final protein = _numberFor('Protein (g)') ?? 0;

    final hasAllMacros =
        _hasValue('Total Carbohydrates (g)') &&
        _hasValue('Total Fat (g)') &&
        _hasValue('Protein (g)');
    final macroCalories = carbs * 4 + fat * 9 + protein * 4;
    final tolerance = calories * 0.05 + 5;

    if (macroCalories > calories + tolerance) {
      return 'Macros add up to ${macroCalories.round()} kcal, which is higher than Calories (${calories.round()} kcal).';
    }

    if (hasAllMacros && (macroCalories - calories).abs() > tolerance) {
      return 'Macros add up to ${macroCalories.round()} kcal. Please adjust them to match Calories (${calories.round()} kcal).';
    }

    return null;
  }

  void _onSubmit() {
    FocusScope.of(context).unfocus();
    final values = {for (final e in _controllers.entries) e.key: e.value.text};
    if (values['Calories'] == null || values['Calories']!.isEmpty) {
      AppDialogs.showErrorSnackBar(
        message: 'Please enter the required fields.',
      );
      return;
    }

    final macroCaloriesError = _validateMacroCalories();
    if (macroCaloriesError != null) {
      AppDialogs.showErrorSnackBar(message: macroCaloriesError);
      return;
    }

    final FoodModel updatedFood = widget.food.copyWith(
      nutrients: {
        for (final spec in _allSpecs)
          if (values[spec.label] != null && values[spec.label]!.isNotEmpty)
            spec.key: double.tryParse(values[spec.label]!) ?? 0.0,
      },
    );
    if (widget.isEditing) {
      context.read<LogFoodPageCubit>().updateFood(updatedFood);
    } else {
      context.read<LogFoodPageCubit>().createFood(updatedFood);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.isEditing ? 'Edit Food' : 'Create Food',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: [
          BlocBuilder<LogFoodPageCubit, LogFoodPageState>(
            builder: (context, state) {
              return state.maybeWhen(
                createFoodLoading: () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: LoadingWidget.small(color: Colors.blue[600]),
                    ),
                  ),
                ),
                orElse: () => IconButton(
                  icon: const Icon(Icons.check, color: Colors.blue),
                  onPressed: _onSubmit,
                ),
              );
            },
          ),
        ],
      ),
      body: BlocListener<LogFoodPageCubit, LogFoodPageState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            createFoodSuccess: (message) {
              AppDialogs.showSuccessSnackBar(message: message);

              // Pop back to LogFoodPage
              // Reload and tab selection will be handled by BlocListener in logfood_page.dart
              if (context.mounted) {
                Navigator.of(context).pop();
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
            createFoodError: (message) {
              AppDialogs.showErrorSnackBar(message: message);
            },
          );
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.translucent,
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                color: Colors.grey[200],
                child: Text(
                  'Nutrition Facts',
                  style: const TextStyle(
                    color: Color(0xFF424242), // grey[700]
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    for (int i = 0; i < _specs.length; i++) ...[
                      _NutritionRow(
                        spec: _specs[i],
                        controller: _controllers[_specs[i].label]!,
                      ),
                      if (i != _specs.length - 1)
                        Container(
                          height: 1,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          color: Colors.grey[200],
                        ),
                    ],
                  ],
                ),
              ),
              _NutritionExpansionSection(
                title: 'Minerals',
                specs: _mineralSpecs,
                controllers: _controllers,
              ),
              _NutritionExpansionSection(
                title: 'Vitamins',
                specs: _vitaminSpecs,
                controllers: _controllers,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _NutritionRow extends StatelessWidget {
  const _NutritionRow({required this.spec, required this.controller});
  final _NutritionSpec spec;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              spec.label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 2,
            child: TextField(
              controller: controller,
              textAlign: TextAlign.right,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]')),
              ],
              style: const TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                hintText: spec.requiredField ? 'Required' : 'Optional',
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFBDBDBD), // grey[400]
                ),
                isDense: true,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NutritionExpansionSection extends StatelessWidget {
  const _NutritionExpansionSection({
    required this.title,
    required this.specs,
    required this.controllers,
  });

  final String title;
  final List<_NutritionSpec> specs;
  final Map<String, TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        children: [
          for (int i = 0; i < specs.length; i++) ...[
            _NutritionRow(
              spec: specs[i],
              controller: controllers[specs[i].label]!,
            ),
            if (i != specs.length - 1)
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                color: Colors.grey[200],
              ),
          ],
        ],
      ),
    );
  }
}

class _NutritionSpec {
  final String label;
  final bool requiredField;
  final String key;
  const _NutritionSpec({
    required this.label,
    this.requiredField = false,
    required this.key,
  });
}
