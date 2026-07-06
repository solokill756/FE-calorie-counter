import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/app_router.dart';
import '../../data/models/food_model.dart';

@RoutePage()
class CreateFoodPage extends StatefulWidget {
  const CreateFoodPage({super.key, this.initialFood, this.isEditing = false});

  final FoodModel? initialFood;
  final bool isEditing;

  @override
  State<CreateFoodPage> createState() => _CreateFoodPageState();
}

class _CreateFoodPageState extends State<CreateFoodPage> {
  final _foodNameController = TextEditingController();
  final _brandController = TextEditingController();
  final _categoryController = TextEditingController();
  final _servingSizeController = TextEditingController();
  final _servingsPerContainerController = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    final food = widget.initialFood;
    if (food == null) return;
    _foodNameController.text = food.name;
    _brandController.text = food.brand ?? '';
    _categoryController.text = food.description ?? '';
    final unitIndex =
        food.unitShowIndex >= 0 && food.unitShowIndex < food.units.length
        ? food.unitShowIndex
        : 0;
    if (food.units.isNotEmpty) {
      _servingSizeController.text = food.units[unitIndex];
    } else if (food.unitSizes.isNotEmpty) {
      _servingSizeController.text = '${food.unitSizes.first} serving';
    }
    _servingsPerContainerController.text = _formatNumber(
      food.servingPerContainer,
    );
  }

  String _formatNumber(double value) {
    if ((value - value.round()).abs() < 1e-9) return value.round().toString();
    return value.toString();
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _brandController.dispose();
    _categoryController.dispose();
    _servingSizeController.dispose();
    _servingsPerContainerController.dispose();
    super.dispose();
  }

  void _onNext() {
    final foodName = _foodNameController.text.trim();
    final brand = _brandController.text.trim();
    final category = _categoryController.text.trim();
    final servingSize = _servingSizeController.text.trim();
    final servingsPerContainer = _servingsPerContainerController.text.trim();

    if (foodName.isEmpty ||
        servingSize.isEmpty ||
        servingsPerContainer.isEmpty) {
      AppDialogs.showErrorSnackBar(
        message: 'Please fill in all required fields.',
      );
      return;
    }
    final servingParts = servingSize.split(RegExp(r'\s+'));
    if (servingParts.length < 2) {
      AppDialogs.showErrorSnackBar(
        message:
            'Serving size must include a number and a unit (e.g., "1 cup").',
      );
      return;
    }
    final parsedServingAmount = double.tryParse(
      servingParts.first.replaceAll(',', '.'),
    );
    if (parsedServingAmount == null || parsedServingAmount <= 0) {
      AppDialogs.showErrorSnackBar(
        message: 'Serving size number must be a positive value.',
      );
      return;
    }

    if (double.tryParse(servingsPerContainer) == null ||
        double.parse(servingsPerContainer) <= 0) {
      AppDialogs.showErrorSnackBar(
        message: 'Servings per container must be a positive number.',
      );
      return;
    }

    final sourceFood = widget.initialFood;
    final newFood = FoodModel(
      id: sourceFood?.id,
      name: foodName,
      brand: brand.isEmpty ? null : brand,
      description: category.isEmpty ? null : category,
      units: [
        servingSize,
        '${(parsedServingAmount * 3)} ${servingParts.last}',
        '1 container',
      ],
      unitSizes: [
        parsedServingAmount,
        parsedServingAmount * 3,
        double.parse(servingsPerContainer) * parsedServingAmount,
      ],
      unitShowIndex: 0,
      nutrients: sourceFood?.nutrients ?? {}, // Empty nutrients for create.
      createdBy: sourceFood?.createdBy, // Will be set by backend on create.
      isVerified: sourceFood?.isVerified ?? false,
      servingPerContainer: double.parse(servingsPerContainer),
      quantity: 1,
      createdAt: sourceFood?.createdAt ?? DateTime.now(),
    );

    context.router.push(
      CreateFoodNutritionRoute(food: newFood, isEditing: widget.isEditing),
    );
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
          onPressed: () => context.router.maybePop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, color: Colors.blue),
            onPressed: _onNext,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.translucent,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              const SizedBox(height: 8),
              // Form fields
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    _FieldRow(
                      title: 'Food Name',
                      subtitle: 'Required',
                      placeholder: 'ex. Chicken Soup',
                      controller: _foodNameController,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      color: Colors.grey[200],
                    ),
                    _FieldRow(
                      title: 'Brand Name',
                      subtitle: 'Optional',
                      placeholder: "ex. Campbell's",
                      controller: _brandController,
                      textCapitalization: TextCapitalization.words,
                    ),
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      color: Colors.grey[200],
                    ),
                    _FieldRow(
                      title: 'Category',
                      subtitle: 'Optional',
                      placeholder: 'ex. Soup',
                      controller: _categoryController,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      color: Colors.grey[200],
                    ),
                    _FieldRow(
                      title: 'Serving Size',
                      subtitle: 'Required',
                      placeholder: 'ex. 1 cup',
                      controller: _servingSizeController,
                    ),
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      color: Colors.grey[200],
                    ),
                    _NumberFieldRow(
                      title: 'Servings per container',
                      subtitle: 'Required',
                      controller: _servingsPerContainerController,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldRow extends StatelessWidget {
  const _FieldRow({
    required this.title,
    required this.subtitle,
    required this.placeholder,
    required this.controller,
    this.textCapitalization = TextCapitalization.none,
  });

  final String title;
  final String subtitle;
  final String placeholder;
  final TextEditingController controller;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Label
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          // Input
          Expanded(
            flex: 4,
            child: TextField(
              controller: controller,
              textAlign: TextAlign.right,
              textCapitalization: textCapitalization,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey[400]),
                isDense: true,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 6),
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
        ],
      ),
    );
  }
}

class _NumberFieldRow extends StatelessWidget {
  const _NumberFieldRow({
    required this.title,
    required this.subtitle,
    required this.controller,
  });

  final String title;
  final String subtitle;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Label
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          // Input (number-only)
          Expanded(
            flex: 4,
            child: TextField(
              controller: controller,
              textAlign: TextAlign.right,
              keyboardType: const TextInputType.numberWithOptions(
                signed: false,
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              style: const TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey[400]),
                isDense: true,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 6),
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }
}
