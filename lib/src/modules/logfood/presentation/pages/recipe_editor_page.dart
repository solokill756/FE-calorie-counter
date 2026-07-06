import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/theme/app_shell_ui.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../core/data/local/storage.dart';
import '../../../../core/services/firebase_storage_upload_service.dart';
import '../../../../core/services/image_picker_service.dart';
import '../../data/models/food_model.dart';
import '../../data/models/recipe_model.dart';
import '../../domain/repository/food_repository.dart';

class RecipeEditorPage extends StatefulWidget {
  const RecipeEditorPage({
    super.key,
    this.recipeId,
    this.initialDraft,
    required this.availableFoods,
    this.readOnly = false,
  });

  final int? recipeId;
  final RecipeModel? initialDraft;
  final List<FoodModel> availableFoods;
  final bool readOnly;

  @override
  State<RecipeEditorPage> createState() => _RecipeEditorPageState();
}

class _IngredientRowState {
  _IngredientRowState({
    required this.rowId,
    this.foodId,
    required String name,
    required String quantity,
    required String unit,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.sodium,
    required this.sugar,
    required this.saturatedFat,
    required this.cholesterol,
    required this.potassium,
    Map<String, double>? micronutrients,
  }) : nameController = TextEditingController(text: name),
       quantityController = TextEditingController(text: quantity),
       unitController = TextEditingController(text: unit),
       nameFocusNode = FocusNode(),
       scrollController = ScrollController(),
       micronutrients = Map<String, double>.from(micronutrients ?? const {});

  final int rowId;
  int? foodId;
  final TextEditingController nameController;
  final TextEditingController quantityController;
  final TextEditingController unitController;
  final FocusNode nameFocusNode;
  final ScrollController scrollController;
  double calories;
  double protein;
  double carbs;
  double fat;
  double fiber;
  double sodium;
  double sugar;
  double saturatedFat;
  double cholesterol;
  double potassium;
  final Map<String, double> micronutrients;
  FoodModel? sourceFood;
  String? selectedUnit;

  void dispose() {
    nameController.dispose();
    quantityController.dispose();
    unitController.dispose();
    nameFocusNode.dispose();
    scrollController.dispose();
  }
}

class _StepRowState {
  _StepRowState({
    required this.rowId,
    required String instruction,
    required String duration,
    required String tips,
  }) : instructionController = TextEditingController(text: instruction),
       durationController = TextEditingController(text: duration),
       tipsController = TextEditingController(text: tips);

  final int rowId;
  final TextEditingController instructionController;
  final TextEditingController durationController;
  final TextEditingController tipsController;

  void dispose() {
    instructionController.dispose();
    durationController.dispose();
    tipsController.dispose();
  }
}

class _RecipeEditorPageState extends State<RecipeEditorPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _servingsController = TextEditingController(text: '1');
  final _prepController = TextEditingController(text: '0');
  final _cookController = TextEditingController(text: '0');
  final _tagsController = TextEditingController();

  final List<_IngredientRowState> _ingredients = [];
  final List<_StepRowState> _steps = [];
  final Map<int, List<FoodModel>> _ingredientSuggestions = {};
  final Map<int, List<FoodModel>> _ingredientSuggestionsPrev = {};
  final Map<int, bool> _ingredientSearching = {};
  final Map<int, int> _ingredientSearchSeq = {};
  final Map<int, Timer?> _ingredientDebounce = {};
  // Pagination state for ingredient searches
  final Map<int, int> _ingredientPage = {};
  final Map<int, bool> _ingredientHasMore = {};
  final Map<int, bool> _ingredientLoadingMore = {};
  static const int _ingredientSearchPageSize = 10;

  bool _loading = false;
  bool _saving = false;
  bool _isReadOnly = false;
  String? _pickedImagePath;
  int _nextRowId = 0;
  String _difficulty = 'easy';
  String? _sourceType;
  String? _mealSlot;
  String? _dateKey;
  int _shareWith = 1;
  double? _score;
  List<String> _warnings = const [];
  Color get _primary => Colors.blue[600]!;

  /// True for new recipes & AI drafts: row macros are **per catalog serving** (ServingSize).
  /// False for loaded saved recipes: macros on each line are **already scaled** at save time.
  bool _macrosPerServingCatalog = false;

  @override
  void initState() {
    super.initState();
    _isReadOnly = widget.readOnly;
    if (widget.recipeId != null) {
      _loadRecipe();
    } else if (widget.initialDraft != null) {
      _applyRecipeModel(widget.initialDraft!);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(_hydrateMissingSourceFoods());
      });
    } else {
      _macrosPerServingCatalog = true;
      _addIngredient();
      _addStep();
    }
  }

  void _onIngredientFocusChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _servingsController.dispose();
    _prepController.dispose();
    _cookController.dispose();
    _tagsController.dispose();
    for (final i in _ingredients) {
      i.nameFocusNode.removeListener(_onIngredientFocusChanged);
      i.dispose();
    }
    for (final s in _steps) {
      s.dispose();
    }
    for (final t in _ingredientDebounce.values) {
      t?.cancel();
    }
    super.dispose();
  }

  Future<void> _loadRecipe() async {
    setState(() => _loading = true);
    final repo = getIt<FoodRepository>();
    final result = await repo.getRecipeById(widget.recipeId!);
    if (!mounted) return;
    result.fold(
      (recipe) {
        _applyRecipeModel(recipe);
        setState(() => _loading = false);
        unawaited(_hydrateMissingSourceFoods());
      },
      (error) {
        setState(() => _loading = false);
        AppDialogs.showErrorSnackBar(
          message: error.message.isNotEmpty
              ? error.message
              : 'Failed to load recipe',
        );
        Navigator.of(context).pop(false);
      },
    );
  }

  int _nextId() {
    _nextRowId += 1;
    return _nextRowId;
  }

  /// Catalog foods from [availableFoods] can be stubs (0 macros). Still fetch full row from API.
  bool _foodHasCatalogMacros(FoodModel food) {
    final hasMacro =
        food.calories > 0 ||
        (food.protein ?? 0) > 0 ||
        (food.carbs ?? 0) > 0 ||
        (food.fat ?? 0) > 0;
    final hasTrackedBreakdown =
        food.nutrients.containsKey(NutrientKeys.sugarsG) ||
        food.nutrients.containsKey(NutrientKeys.fatSaturatedG) ||
        food.nutrients.containsKey(NutrientKeys.cholesterolMg) ||
        food.nutrients.containsKey(NutrientKeys.potassiumMg) ||
        AppNutrients.micronutrients.any(
          (field) => food.nutrients.containsKey(field.key),
        );
    return hasMacro && hasTrackedBreakdown;
  }

  void _copyNutritionFromFood(_IngredientRowState row, FoodModel food) {
    row.calories = food.calories;
    row.protein = food.protein ?? 0;
    row.carbs = food.carbs ?? 0;
    row.fat = food.fat ?? 0;
    row.fiber = food.fiber ?? 0;
    row.sodium = food.sodium ?? 0;
    row.sugar = food.nutrients[NutrientKeys.sugarsG] ?? 0;
    row.saturatedFat = food.nutrients[NutrientKeys.fatSaturatedG] ?? 0;
    row.cholesterol = food.nutrients[NutrientKeys.cholesterolMg] ?? 0;
    row.potassium = food.nutrients[NutrientKeys.potassiumMg] ?? 0;
    row.micronutrients
      ..clear()
      ..addEntries(
        AppNutrients.micronutrients.map(
          (field) => MapEntry(field.key, food.nutrients[field.key] ?? 0),
        ),
      );
  }

  /// Match [unitController] to a canonical label in [sourceFood].units so dropdown + [_unitSizeOf] agree.
  void _syncIngredientSelectedUnit(_IngredientRowState row) {
    final food = row.sourceFood;
    if (food == null || food.units.isEmpty) return;
    final u = row.unitController.text.trim();
    for (final x in food.units) {
      if (x.toLowerCase() == u.toLowerCase()) {
        row.selectedUnit = x;
        row.unitController.text = x;
        return;
      }
    }
    final idx =
        (food.unitShowIndex >= 0 && food.unitShowIndex < food.units.length)
        ? food.unitShowIndex
        : 0;
    row.selectedUnit = food.units[idx];
    row.unitController.text = row.selectedUnit!;
  }

  /// Search hits can be incomplete; one GET by id matches [FoodController.toApiItem] (derived kcal, etc.).
  Future<void> _refreshIngredientFoodFromServer(_IngredientRowState row) async {
    if (row.foodId == null) return;
    if (row.sourceFood != null && _foodHasCatalogMacros(row.sourceFood!)) {
      return;
    }

    final repo = getIt<FoodRepository>();
    final res = await repo.getFoodById(row.foodId!);
    if (!mounted) return;
    res.fold((food) {
      row.sourceFood = food;
      _copyNutritionFromFood(row, food);
      _syncIngredientSelectedUnit(row);
      setState(() {});
    }, (_) {});
  }

  Future<void> _hydrateMissingSourceFoods() async {
    final idsToFetch = _ingredients
        .map((r) => r.foodId)
        .whereType<int>()
        .where((id) {
          final row = _ingredients.firstWhere((r) => r.foodId == id);
          return row.sourceFood == null ||
              !_foodHasCatalogMacros(row.sourceFood!);
        })
        .toSet()
        .toList();

    if (idsToFetch.isEmpty) return;

    final repo = getIt<FoodRepository>();
    final result = await repo.getFoodsByIds(idsToFetch);
    if (!mounted) return;

    var changed = false;
    result.fold((foods) {
      final foodMap = {for (final f in foods) f.id: f};
      for (final row in _ingredients) {
        if (row.foodId == null) continue;
        final food = foodMap[row.foodId!];
        if (food != null) {
          row.sourceFood = food;
          _copyNutritionFromFood(row, food);
          _syncIngredientSelectedUnit(row);
          changed = true;
        }
      }
    }, (_) {});

    if (changed && mounted) setState(() {});
  }

  void _applyRecipeModel(RecipeModel recipe) {
    _macrosPerServingCatalog = recipe.id == 0;
    _nameController.text = recipe.name;
    _descriptionController.text = recipe.description ?? '';
    _imageUrlController.text = recipe.imageUrl ?? '';
    _servingsController.text = '${recipe.servings}';
    _prepController.text = '${recipe.prepMinutes}';
    _cookController.text = '${recipe.cookMinutes}';
    _difficulty = recipe.difficulty;
    _sourceType = recipe.sourceType;
    _mealSlot = recipe.mealSlot;
    _dateKey = recipe.dateKey;
    _shareWith = recipe.shareWith;
    _score = recipe.score;
    _warnings = List<String>.from(recipe.warnings);
    _tagsController.text = recipe.tags.join(', ');
    for (final i in _ingredients) {
      i.dispose();
    }
    _ingredients
      ..clear()
      ..addAll(
        recipe.ingredients.map((item) {
          final row = _IngredientRowState(
            rowId: _nextId(),
            foodId: item.foodId,
            name: item.name,
            quantity: item.quantity.toString(),
            unit: item.unit,
            calories: item.calories,
            protein: item.protein,
            carbs: item.carbs,
            fat: item.fat,
            fiber: item.fiber,
            sodium: item.sodium,
            sugar: item.sugar,
            saturatedFat: item.saturatedFat,
            cholesterol: item.cholesterol,
            potassium: item.potassium,
            micronutrients: item.micronutrients,
          );
          row.nameFocusNode.addListener(_onIngredientFocusChanged);
          if (item.foodId != null) {
            final matches = widget.availableFoods.where(
              (f) => f.id == item.foodId,
            );
            if (matches.isNotEmpty) {
              final food = matches.first;
              row.sourceFood = food;
              if (row.nameController.text.trim().isEmpty) {
                row.nameController.text = food.name;
              }
              row.selectedUnit = item.unit;
              _syncIngredientSelectedUnit(row);
              // Drafts (id == 0): always use DB/catalog macros for scaling. Saved recipes keep line totals.
              if (_macrosPerServingCatalog) {
                _copyNutritionFromFood(row, food);
              }
            }
          }
          return row;
        }),
      );
    for (final s in _steps) {
      s.dispose();
    }
    _steps
      ..clear()
      ..addAll(
        recipe.steps.map(
          (s) => _StepRowState(
            rowId: _nextId(),
            instruction: s.instruction,
            duration: s.duration?.toString() ?? '',
            tips: s.tips ?? '',
          ),
        ),
      );
    if (_ingredients.isEmpty) _addIngredient();
    if (_steps.isEmpty) _addStep();
  }

  void _addIngredient() {
    final row = _IngredientRowState(
      rowId: _nextId(),
      name: '',
      quantity: '1',
      unit: 'g',
      calories: 0,
      protein: 0,
      carbs: 0,
      fat: 0,
      fiber: 0,
      sodium: 0,
      sugar: 0,
      saturatedFat: 0,
      cholesterol: 0,
      potassium: 0,
      micronutrients: const {},
    );
    row.nameFocusNode.addListener(_onIngredientFocusChanged);
    setState(() {
      _ingredients.add(row);
    });
  }

  void _addStep() {
    setState(() {
      _steps.add(
        _StepRowState(
          rowId: _nextId(),
          instruction: '',
          duration: '',
          tips: '',
        ),
      );
    });
  }

  void _applyFoodToIngredient(_IngredientRowState row, FoodModel food) {
    row.foodId = food.id;
    row.nameController.text = food.name;
    _copyNutritionFromFood(row, food);
    row.sourceFood = food;
    if (food.units.isNotEmpty) {
      final idx =
          (food.unitShowIndex >= 0 && food.unitShowIndex < food.units.length)
          ? food.unitShowIndex
          : 0;
      row.selectedUnit = food.units[idx];
      row.unitController.text = row.selectedUnit!;
      final refG = food.unitSizes[idx] <= 0 ? 100.0 : food.unitSizes[idx];
      final q = refG.round() == refG
          ? refG.round().toString()
          : refG.toString();
      row.quantityController.text = q;
    }
    unawaited(_refreshIngredientFoodFromServer(row));
  }

  double _quantityOf(_IngredientRowState row) {
    final parsed = double.tryParse(
      row.quantityController.text.trim().replaceAll(',', '.'),
    );
    if (parsed == null || parsed <= 0) return 0;
    return parsed;
  }

  double _unitSizeOf(_IngredientRowState row) {
    final food = row.sourceFood;
    if (food == null) return 1;
    final unit = (row.selectedUnit ?? row.unitController.text).trim();
    if (unit.isEmpty) return 1;
    final idx = food.units.indexWhere(
      (u) => u.toLowerCase() == unit.toLowerCase(),
    );
    if (idx < 0 || idx >= food.unitSizes.length) return 1;
    return food.unitSizes[idx] <= 0 ? 1 : food.unitSizes[idx];
  }

  double _baseUnitSizeOf(_IngredientRowState row) {
    final food = row.sourceFood;
    if (food == null || food.unitSizes.isEmpty) return 1;
    final idx =
        (food.unitShowIndex >= 0 && food.unitShowIndex < food.unitSizes.length)
        ? food.unitShowIndex
        : 0;
    final value = food.unitSizes[idx];
    return value <= 0 ? 1 : value;
  }

  double _scaledNutrient(double baseValue, _IngredientRowState row) {
    final qty = _quantityOf(row);
    if (qty <= 0) return 0;
    final scaleByUnit = _unitSizeOf(row) / _baseUnitSizeOf(row);
    return baseValue * qty * scaleByUnit;
  }

  /// Catalog draft: [base] is per reference serving (first [FoodModel] unit, e.g. 100 g).
  /// Quantity is catalog portions from recipe builder `amount`.
  /// Quantity field = **grams** of this ingredient → line = base × (grams / referenceGrams).
  double _lineMacroForIngredient({
    required double rowStored,
    required double foodFallback,
    required _IngredientRowState row,
  }) {
    if (!_macrosPerServingCatalog) {
      if (foodFallback > 0) {
        return _scaledNutrient(foodFallback, row);
      }
      if (rowStored > 0) return rowStored;
      return _scaledNutrient(foodFallback, row);
    }
    final base = rowStored > 0 ? rowStored : foodFallback;
    final qty = _quantityOf(row);
    if (qty <= 0 || base <= 0) return 0;
    return _scaledNutrient(base, row);
  }

  double _lineCalories(_IngredientRowState r) => _lineMacroForIngredient(
    rowStored: r.calories,
    foodFallback: r.sourceFood?.calories ?? 0,
    row: r,
  );

  double _lineProtein(_IngredientRowState r) => _lineMacroForIngredient(
    rowStored: r.protein,
    foodFallback: r.sourceFood?.protein ?? 0,
    row: r,
  );

  double _lineCarbs(_IngredientRowState r) => _lineMacroForIngredient(
    rowStored: r.carbs,
    foodFallback: r.sourceFood?.carbs ?? 0,
    row: r,
  );

  double _lineFat(_IngredientRowState r) => _lineMacroForIngredient(
    rowStored: r.fat,
    foodFallback: r.sourceFood?.fat ?? 0,
    row: r,
  );

  double _lineFiber(_IngredientRowState r) => _lineMacroForIngredient(
    rowStored: r.fiber,
    foodFallback: r.sourceFood?.fiber ?? 0,
    row: r,
  );

  double _lineSodium(_IngredientRowState r) => _lineMacroForIngredient(
    rowStored: r.sodium,
    foodFallback: r.sourceFood?.sodium ?? 0,
    row: r,
  );

  double _lineSugar(_IngredientRowState r) => _lineMacroForIngredient(
    rowStored: r.sugar,
    foodFallback: r.sourceFood?.nutrients[NutrientKeys.sugarsG] ?? 0,
    row: r,
  );

  double _lineSaturatedFat(_IngredientRowState r) => _lineMacroForIngredient(
    rowStored: r.saturatedFat,
    foodFallback: r.sourceFood?.nutrients[NutrientKeys.fatSaturatedG] ?? 0,
    row: r,
  );

  double _lineCholesterol(_IngredientRowState r) => _lineMacroForIngredient(
    rowStored: r.cholesterol,
    foodFallback: r.sourceFood?.nutrients[NutrientKeys.cholesterolMg] ?? 0,
    row: r,
  );

  double _linePotassium(_IngredientRowState r) => _lineMacroForIngredient(
    rowStored: r.potassium,
    foodFallback: r.sourceFood?.nutrients[NutrientKeys.potassiumMg] ?? 0,
    row: r,
  );

  double _lineMicronutrient(_IngredientRowState r, String key) =>
      _lineMacroForIngredient(
        rowStored: r.micronutrients[key] ?? 0,
        foodFallback: r.sourceFood?.nutrients[key] ?? 0,
        row: r,
      );

  double get _totalCalories =>
      _ingredients.fold(0.0, (sum, r) => sum + _lineCalories(r));
  double get _totalCarbs =>
      _ingredients.fold(0.0, (sum, r) => sum + _lineCarbs(r));
  double get _totalFat => _ingredients.fold(0.0, (sum, r) => sum + _lineFat(r));
  double get _totalProtein =>
      _ingredients.fold(0.0, (sum, r) => sum + _lineProtein(r));
  double get _totalFiber =>
      _ingredients.fold(0.0, (sum, r) => sum + _lineFiber(r));
  double get _totalSodium =>
      _ingredients.fold(0.0, (sum, r) => sum + _lineSodium(r));
  double get _totalSugar =>
      _ingredients.fold(0.0, (sum, r) => sum + _lineSugar(r));
  double get _totalSaturatedFat =>
      _ingredients.fold(0.0, (sum, r) => sum + _lineSaturatedFat(r));
  double get _totalCholesterol =>
      _ingredients.fold(0.0, (sum, r) => sum + _lineCholesterol(r));
  double get _totalPotassium =>
      _ingredients.fold(0.0, (sum, r) => sum + _linePotassium(r));
  Map<String, double> get _totalMicronutrients => {
    for (final field in AppNutrients.micronutrients)
      field.key: _ingredients.fold(
        0.0,
        (sum, r) => sum + _lineMicronutrient(r, field.key),
      ),
  };

  double get _macroTotalCalories =>
      (_totalCarbs * 4) + (_totalFat * 9) + (_totalProtein * 4);
  double get _carbsPercent =>
      _macroTotalCalories <= 0 ? 0 : (_totalCarbs * 4) / _macroTotalCalories;
  double get _fatPercent =>
      _macroTotalCalories <= 0 ? 0 : (_totalFat * 9) / _macroTotalCalories;
  double get _proteinPercent =>
      _macroTotalCalories <= 0 ? 0 : (_totalProtein * 4) / _macroTotalCalories;

  Future<bool> _confirmRemoveDialog(String title, String message) async {
    final ok = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey[700]),
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: const Text('Cancel'),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[500],
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: const Text('Remove'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    return ok == true;
  }

  void _scheduleIngredientSearch(_IngredientRowState row, String query) {
    _ingredientDebounce[row.rowId]?.cancel();
    if (query.trim().isEmpty) {
      setState(() {
        _ingredientSuggestions[row.rowId] = <FoodModel>[];
        _ingredientSearching[row.rowId] = false;
      });
      return;
    }
    // keep previous suggestions visible while a new search is debounced/running
    _ingredientSuggestionsPrev[row.rowId] =
        _ingredientSuggestions[row.rowId] ??
        _ingredientSuggestionsPrev[row.rowId] ??
        <FoodModel>[];
    // reset pagination for new query
    _ingredientPage[row.rowId] = 1;
    _ingredientHasMore[row.rowId] = true;
    _ingredientLoadingMore[row.rowId] = false;
    _ingredientDebounce[row.rowId] = Timer(
      const Duration(milliseconds: 250),
      () {
        _runIngredientSearch(row, query.trim(), page: 1);
      },
    );
  }

  Future<void> _runIngredientSearch(
    _IngredientRowState row,
    String query, {
    int page = 1,
  }) async {
    final repo = getIt<FoodRepository>();
    final seq = (_ingredientSearchSeq[row.rowId] ?? 0) + 1;
    _ingredientSearchSeq[row.rowId] = seq;
    if (page == 1) setState(() => _ingredientSearching[row.rowId] = true);
    if (page > 1) setState(() => _ingredientLoadingMore[row.rowId] = true);

    final result = await repo.searchFoods(
      query,
      includeAll: true,
      mineOnly: false,
      page: page,
      pageSize: _ingredientSearchPageSize,
    );
    if (!mounted) return;
    if ((_ingredientSearchSeq[row.rowId] ?? 0) != seq) return;
    result.fold(
      (foods) {
        setState(() {
          if (page == 1) {
            _ingredientSuggestions[row.rowId] = foods;
          } else {
            final prev = _ingredientSuggestions[row.rowId] ?? [];
            _ingredientSuggestions[row.rowId] = [...prev, ...foods];
          }
          _ingredientSearching[row.rowId] = false;
          _ingredientLoadingMore[row.rowId] = false;
          _ingredientPage[row.rowId] = page;
          _ingredientHasMore[row.rowId] =
              foods.length == _ingredientSearchPageSize;
        });
      },
      (_) {
        setState(() {
          if (page == 1) _ingredientSuggestions[row.rowId] = [];
          _ingredientSearching[row.rowId] = false;
          _ingredientLoadingMore[row.rowId] = false;
          _ingredientHasMore[row.rowId] = false;
        });
      },
    );
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      AppDialogs.showSnackBar(
        message: 'Recipe name is required',
        backgroundColor: Colors.orange,
      );
      return;
    }
    final ingredients = _ingredients
        .where((r) => r.nameController.text.trim().isNotEmpty)
        .toList();
    if (ingredients.isEmpty) {
      AppDialogs.showSnackBar(
        message: 'At least one ingredient is required',
        backgroundColor: Colors.orange,
      );
      return;
    }
    final steps = _steps
        .where((s) => s.instructionController.text.trim().isNotEmpty)
        .toList();
    if (steps.isEmpty) {
      AppDialogs.showSnackBar(
        message: 'At least one step is required',
        backgroundColor: Colors.orange,
      );
      return;
    }

    setState(() => _saving = true);
    var imageUrl = _imageUrlController.text.trim();
    if (_pickedImagePath != null && _pickedImagePath!.isNotEmpty) {
      try {
        imageUrl = await FirebaseStorageUploadService.uploadImageFile(
          filePath: _pickedImagePath!,
          folder: 'recipe-images',
          ownerId: Storage.userID?.toString(),
        );
        _imageUrlController.text = imageUrl;
      } catch (_) {
        if (!mounted) return;
        setState(() => _saving = false);
        AppDialogs.showSnackBar(
          message: 'Failed to upload image to Firebase Storage',
          backgroundColor: Colors.red,
        );
        return;
      }
    }
    final model = RecipeModel(
      id: widget.recipeId ?? 0,
      name: name,
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      imageUrl: imageUrl.isEmpty ? null : imageUrl,
      servings: int.tryParse(_servingsController.text.trim()) ?? 1,
      prepMinutes: int.tryParse(_prepController.text.trim()) ?? 0,
      cookMinutes: int.tryParse(_cookController.text.trim()) ?? 0,
      difficulty: _difficulty,
      tags: _tagsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      ingredients: ingredients
          .map(
            (r) => RecipeIngredientModel(
              foodId: r.foodId,
              name: r.nameController.text.trim(),
              quantity: double.tryParse(r.quantityController.text.trim()) ?? 0,
              unit: r.unitController.text.trim().isEmpty
                  ? 'g'
                  : r.unitController.text.trim(),
              calories: _lineCalories(r),
              protein: _lineProtein(r),
              carbs: _lineCarbs(r),
              fat: _lineFat(r),
              fiber: _lineFiber(r),
              sodium: _lineSodium(r),
              sugar: _lineSugar(r),
              saturatedFat: _lineSaturatedFat(r),
              cholesterol: _lineCholesterol(r),
              potassium: _linePotassium(r),
              micronutrients: {
                for (final field in AppNutrients.micronutrients)
                  field.key: _lineMicronutrient(r, field.key),
              },
            ),
          )
          .toList(),
      steps: List.generate(
        steps.length,
        (i) => RecipeStepModel(
          order: i + 1,
          instruction: steps[i].instructionController.text.trim(),
          duration: int.tryParse(steps[i].durationController.text.trim()),
          tips: steps[i].tipsController.text.trim().isEmpty
              ? null
              : steps[i].tipsController.text.trim(),
        ),
      ),
      sourceType: _sourceType,
      mealSlot: _mealSlot,
      dateKey: _dateKey,
      shareWith: _shareWith,
      score: _score,
      warnings: _warnings,
    );
    final repo = getIt<FoodRepository>();
    final result = widget.recipeId == null
        ? await repo.createRecipe(model)
        : await repo.updateRecipe(widget.recipeId!, model);
    if (!mounted) return;
    result.fold(
      (_) {
        setState(() => _saving = false);
        AppDialogs.showSnackBar(
          message: widget.recipeId == null
              ? 'Recipe created'
              : 'Recipe updated',
          backgroundColor: Colors.green,
        );
        Navigator.of(context).pop(true);
      },
      (error) {
        setState(() => _saving = false);
        AppDialogs.showSnackBar(
          message: error.message.isNotEmpty
              ? error.message
              : 'Save recipe failed',
          backgroundColor: Colors.red,
        );
      },
    );
  }

  Future<void> _pickRecipeImageFromGallery() async {
    try {
      final file = await ImagePickerService.pickFromGallery();
      if (file == null) return;
      if (!mounted) return;
      setState(() {
        _pickedImagePath = file.path;
      });
      AppDialogs.showSnackBar(
        message: 'Image selected. Save recipe to upload to Firebase Storage.',
        backgroundColor: Colors.green,
      );
    } catch (_) {
      if (!mounted) return;
      AppDialogs.showSnackBar(
        message: 'Failed to pick image',
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> _takeRecipePhoto() async {
    try {
      final file = await ImagePickerService.takePhoto();
      if (file == null) return;
      if (!mounted) return;
      setState(() {
        _pickedImagePath = file.path;
      });
      AppDialogs.showSnackBar(
        message: 'Photo captured. Save recipe to upload to Firebase Storage.',
        backgroundColor: Colors.green,
      );
    } catch (_) {
      if (!mounted) return;
      AppDialogs.showSnackBar(
        message: 'Failed to capture photo',
        backgroundColor: Colors.red,
      );
    }
  }

  Widget _fieldLabel(String text) => Text(
    text,
    style: TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
      color: Colors.grey[700],
    ),
  );

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Colors.blue[100]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: Colors.blue[100]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: _primary),
      ),
    );
  }

  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }

  /// API may return duplicate unit strings; [DropdownButtonFormField] requires unique [DropdownMenuItem] values.
  Widget _buildIngredientUnitDropdown(_IngredientRowState row) {
    final food = row.sourceFood;
    if (food == null || food.units.isEmpty) {
      return const SizedBox.shrink();
    }
    final seen = <String>{};
    final uniqueUnits = <String>[];
    for (final u in food.units) {
      if (seen.add(u)) uniqueUnits.add(u);
    }
    final preferred = (row.selectedUnit ?? row.unitController.text).trim();
    final value = preferred.isNotEmpty && uniqueUnits.contains(preferred)
        ? preferred
        : uniqueUnits.first;
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(10.r),
      decoration: _inputDecoration(),
      value: value,
      items: uniqueUnits
          .map(
            (u) => DropdownMenuItem<String>(
              value: u,
              child: Text(u, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      isExpanded: true,
      onChanged: _isReadOnly
          ? null
          : (v) {
              row.selectedUnit = v;
              row.unitController.text = v ?? '';
              setState(() {});
            },
    );
  }

  Widget _recipeImagePreview() {
    final localPath = _pickedImagePath;
    final remoteUrl = _imageUrlController.text.trim();
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: double.infinity,
        height: 160.h,
        color: Colors.grey[100],
        child: localPath != null && localPath.isNotEmpty
            ? Image.file(
                File(localPath),
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Center(
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: Colors.grey[500],
                  ),
                ),
              )
            : Image.network(
                remoteUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Center(
                  child: Icon(Icons.image_outlined, color: Colors.grey[500]),
                ),
              ),
      ),
    );
  }

  String _difficultyLabel() {
    switch (_difficulty) {
      case 'medium':
        return 'Medium';
      case 'hard':
        return 'Hard';
      case 'easy':
      default:
        return 'Easy';
    }
  }

  List<String> _readOnlyTags() => _tagsController.text
      .split(',')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

  Widget _buildReadOnlyContent() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      children: [
        _buildReadOnlyHeader(),
        SizedBox(height: 14.h),
        _detailSectionCard(
          title: 'Ingredients',
          child: _buildReadOnlyIngredients(),
        ),
        SizedBox(height: 14.h),
        _detailSectionCard(
          title: 'Nutrition',
          child: _buildReadOnlyNutrition(),
        ),
        SizedBox(height: 14.h),
        _detailSectionCard(title: 'Steps', child: _buildReadOnlySteps()),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildReadOnlyHeader() {
    final scheme = Theme.of(context).colorScheme;
    final description = _descriptionController.text.trim();
    final tags = _readOnlyTags();
    final prep = int.tryParse(_prepController.text.trim()) ?? 0;
    final cook = int.tryParse(_cookController.text.trim()) ?? 0;
    final totalTime = prep + cook;
    return Container(
      decoration: AppShellUi.cardDecoration(context),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_pickedImagePath != null ||
              _imageUrlController.text.trim().isNotEmpty)
            _readOnlyHeroImage(),
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _nameController.text.trim().isEmpty
                      ? 'Untitled recipe'
                      : _nameController.text.trim(),
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurface,
                  ),
                ),
                if (description.isNotEmpty) ...[
                  SizedBox(height: 8.h),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13.sp,
                      height: 1.35,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    _detailMetaChip(
                      icon: Icons.people_alt_outlined,
                      label:
                          '${_servingsController.text.trim().isEmpty ? '1' : _servingsController.text.trim()} servings',
                    ),
                    if (prep > 0)
                      _detailMetaChip(
                        icon: Icons.timer_outlined,
                        label: 'Prep $prep min',
                      ),
                    if (cook > 0)
                      _detailMetaChip(
                        icon: Icons.soup_kitchen_outlined,
                        label: 'Cook $cook min',
                      ),
                    if (totalTime > 0)
                      _detailMetaChip(
                        icon: Icons.schedule_outlined,
                        label: 'Total $totalTime min',
                      ),
                    _detailMetaChip(
                      icon: Icons.local_fire_department_outlined,
                      label: _difficultyLabel(),
                    ),
                  ],
                ),
                if (tags.isNotEmpty) ...[
                  SizedBox(height: 10.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: tags
                        .map(
                          (tag) => _textChip(
                            tag,
                            background: scheme.secondaryContainer.withValues(
                              alpha: 0.55,
                            ),
                            foreground: scheme.onSecondaryContainer,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _readOnlyHeroImage() {
    final scheme = Theme.of(context).colorScheme;
    final localPath = _pickedImagePath;
    final remoteUrl = _imageUrlController.text.trim();
    final fallback = Center(
      child: Icon(
        Icons.image_outlined,
        size: 36.sp,
        color: scheme.onSurfaceVariant,
      ),
    );
    return SizedBox(
      width: double.infinity,
      height: 190.h,
      child: localPath != null && localPath.isNotEmpty
          ? Image.file(
              File(localPath),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => fallback,
            )
          : Image.network(
              remoteUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => fallback,
            ),
    );
  }

  Widget _detailSectionCard({required String title, required Widget child}) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: AppShellUi.cardDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
          SizedBox(height: 10.h),
          child,
        ],
      ),
    );
  }

  Widget _detailMetaChip({required IconData icon, required String label}) {
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

  Widget _readOnlyStepTipBlock(String tips) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: scheme.tertiaryContainer.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline,
            size: 14.sp,
            color: scheme.onTertiaryContainer,
          ),
          SizedBox(width: 6.w),
          Expanded(
            child: Text(
              tips,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                height: 1.35,
                color: scheme.onTertiaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textChip(
    String label, {
    required Color background,
    required Color foreground,
  }) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 80.w,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: foreground,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildReadOnlyIngredients() {
    final scheme = Theme.of(context).colorScheme;
    final rows = _ingredients
        .where((row) => row.nameController.text.trim().isNotEmpty)
        .toList();
    if (rows.isEmpty) {
      return Text(
        'No ingredients added.',
        style: TextStyle(fontSize: 13.sp, color: scheme.onSurfaceVariant),
      );
    }
    return Column(
      children: List.generate(rows.length, (index) {
        final row = rows[index];
        final isLast = index == rows.length - 1;
        final quantity = row.quantityController.text.trim();
        final unit = row.unitController.text.trim();
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      row.nameController.text.trim(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      [
                        if (quantity.isNotEmpty) quantity,
                        if (unit.isNotEmpty) unit,
                      ].join(' '),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '${_lineCalories(row).toStringAsFixed(0)} kcal',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: scheme.primary,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildReadOnlyNutrition() {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        _RecipeNutritionCard(
          calories: _totalCalories.ceil(),
          carbsPercent: _carbsPercent,
          fatPercent: _fatPercent,
          proteinPercent: _proteinPercent,
          carbsGrams: _totalCarbs,
          fatGrams: _totalFat,
          proteinGrams: _totalProtein,
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
              _RecipeNutritionFacts(
                calories: _totalCalories,
                carbs: _totalCarbs,
                fat: _totalFat,
                protein: _totalProtein,
                fiber: _totalFiber,
                sodium: _totalSodium,
                sugar: _totalSugar,
                saturatedFat: _totalSaturatedFat,
                cholesterol: _totalCholesterol,
                potassium: _totalPotassium,
                micronutrients: _totalMicronutrients,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReadOnlySteps() {
    final scheme = Theme.of(context).colorScheme;
    final steps = _steps
        .where((step) => step.instructionController.text.trim().isNotEmpty)
        .toList();
    if (steps.isEmpty) {
      return Text(
        'No steps added.',
        style: TextStyle(fontSize: 13.sp, color: scheme.onSurfaceVariant),
      );
    }
    return Column(
      children: List.generate(
        steps.length,
        (index) => _readOnlyStepTile(
          step: steps[index],
          number: index + 1,
          isLast: index == steps.length - 1,
        ),
      ),
    );
  }

  Widget _readOnlyStepTile({
    required _StepRowState step,
    required int number,
    required bool isLast,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final duration = step.durationController.text.trim();
    final tips = step.tipsController.text.trim();
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 36.w,
            child: Column(
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: scheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: scheme.primary.withValues(alpha: 0.22),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    '$number',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w800,
                      color: scheme.onPrimary,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2.w,
                      margin: EdgeInsets.symmetric(vertical: 5.h),
                      color: scheme.outlineVariant,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 14.h),
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: scheme.outlineVariant),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step.instructionController.text.trim(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        height: 1.35,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurface,
                      ),
                    ),
                    if (duration.isNotEmpty || tips.isNotEmpty) ...[
                      SizedBox(height: 10.h),
                      if (duration.isNotEmpty)
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: [
                            _detailMetaChip(
                              icon: Icons.timer_outlined,
                              label: '$duration min',
                            ),
                          ],
                        ),
                      if (tips.isNotEmpty) ...[
                        if (duration.isNotEmpty) SizedBox(height: 8.h),
                        _readOnlyStepTipBlock(tips),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context).copyWith(
      colorScheme: Theme.of(
        context,
      ).colorScheme.copyWith(primary: _primary, secondary: _primary),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: _primary,
        selectionColor: _primary.withValues(alpha: 0.25),
        selectionHandleColor: _primary,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        ),
      ),
    );
    return Theme(
      data: localTheme,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.recipeId == null
                ? 'Create Recipe'
                : (_isReadOnly ? 'Recipe Detail' : 'Edit Recipe'),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            if (widget.recipeId != null && _isReadOnly)
              TextButton(
                onPressed: () => setState(() => _isReadOnly = false),
                child: Text('Edit', style: TextStyle(color: _primary)),
              ),
            if (!_isReadOnly)
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: ElevatedButton(
                  onPressed: (_saving || _loading) ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.blue[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: _saving
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Save'),
                ),
              ),
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.translucent,
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _isReadOnly
              ? _buildReadOnlyContent()
              : ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  children: [
                    _sectionCard(
                      title: 'Recipe Information',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _fieldLabel('Recipe name'),
                          SizedBox(height: 8.h),
                          TextField(
                            controller: _nameController,
                            readOnly: _isReadOnly,
                            decoration: _inputDecoration(
                              hint: 'Ex: Chicken Salad Bowl',
                            ),
                          ),
                          SizedBox(height: 12.h),
                          _fieldLabel('Description'),
                          SizedBox(height: 8.h),
                          TextField(
                            controller: _descriptionController,
                            readOnly: _isReadOnly,
                            maxLines: 3,
                            decoration: _inputDecoration(
                              hint: 'Describe your recipe...',
                            ),
                          ),
                          SizedBox(height: 12.h),
                          if (_pickedImagePath != null ||
                              _imageUrlController.text.trim().isNotEmpty) ...[
                            _recipeImagePreview(),
                            SizedBox(height: 8.h),
                          ],
                          if (!_isReadOnly) ...[
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: _saving
                                        ? null
                                        : _pickRecipeImageFromGallery,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: _primary,
                                      side: BorderSide(
                                        color: Colors.blue[200]!,
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.photo_library_outlined,
                                    ),
                                    label: const Text('Gallery'),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed: _saving
                                        ? null
                                        : _takeRecipePhoto,
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: _primary,
                                      side: BorderSide(
                                        color: Colors.blue[200]!,
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.photo_camera_outlined,
                                    ),
                                    label: const Text('Camera'),
                                  ),
                                ),
                              ],
                            ),
                            if (_pickedImagePath != null) ...[
                              SizedBox(height: 6.h),
                              Text(
                                'Image selected from device',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ],
                          SizedBox(height: 12.h),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final isCompact = constraints.maxWidth < 360.w;
                              final gap = 8.w;
                              final fieldWidth = isCompact
                                  ? constraints.maxWidth
                                  : (constraints.maxWidth - gap * 2) / 3;
                              return Wrap(
                                spacing: gap,
                                runSpacing: 8.h,
                                children: [
                                  SizedBox(
                                    width: fieldWidth,
                                    child: TextField(
                                      controller: _servingsController,
                                      readOnly: _isReadOnly,
                                      keyboardType: TextInputType.number,
                                      decoration: _inputDecoration(
                                        hint: 'Servings',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: fieldWidth,
                                    child: TextField(
                                      controller: _prepController,
                                      readOnly: _isReadOnly,
                                      keyboardType: TextInputType.number,
                                      decoration: _inputDecoration(
                                        hint: 'Prep minutes',
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: fieldWidth,
                                    child: TextField(
                                      controller: _cookController,
                                      readOnly: _isReadOnly,
                                      keyboardType: TextInputType.number,
                                      decoration: _inputDecoration(
                                        hint: 'Cook minutes',
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Used to calculate recipe planning info: total portions and estimated time to prepare and cook.',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          _fieldLabel('Share with'),
                          SizedBox(height: 8.h),
                          DropdownButtonFormField<int>(
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            decoration: _inputDecoration(),
                            value: _shareWith,
                            items: const [
                              DropdownMenuItem(
                                value: 1,
                                child: Text('Private'),
                              ),
                              DropdownMenuItem(
                                value: 2,
                                child: Text('Community'),
                              ),
                            ],
                            onChanged: _isReadOnly
                                ? null
                                : (v) => setState(() => _shareWith = v ?? 1),
                          ),
                          SizedBox(height: 12.h),
                          DropdownButtonFormField<String>(
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            decoration: _inputDecoration(),
                            value: _difficulty,
                            items: const [
                              DropdownMenuItem(
                                value: 'easy',
                                child: Text('Easy'),
                              ),
                              DropdownMenuItem(
                                value: 'medium',
                                child: Text('Medium'),
                              ),
                              DropdownMenuItem(
                                value: 'hard',
                                child: Text('Hard'),
                              ),
                            ],
                            onChanged: _isReadOnly
                                ? null
                                : (v) =>
                                      setState(() => _difficulty = v ?? 'easy'),
                          ),
                          SizedBox(height: 12.h),
                          TextField(
                            controller: _tagsController,
                            readOnly: _isReadOnly,
                            decoration: _inputDecoration(
                              hint: 'Tags (comma separated)',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _sectionCard(
                      title: 'Ingredients',
                      child: Column(
                        children: [
                          ReorderableListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _ingredients.length,
                            onReorder: _isReadOnly
                                ? (_, __) {}
                                : (oldIndex, newIndex) {
                                    setState(() {
                                      if (newIndex > oldIndex) newIndex -= 1;
                                      final item = _ingredients.removeAt(
                                        oldIndex,
                                      );
                                      _ingredients.insert(newIndex, item);
                                    });
                                  },
                            itemBuilder: (_, i) {
                              final row = _ingredients[i];
                              final options =
                                  (_ingredientSuggestions[row.rowId] != null &&
                                      _ingredientSuggestions[row.rowId]!
                                          .isNotEmpty)
                                  ? _ingredientSuggestions[row.rowId]!
                                  : (_ingredientSearching[row.rowId] == true
                                        ? (_ingredientSuggestionsPrev[row
                                                  .rowId] ??
                                              const <FoodModel>[])
                                        : (_ingredientSuggestions[row.rowId] ??
                                              const <FoodModel>[]));
                              return Container(
                                key: ValueKey('ingredient-${row.rowId}'),
                                margin: EdgeInsets.only(bottom: 10.h),
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: Colors.grey[200]!),
                                ),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: row.nameController,
                                      focusNode: row.nameFocusNode,
                                      readOnly: _isReadOnly,
                                      decoration: _inputDecoration(
                                        hint:
                                            _ingredientSearching[row.rowId] ==
                                                true
                                            ? 'Searching...'
                                            : 'Search ingredient from server',
                                      ),
                                      onChanged: _isReadOnly
                                          ? null
                                          : (v) {
                                              _scheduleIngredientSearch(row, v);
                                              setState(() {});
                                            },
                                    ),
                                    if (row.nameFocusNode.hasFocus &&
                                        (options.isNotEmpty ||
                                            _ingredientSearching[row.rowId] ==
                                                true)) ...[
                                      SizedBox(height: 6.h),
                                      Container(
                                        constraints: BoxConstraints(
                                          maxHeight: math.min(
                                            (MediaQuery.of(
                                                      context,
                                                    ).size.height -
                                                    MediaQuery.of(
                                                      context,
                                                    ).viewInsets.bottom) *
                                                0.4,
                                            200.h,
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                          border: Border.all(
                                            color: Colors.blue[100]!,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(
                                                alpha: 0.05,
                                              ),
                                              blurRadius: 6,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                          child:
                                              _ingredientSearching[row.rowId] ==
                                                      true &&
                                                  options.isEmpty
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 12.h,
                                                  ),
                                                  child: Center(
                                                    child: SizedBox(
                                                      width: 18.w,
                                                      height: 18.w,
                                                      child:
                                                          CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                            color: _primary,
                                                          ),
                                                    ),
                                                  ),
                                                )
                                              : NotificationListener<
                                                  ScrollNotification
                                                >(
                                                  onNotification: (notification) {
                                                    // Swallow scroll notifications so they do not bubble up to the parent ListView.
                                                    // This prevents the parent scroll view from dismissing the keyboard/unfocusing the input field.
                                                    return true;
                                                  },
                                                  child: Scrollbar(
                                                    controller:
                                                        row.scrollController,
                                                    child: ListView.builder(
                                                      controller:
                                                          row.scrollController,
                                                      physics:
                                                          const AlwaysScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      padding: EdgeInsets.zero,
                                                      itemCount: options.length,
                                                      itemBuilder: (context, idx) {
                                                        final item =
                                                            options[idx];
                                                        return ListTile(
                                                          dense: true,
                                                          title: Text(
                                                            item.name,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                          subtitle: Text(
                                                            '${item.calories.toStringAsFixed(0)} kcal',
                                                          ),
                                                          onTap: () {
                                                            _applyFoodToIngredient(
                                                              row,
                                                              item,
                                                            );
                                                            row.nameFocusNode
                                                                .unfocus();
                                                            setState(() {});
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                    SizedBox(height: 8.h),
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        final isCompact =
                                            constraints.maxWidth < 300.w;
                                        final gap = 8.w;
                                        final fieldWidth = isCompact
                                            ? constraints.maxWidth
                                            : (constraints.maxWidth - gap) / 2;
                                        return Wrap(
                                          spacing: gap,
                                          runSpacing: 8.h,
                                          children: [
                                            SizedBox(
                                              width: fieldWidth,
                                              child: TextField(
                                                controller:
                                                    row.quantityController,
                                                readOnly: _isReadOnly,
                                                keyboardType:
                                                    const TextInputType.numberWithOptions(
                                                      decimal: true,
                                                    ),
                                                decoration: _inputDecoration(
                                                  hint: 'Quantity',
                                                ),
                                                onChanged: (_) =>
                                                    setState(() {}),
                                              ),
                                            ),
                                            SizedBox(
                                              width: fieldWidth,
                                              child:
                                                  row.sourceFood != null &&
                                                      row
                                                          .sourceFood!
                                                          .units
                                                          .isNotEmpty
                                                  ? _buildIngredientUnitDropdown(
                                                      row,
                                                    )
                                                  : TextField(
                                                      controller:
                                                          row.unitController,
                                                      readOnly: _isReadOnly,
                                                      decoration:
                                                          _inputDecoration(
                                                            hint: 'Unit',
                                                          ),
                                                      onChanged: (_) =>
                                                          setState(() {}),
                                                    ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 6.h),
                                        child: Text(
                                          'Auto nutrition: ${_lineCalories(row).toStringAsFixed(1)} kcal | C ${_lineCarbs(row).toStringAsFixed(1)}g | P ${_lineProtein(row).toStringAsFixed(1)}g | F ${_lineFat(row).toStringAsFixed(1)}g',
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.grey[700],
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ),
                                    if (!_isReadOnly)
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: () async {
                                            final ok = await _confirmRemoveDialog(
                                              'Remove ingredient',
                                              'This ingredient will be removed from recipe.',
                                            );
                                            if (!ok || !mounted) return;
                                            setState(() {
                                              row.nameFocusNode.removeListener(
                                                _onIngredientFocusChanged,
                                              );
                                              row.dispose();
                                              _ingredients.removeAt(i);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.delete_outline,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                          if (!_isReadOnly)
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: _addIngredient,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: _primary,
                                  side: BorderSide(color: Colors.blue[200]!),
                                ),
                                icon: const Icon(Icons.add),
                                label: const Text('Add ingredient'),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _sectionCard(
                      title: 'Nutrition Breakdown',
                      child: Column(
                        children: [
                          _RecipeNutritionCard(
                            calories: _totalCalories.ceil(),
                            carbsPercent: _carbsPercent,
                            fatPercent: _fatPercent,
                            proteinPercent: _proteinPercent,
                            carbsGrams: _totalCarbs,
                            fatGrams: _totalFat,
                            proteinGrams: _totalProtein,
                          ),
                          SizedBox(height: 8.h),
                          Theme(
                            data: Theme.of(
                              context,
                            ).copyWith(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              childrenPadding: EdgeInsets.zero,
                              iconColor: Theme.of(context).colorScheme.primary,
                              collapsedIconColor: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                              title: Text(
                                'More nutrition',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                              children: [
                                SizedBox(height: 4.h),
                                _RecipeNutritionFacts(
                                  calories: _totalCalories,
                                  carbs: _totalCarbs,
                                  fat: _totalFat,
                                  protein: _totalProtein,
                                  fiber: _totalFiber,
                                  sodium: _totalSodium,
                                  sugar: _totalSugar,
                                  saturatedFat: _totalSaturatedFat,
                                  cholesterol: _totalCholesterol,
                                  potassium: _totalPotassium,
                                  micronutrients: _totalMicronutrients,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _sectionCard(
                      title: 'Steps',
                      child: Column(
                        children: [
                          ReorderableListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _steps.length,
                            onReorder: _isReadOnly
                                ? (_, __) {}
                                : (oldIndex, newIndex) {
                                    setState(() {
                                      if (newIndex > oldIndex) newIndex -= 1;
                                      final item = _steps.removeAt(oldIndex);
                                      _steps.insert(newIndex, item);
                                    });
                                  },
                            itemBuilder: (_, i) {
                              final step = _steps[i];
                              return Container(
                                key: ValueKey('step-${step.rowId}'),
                                margin: EdgeInsets.only(bottom: 10.h),
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(color: Colors.grey[200]!),
                                ),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: step.instructionController,
                                      readOnly: _isReadOnly,
                                      maxLines: 2,
                                      decoration: _inputDecoration(
                                        hint: 'Step ${i + 1} instruction',
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    SizedBox(
                                      width: 120.w,
                                      child: TextField(
                                        controller: step.durationController,
                                        readOnly: _isReadOnly,
                                        keyboardType: TextInputType.number,
                                        decoration: _inputDecoration(
                                          hint: 'Duration (min)',
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    TextField(
                                      controller: step.tipsController,
                                      readOnly: _isReadOnly,
                                      minLines: 2,
                                      maxLines: 6,
                                      decoration: _inputDecoration(
                                        hint: 'Tips',
                                      ),
                                    ),
                                    if (!_isReadOnly)
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: () async {
                                            final ok = await _confirmRemoveDialog(
                                              'Remove step',
                                              'This step will be removed from recipe.',
                                            );
                                            if (!ok || !mounted) return;
                                            setState(() {
                                              step.dispose();
                                              _steps.removeAt(i);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.delete_outline,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                          if (!_isReadOnly)
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: _addStep,
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: _primary,
                                  side: BorderSide(color: Colors.blue[200]!),
                                ),
                                icon: const Icon(Icons.add),
                                label: const Text('Add step'),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
        ),
      ),
    );
  }
}

class _RecipeNutritionCard extends StatelessWidget {
  const _RecipeNutritionCard({
    required this.calories,
    required this.carbsPercent,
    required this.fatPercent,
    required this.proteinPercent,
    required this.carbsGrams,
    required this.fatGrams,
    required this.proteinGrams,
  });

  final int calories;
  final double carbsPercent;
  final double fatPercent;
  final double proteinPercent;
  final double carbsGrams;
  final double fatGrams;
  final double proteinGrams;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$calories kcal',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Carbs ${(carbsPercent * 100).round()}% • Fat ${(fatPercent * 100).round()}% • Protein ${(proteinPercent * 100).round()}%',
            style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 6),
          Text(
            'C ${carbsGrams.toStringAsFixed(1)}g | F ${fatGrams.toStringAsFixed(1)}g | P ${proteinGrams.toStringAsFixed(1)}g',
            style: TextStyle(fontSize: 12, color: scheme.onSurfaceVariant),
            softWrap: true,
          ),
        ],
      ),
    );
  }
}

class _RecipeNutritionFacts extends StatelessWidget {
  const _RecipeNutritionFacts({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
    required this.fiber,
    required this.sodium,
    required this.sugar,
    required this.saturatedFat,
    required this.cholesterol,
    required this.potassium,
    required this.micronutrients,
  });

  final double calories;
  final double carbs;
  final double fat;
  final double protein;
  final double fiber;
  final double sodium;
  final double sugar;
  final double saturatedFat;
  final double cholesterol;
  final double potassium;
  final Map<String, double> micronutrients;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        children: [
          _fact(context, 'Energy', '${calories.toStringAsFixed(1)} kcal'),
          _fact(context, 'Carbohydrate', '${carbs.toStringAsFixed(1)} g'),
          _fact(context, 'Fat', '${fat.toStringAsFixed(1)} g'),
          _fact(context, 'Protein', '${protein.toStringAsFixed(1)} g'),
          _fact(context, 'Fiber', '${fiber.toStringAsFixed(1)} g'),
          _fact(context, 'Sugar', '${sugar.toStringAsFixed(1)} g'),
          _fact(
            context,
            'Saturated Fat',
            '${saturatedFat.toStringAsFixed(1)} g',
          ),
          _fact(context, 'Cholesterol', '${cholesterol.toStringAsFixed(1)} mg'),
          _fact(context, 'Sodium', '${sodium.toStringAsFixed(1)} mg'),
          _fact(context, 'Potassium', '${potassium.toStringAsFixed(1)} mg'),
          for (final field in AppNutrients.micronutrients)
            _fact(
              context,
              field.label,
              '${(micronutrients[field.key] ?? 0).toStringAsFixed(1)} ${field.unit}',
            ),
        ],
      ),
    );
  }

  Widget _fact(BuildContext context, String name, String value) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontSize: 12, color: scheme.onSurface),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: scheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
