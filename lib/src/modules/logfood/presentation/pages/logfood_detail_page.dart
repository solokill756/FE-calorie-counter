// lib/add_food_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:caloriecounter/src/common/theme/app_shell_ui.dart';
import 'package:caloriecounter/src/common/widgets/loading_widget.dart';
import 'package:caloriecounter/src/modules/logfood/data/models/food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../auth/presentation/application/cubit/user_profile_access.dart';
import '../../../diary/domain/repository/diary_repository.dart';
import '../../../../enums/meal_options.dart';
import '../../domain/entities/macros_entity.dart';
import '../../helper/log_food_helper.dart';
import '../../helper/nutrition_log_warning.dart';
import '../application/cubit/logfood_cubit.dart';
import '../widgets/ai_estimated_food_chip.dart';

@RoutePage()
class LogFoodDetailPage extends StatelessWidget {
  final int foodId; // Required parameter
  final FoodModel food; // Required parameter
  final List<FoodModel> historyFoods; // Required parameter
  final DateTime? forLogDate;

  const LogFoodDetailPage({
    super.key,
    required this.foodId,
    required this.food,
    required this.historyFoods,
    this.forLogDate,
  });

  @override
  Widget build(BuildContext context) {
    return LogFoodDetailView(
      foodId: foodId,
      food: food,
      historyFoods: historyFoods,
      forLogDate: forLogDate,
    );
  }
}

class LogFoodDetailView extends StatefulWidget {
  final int foodId;
  final FoodModel food;

  final List<FoodModel> historyFoods;
  final DateTime? forLogDate;

  const LogFoodDetailView({
    super.key,
    required this.foodId,
    required this.food,
    required this.historyFoods,
    this.forLogDate,
  });

  @override
  State<LogFoodDetailView> createState() => _LogFoodDetailViewState();
}

class _LogFoodDetailViewState extends State<LogFoodDetailView> {
  // Demo state
  late String servingSize;
  late double servings;
  MealOptions selectedMeal = MealOptions.breakfast;
  Set<int> selectedDayIndices = {}; // Multiple days selection
  bool showNutritionFacts = false;

  // Controller for servings input
  late TextEditingController _servingsController;
  late int _unitSelectedIndex;

  // Helper instance
  final LogFoodHelper _logFoodHelper = LogFoodHelper();

  /// Totals already logged for [forLogDate] (or today) from diary API.
  int _diaryCaloriesConsumed = 0;
  double _diaryCarbsConsumed = 0;
  double _diaryProteinConsumed = 0;
  double _diaryFatConsumed = 0;

  DateTime _logTimestamp() {
    final base = widget.forLogDate ?? DateTime.now();
    final now = DateTime.now();
    return DateTime(
      base.year,
      base.month,
      base.day,
      now.hour,
      now.minute,
      now.second,
    );
  }

  @override
  void initState() {
    super.initState();

    servings = widget.food.quantity;
    _unitSelectedIndex = widget.food.units.isEmpty
        ? 0
        : widget.food.unitShowIndex.clamp(0, widget.food.units.length - 1);
    servingSize = widget.food.units.isEmpty
        ? '1 serving'
        : widget.food.units[_unitSelectedIndex];
    _servingsController = TextEditingController(text: servings.toString());

    _loadDiaryTotalsForLogDate();
  }

  Future<void> _loadDiaryTotalsForLogDate() async {
    final date = widget.forLogDate ?? DateTime.now();
    try {
      final diary = await getIt<DiaryRepository>().getDiaryForDate(date);
      if (!mounted) return;
      setState(() {
        _diaryCaloriesConsumed = diary.caloriesConsumed;
        _diaryCarbsConsumed = diary.carbsConsumed;
        _diaryProteinConsumed = diary.proteinConsumed;
        _diaryFatConsumed = diary.fatConsumed;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _diaryCaloriesConsumed = 0;
        _diaryCarbsConsumed = 0;
        _diaryProteinConsumed = 0;
        _diaryFatConsumed = 0;
      });
    }
  }

  @override
  void dispose() {
    _servingsController.dispose();
    super.dispose();
  }

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  /// Days whose diary totals are compared to goals (matches actual log targets).
  List<DateTime> _nutritionCheckDates(LogType logType) {
    final primary = _dateOnly(widget.forLogDate ?? DateTime.now());
    if (logType == LogType.singleFood) {
      return [primary];
    }
    return _logFoodHelper
        .createDatesFromIndices(
          selectedDayIndices,
          baseDate: widget.forLogDate ?? DateTime.now(),
        )
        .map(_dateOnly)
        .toSet()
        .toList();
  }

  Future<List<String>> _nutritionWarningSections() async {
    final logType = _determineLogType();
    final dates = _nutritionCheckDates(logType);
    return NutritionLogWarning.loadWarningSections(
      calendarDays: dates,
      combined: macros,
      profile: readServerProfile(),
    );
  }

  Future<bool> _confirmIfNutritionOkToProceed() async {
    final sections = await _nutritionWarningSections();
    if (sections.isEmpty) return true;
    if (!mounted) return false;
    return NutritionLogWarning.confirmIfProceed(context, sections);
  }

  // Smart log function - automatically determines log type based on selections
  Future<void> smartLogFood() async {
    FocusScope.of(context).unfocus();
    if (!mounted) return;
    final ok = await _confirmIfNutritionOkToProceed();
    if (!ok || !mounted) return;

    final logType = _determineLogType();

    switch (logType) {
      case LogType.singleFood:
        context.read<LogFoodCubit>().addLogFood(
          food: widget.food,
          slot: selectedMeal.value,
          qty: servings,
          unitSelectedIndex: _unitSelectedIndex,
          time: _logTimestamp(),
          logFoodPage: 1,
        );
        break;
      case LogType.multipleDays:
      case LogType.multipleFoods:
      case LogType.multipleFoodsMultipleDays:
        await context.read<LogFoodCubit>().logFoodToSelectedDays(
          food: widget.food,
          slot: selectedMeal.value,
          qty: servings,
          unitSelectedIndex: _unitSelectedIndex,
          dates: _logFoodHelper.createDatesFromIndices(
            selectedDayIndices,
            baseDate: widget.forLogDate ?? DateTime.now(),
          ),
        );
        break;
    }
  }

  // Determine log type based on user selections
  LogType _determineLogType() {
    final hasMultipleDays = selectedDayIndices.isNotEmpty;
    return _logFoodHelper.determineLogType(
      hasMultipleDays: hasMultipleDays,
      hasMultipleFoods: false,
    );
  }

  // Get smart log description for UI
  String _getSmartLogDescription() {
    final logType = _determineLogType();
    final selectedDaysCount = selectedDayIndices.length;

    if (logType == LogType.singleFood) {
      final target = _dateOnly(widget.forLogDate ?? DateTime.now());
      final today = _dateOnly(DateTime.now());
      return target == today
          ? 'Log 1 food to today'
          : 'Log 1 food to selected day';
    }

    return _logFoodHelper.getSmartLogDescription(
      logType: logType,
      selectedDaysCount: selectedDaysCount,
      selectedFoodsCount: 1,
    );
  }

  // Get icon for current log type
  IconData _getLogTypeIcon() {
    final logType = _determineLogType();
    final iconName = _logFoodHelper.getLogTypeIconName(logType);
    switch (iconName) {
      case 'restaurant_outlined':
        return Icons.restaurant_outlined;
      case 'calendar_today_outlined':
        return Icons.calendar_today_outlined;
      case 'restaurant_menu_outlined':
        return Icons.restaurant_menu_outlined;
      case 'grid_view_outlined':
        return Icons.grid_view_outlined;
      default:
        return Icons.restaurant_outlined;
    }
  }

  // Get label for current log type
  String _getLogTypeLabel() {
    final logType = _determineLogType();
    return _logFoodHelper.getLogTypeLabel(logType);
  } // Multiple food logging methods

  /// Scaled macros for the main food (same rules as [LogFoodHelper.macrosForQuantity]).
  MacrosEntity get macros {
    return LogFoodHelper.macrosForQuantity(
      widget.food,
      servings,
      _unitSelectedIndex,
      mainFoodServingSizeLabel: servingSize,
    );
  }

  /// Bar uses 0..1 (capped); trailing shows true % of daily goal (may exceed 100%).
  (double, String) _dailyGoalBar(double consumed, double goal) {
    if (goal <= 0) {
      return (0.0, '- %');
    }
    final raw = consumed / goal;
    final bar = raw.clamp(0.0, 1.0);
    final pct = (raw * 100).round();
    return (bar, '$pct%');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            context.router.back();
          },
        ),
        title: const Text(
          'Add Food',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: [
          BlocBuilder<LogFoodCubit, LogFoodState>(
            builder: (context, state) {
              return state.maybeWhen(
                logFoodDetailLoading: () => Padding(
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
                  icon: Icon(Icons.check_rounded, color: Colors.blue[600]),
                  onPressed: smartLogFood,
                ),
              );
            },
          ),
        ],
      ),
      body: BlocListener<LogFoodCubit, LogFoodState>(
        listener: (context, state) async {
          await state.maybeWhen<Future<void>>(
            logFoodDetailSuccess: (message, ratingPromptLogCount) async {
              if (context.mounted) {
                AppDialogs.showSnackBar(
                  message: message,
                  backgroundColor: Colors.green,
                  duration: const Duration(seconds: 2),
                );
                if (!context.mounted) return;
                context.router.maybePop();
              }
            },
            logFoodDetailError: (message) async {
              AppDialogs.showSnackBar(
                message: message,
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              );
            },
            orElse: () async {},
          );
        },
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              const SizedBox(height: 8),

              // Smart log indicator
              _Card(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        _getLogTypeIcon(),
                        color: Colors.blue[600],
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Smart Log Mode',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _getSmartLogDescription(),
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blue[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _getLogTypeLabel(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              _FoodHeader(
                title: widget.food.name,
                subtitle: widget.food.isAiEstimated
                    ? 'Estimated meal from AI meal planner'
                    : (widget.food.brand ?? ''),
                showAiChip: widget.food.isAiEstimated,
              ),
              const SizedBox(height: 24),
              _SettingRow(
                label: 'Serving Size',
                trailing: _Pill(text: servingSize, onTap: _pickServingSize),
              ),
              const SizedBox(height: 12),
              _SettingRow(
                label: 'Number of Servings',
                trailing: SizedBox(
                  width: 100,
                  height: 40,
                  child: TextField(
                    controller: _servingsController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.blue[200]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.blue[200]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: Colors.blue[400]!,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.blue[50],
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[600],
                    ),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      if (value.isEmpty) return;
                      final doubleVal = double.tryParse(value);
                      if (doubleVal != null && doubleVal > 0) {
                        setState(() {
                          servings = doubleVal;
                        });
                      }
                    },
                    onSubmitted: (value) {
                      if (value.isEmpty) {
                        _servingsController.text = servings.toString();
                        return;
                      }
                      final doubleVal = double.tryParse(value);
                      if (doubleVal == null || doubleVal <= 0) {
                        _servingsController.text = servings.toString();
                      } else {
                        setState(() {
                          servings = doubleVal;
                        });
                        _servingsController.text = servings.toString();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _SettingRow(
                label: 'Meal',
                trailing: _Pill(
                  text: selectedMeal.displayName,
                  onTap: _pickMeal,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Add to Multiple Days',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  if (selectedDayIndices.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${selectedDayIndices.length} day${selectedDayIndices.length > 1 ? 's' : ''} selected',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue[700],
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              _WeekSelector(
                baseDate: widget.forLogDate ?? DateTime.now(),
                selectedIndices: selectedDayIndices,
                onSelected: (i) {
                  setState(() {
                    if (selectedDayIndices.contains(i)) {
                      selectedDayIndices.remove(i);
                    } else {
                      selectedDayIndices.add(i);
                    }
                  });
                },
              ),
              const SizedBox(height: 24),
              _Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _CaloriesDonut(
                      calories: macros.calories.ceil(),
                      carbsPercent: macros.carbsPercentage,
                      fatPercent: macros.fatPercentage,
                      proteinPercent: macros.proteinPercentage,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _MacroStat(
                            percent: (macros.carbsPercentage * 100).round(),
                            grams: (macros.carbs * 10).round() / 10,
                            label: 'Carbs',
                            color: AppShellUi.macroCarbs(context),
                          ),
                          const SizedBox(height: 8),
                          _MacroStat(
                            percent: (macros.fatPercentage * 100).round(),
                            grams: (macros.fat * 10).round() / 10,
                            label: 'Fat',
                            color: AppShellUi.macroFat(context),
                          ),
                          const SizedBox(height: 8),
                          _MacroStat(
                            percent: (macros.proteinPercentage * 100).round(),
                            grams: (macros.protein * 10).round() / 10,
                            label: 'Protein',
                            color: AppShellUi.macroProtein(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Percent of Daily Goals',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              Builder(
                builder: (context) {
                  final profile = readServerProfile();
                  final calGoal = (profile?.resolvedDailyCalorieGoal() ?? 2220)
                      .toDouble();
                  final calConsumed =
                      _diaryCaloriesConsumed.toDouble() + macros.calories;
                  final (calP, calT) = _dailyGoalBar(calConsumed, calGoal);
                  final (carbP, carbT) = _dailyGoalBar(
                    _diaryCarbsConsumed + macros.carbs,
                    profile?.carbsGoalG ?? 0,
                  );
                  final (fatP, fatT) = _dailyGoalBar(
                    _diaryFatConsumed + macros.fat,
                    profile?.fatGoalG ?? 0,
                  );
                  final (proteinP, proteinT) = _dailyGoalBar(
                    _diaryProteinConsumed + macros.protein,
                    profile?.proteinGoalG ?? 0,
                  );

                  return Column(
                    children: [
                      _GoalBar(
                        label: 'Calories',
                        percent: calP,
                        trailing: calT,
                      ),
                      _GoalBar(label: 'Carbs', percent: carbP, trailing: carbT),
                      _GoalBar(label: 'Fat', percent: fatP, trailing: fatT),
                      _GoalBar(
                        label: 'Protein',
                        percent: proteinP,
                        trailing: proteinT,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              _SectionHeader(
                title: 'Nutrition Facts',
                trailing: TextButton(
                  onPressed: () =>
                      setState(() => showNutritionFacts = !showNutritionFacts),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        showNutritionFacts ? 'Hide' : 'Show',
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        showNutritionFacts
                            ? Icons.expand_less
                            : Icons.expand_more,
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedCrossFade(
                crossFadeState: showNutritionFacts
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 250),
                firstChild: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _FactRow(
                          'Energy',
                          '${macros.calories.toStringAsFixed(1)} kcal',
                        ),
                        _FactRow('Fat', '${macros.fat.toStringAsFixed(1)} g'),
                        _FactRow(
                          'Carbohydrate',
                          '${macros.carbs.toStringAsFixed(1)} g',
                        ),
                        _FactRow(
                          'Protein',
                          '${macros.protein.toStringAsFixed(1)} g',
                        ),
                        _FactRow(
                          'Fiber',
                          '${(widget.food.fiber ?? 0).toStringAsFixed(1)} g',
                        ),
                        _FactRow(
                          'Sugar',
                          '${(widget.food.nutrients[NutrientKeys.sugarsG] ?? 0).toStringAsFixed(1)} g',
                        ),
                        _FactRow(
                          'Saturated Fat',
                          '${(widget.food.nutrients[NutrientKeys.fatSaturatedG] ?? 0).toStringAsFixed(1)} g',
                        ),
                        _FactRow(
                          'Cholesterol',
                          '${(widget.food.nutrients[NutrientKeys.cholesterolMg] ?? 0).toStringAsFixed(1)} mg',
                        ),
                        _FactRow(
                          'Sodium',
                          '${(widget.food.sodium ?? 0).toStringAsFixed(1)} mg',
                        ),
                        _FactRow(
                          'Potassium',
                          '${(widget.food.nutrients[NutrientKeys.potassiumMg] ?? 0).toStringAsFixed(1)} mg',
                        ),
                        for (final field in AppNutrients.micronutrients)
                          _FactRow(
                            field.label,
                            '${(widget.food.nutrients[field.key] ?? 0).toStringAsFixed(1)} ${field.unit}',
                          ),
                      ],
                    ),
                  ),
                ),
                secondChild: const SizedBox.shrink(),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _pickServingSize() {
    final servingOptions = widget.food.units;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Title with close button
                Row(
                  children: [
                    Text(
                      'Select Unit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.grey[600]),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Serving options
                ...servingOptions.map((option) {
                  final isSelected = option == servingSize;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        servingSize = option;
                        _unitSelectedIndex = servingOptions.indexOf(option);
                        // Trigger UI rebuild to update macros
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blue[50]
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              option,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.blue[600]
                                    : Colors.black,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.blue[600],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          const SizedBox(width: 16),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _pickMeal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Title with close button
                Row(
                  children: [
                    Text(
                      'Select Meal',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.grey[600]),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Meal options
                ...MealOptions.values.map((option) {
                  final isSelected = option == selectedMeal;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMeal = option;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue[50] : Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Colors.blue[200]!
                              : Colors.grey[200]!,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Meal icon
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue[100]
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              option.icon,
                              color: isSelected
                                  ? Colors.blue[600]
                                  : Colors.grey[600],
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Meal name
                          Expanded(
                            child: Text(
                              option.displayName,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.blue[700]
                                    : Colors.black,
                              ),
                            ),
                          ),

                          // Selection indicator
                          if (isSelected)
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.blue[600],
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              ),
                            )
                          else
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[400]!,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _FoodHeader extends StatelessWidget {
  const _FoodHeader({
    required this.title,
    required this.subtitle,
    this.showAiChip = false,
  });
  final String title;
  final String subtitle;
  final bool showAiChip;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            if (showAiChip) ...[
              const SizedBox(width: 8),
              const AiEstimatedFoodChip(compact: false),
            ],
          ],
        ),
        const SizedBox(height: 4),
        subtitle.isNotEmpty
            ? Text(
                subtitle,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({required this.label, required this.trailing});
  final String label;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        trailing,
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, this.onTap});
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue[200]!),
          borderRadius: BorderRadius.circular(14),
          color: Colors.blue[50],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blue[600],
          ),
        ),
      ),
    );
  }
}

class _WeekSelector extends StatelessWidget {
  const _WeekSelector({
    required this.baseDate,
    required this.selectedIndices,
    required this.onSelected,
  });
  final DateTime baseDate;
  final Set<int> selectedIndices;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final now = baseDate;
    final today = DateTime.now();

    // Calculate dates for the current week (starting from Sunday)
    final currentWeekday = now.weekday; // Monday = 1, Sunday = 7
    final daysFromSunday = currentWeekday == 7 ? 0 : currentWeekday;
    final startOfWeek = now.subtract(Duration(days: daysFromSunday));

    return SizedBox(
      height: 66,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        padding: EdgeInsets.zero,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final date = startOfWeek.add(Duration(days: i));
          final isSelected = selectedIndices.contains(i);
          final isToday =
              date.day == today.day &&
              date.month == today.month &&
              date.year == today.year;

          return GestureDetector(
            onTap: () => onSelected(i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  days[i],
                  style: TextStyle(
                    color: isToday ? Colors.blue[600] : Colors.grey[600],
                    fontSize: 11,
                    height: 1.0,
                    fontWeight: isToday ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  width: 46,
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blue[600]
                        : (isToday ? Colors.blue[50] : Colors.grey[100]),
                    borderRadius: BorderRadius.circular(23),
                    border: Border.all(
                      color: isToday
                          ? Colors.blue[300]!
                          : (isSelected
                                ? Colors.blue[600]!
                                : Colors.grey[300]!),
                      width: isToday ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    '${date.day}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isSelected
                          ? Colors.white
                          : (isToday ? Colors.blue[600] : Colors.grey[600]),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: child,
    );
  }
}

class _CaloriesDonut extends StatelessWidget {
  const _CaloriesDonut({
    required this.calories,
    required this.carbsPercent,
    required this.fatPercent,
    required this.proteinPercent,
  });
  final int calories;
  final double carbsPercent;
  final double fatPercent;
  final double proteinPercent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: CustomPaint(
        painter: _MacroDonutPainter(
          carbsPercent: carbsPercent,
          fatPercent: fatPercent,
          proteinPercent: proteinPercent,
          trackColor: Colors.grey[200]!,
          carbsColor: AppShellUi.macroCarbs(context),
          fatColor: AppShellUi.macroFat(context),
          proteinColor: AppShellUi.macroProtein(context),
          strokeWidth: 12,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$calories',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text('cal', style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }
}

class _MacroDonutPainter extends CustomPainter {
  _MacroDonutPainter({
    required this.carbsPercent,
    required this.fatPercent,
    required this.proteinPercent,
    required this.trackColor,
    required this.carbsColor,
    required this.fatColor,
    required this.proteinColor,
    required this.strokeWidth,
  });

  final double carbsPercent; // 0..1
  final double fatPercent; // 0..1
  final double proteinPercent; // 0..1
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

    // Track
    canvas.drawCircle(center, radius, trackPaint);

    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = -90 * 3.1415926535 / 180;
    double currentAngle = startAngle;

    // Carbs segment
    if (carbsPercent > 0) {
      final carbsPaint = Paint()
        ..color = carbsColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final sweepAngle = 2 * 3.1415926535 * carbsPercent;
      canvas.drawArc(rect, currentAngle, sweepAngle, false, carbsPaint);
      currentAngle += sweepAngle;
    }

    // Fat segment
    if (fatPercent > 0) {
      final fatPaint = Paint()
        ..color = fatColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final sweepAngle = 2 * 3.1415926535 * fatPercent;
      canvas.drawArc(rect, currentAngle, sweepAngle, false, fatPaint);
      currentAngle += sweepAngle;
    }

    // Protein segment
    if (proteinPercent > 0) {
      final proteinPaint = Paint()
        ..color = proteinColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final sweepAngle = 2 * 3.1415926535 * proteinPercent;
      canvas.drawArc(rect, currentAngle, sweepAngle, false, proteinPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _MacroStat extends StatelessWidget {
  const _MacroStat({
    required this.percent,
    required this.grams,
    required this.label,
    required this.color,
  });
  final int percent; // 0..100
  final double grams;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text(
              '$percent%',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$grams g',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalBar extends StatelessWidget {
  const _GoalBar({
    required this.label,
    required this.percent,
    required this.trailing,
  });
  final String label;
  final double percent; // 0..1
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(label)),
              const SizedBox(width: 8),
              Text(trailing, style: const TextStyle(color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: percent,
              backgroundColor: const Color(0xFF2A2F38),
              color: Colors.blue[800],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.trailing});
  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          trailing,
        ],
      ),
    );
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow(this.name, this.value);
  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(name)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
