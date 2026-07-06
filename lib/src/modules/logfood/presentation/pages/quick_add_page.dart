import 'package:caloriecounter/src/common/dialogs/app_dialogs.dart';
import 'package:caloriecounter/src/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/application/cubit/user_profile_access.dart';
import '../../../../enums/meal_options.dart';
import '../../helper/nutrition_log_warning.dart';
import '../application/cubit/logfood_cubit.dart';

@RoutePage()
class QuickAddPage extends StatefulWidget {
  const QuickAddPage({super.key, this.diaryDay});

  /// Calendar day used for diary totals in the nutrition warning (e.g. Log Food / Diary selection).
  final DateTime? diaryDay;

  @override
  State<QuickAddPage> createState() => _QuickAddPageState();
}

class _QuickAddPageState extends State<QuickAddPage> {
  // Form controllers
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();

  // Selected meal
  MealOptions selectedMeal = MealOptions.breakfast;

  @override
  void dispose() {
    _caloriesController.dispose();
    _fatController.dispose();
    _carbsController.dispose();
    _proteinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.router.maybePop(),
        ),
        title: const Text(
          'Quick Add',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _isFormValid() ? _saveQuickAdd : null,
            child: Icon(
              Icons.check,
              color: _isFormValid() ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
      body: BlocListener<LogFoodCubit, LogFoodState>(
        listener: (context, state) async {
          await state.maybeWhen<Future<void>>(
            quickAddSuccess: (message, ratingPromptLogCount) async {
              // Show success message and go back
              context.hideLoadingDialog();
              AppDialogs.showSnackBar(
                message: message,
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              );
              if (!context.mounted) return;
              context.router.maybePop();
            },
            quickAddError: (message) async {
              // Show error message
              context.hideLoadingDialog();
              AppDialogs.showSnackBar(
                message: message,
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              );
            },
            quickAddLoading: () async {
              // Show loading indicator
              context.showLoadingDialog(
                message: 'Quick adding food...',
                type: LoadingType.circular,
              );
            },
            orElse: () async {},
          );
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.translucent,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              children: [
                // Meal selection
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Meal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: _showMealPicker,
                        child: Text(
                          selectedMeal.displayName,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Calories input (required)
                _buildInputField(
                  label: 'Calories',
                  controller: _caloriesController,
                  hint: 'Enter calorie amount',
                  isRequired: true,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 1),

                // Fat input (optional)
                _buildInputField(
                  label: 'Total Fat (g)',
                  controller: _fatController,
                  hint: 'Optional',
                  isRequired: false,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 1),

                // Carbs input (optional)
                _buildInputField(
                  label: 'Total Carbohydrates (g)',
                  controller: _carbsController,
                  hint: 'Optional',
                  isRequired: false,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 1),

                // Protein input (optional)
                _buildInputField(
                  label: 'Protein (g)',
                  controller: _proteinController,
                  hint: 'Optional',
                  isRequired: false,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required bool isRequired,
    TextInputType? keyboardType,
  }) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          // Label
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),

          // Input field
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                color: isRequired ? Colors.black : Colors.grey[600],
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(fontSize: 16, color: Colors.grey[400]),
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (value) {
                setState(() {}); // Rebuild to update save button state
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showMealPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const SizedBox(height: 20),

              // Title
              const Text(
                'Select Meal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 20),

              // Meal options
              ...MealOptions.values.map((meal) => _buildMealOption(meal)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMealOption(MealOptions meal) {
    final isSelected = selectedMeal == meal;
    return InkWell(
      onTap: () {
        setState(() {
          selectedMeal = meal;
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Icon(
              meal.icon,
              color: isSelected ? Colors.blue : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                meal.displayName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.blue : Colors.black,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check, color: Colors.blue, size: 20),
          ],
        ),
      ),
    );
  }

  bool _isFormValid() {
    return _caloriesController.text.trim().isNotEmpty;
  }

  void _saveQuickAdd() async {
    FocusScope.of(context).unfocus();
    if (!_isFormValid()) return;

    final calories = double.tryParse(_caloriesController.text) ?? 0;
    final fat = _fatController.text.isEmpty
        ? null
        : double.tryParse(_fatController.text);
    final carbs = _carbsController.text.isEmpty
        ? null
        : double.tryParse(_carbsController.text);
    final protein = _proteinController.text.isEmpty
        ? null
        : double.tryParse(_proteinController.text);

    // Nutrition warning before logging manual quick add.
    final logDay = widget.diaryDay ?? DateTime.now();
    final ok = await NutritionLogWarning.confirmQuickAddManual(
      context,
      calories: calories,
      fat: fat,
      carbs: carbs,
      protein: protein,
      logCalendarDay: logDay,
      profile: readServerProfile(),
    );
    if (!mounted || !ok) return;

    final now = DateTime.now();
    final logTime = DateTime(
      logDay.year,
      logDay.month,
      logDay.day,
      now.hour,
      now.minute,
      now.second,
    );

    context.read<LogFoodCubit>().quickAddLogFood(
      calories: calories,
      fat: fat,
      carbs: carbs,
      protein: protein,
      slot: selectedMeal.value,
      time: logTime,
    );
  }
}

// Extension for MealOptions icons
extension MealOptionsIcon on MealOptions {
  IconData get icon {
    switch (this) {
      case MealOptions.breakfast:
        return Icons.wb_sunny_outlined;
      case MealOptions.lunch:
        return Icons.wb_sunny;
      case MealOptions.dinner:
        return Icons.nights_stay_outlined;
      case MealOptions.snacks:
        return Icons.local_cafe_outlined;
    }
  }
}
