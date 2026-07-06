import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/dialogs/app_dialogs.dart';
import '../../../../common/utils/getit_utils.dart';
import '../../../../core/data/local/storage.dart';
import '../../../../core/services/firebase_storage_upload_service.dart';
import '../../../../core/services/image_picker_service.dart';
import '../../data/models/food_model.dart';
import '../../data/models/meal_detail_model.dart';
import '../../domain/repository/food_repository.dart';
import '../application/cubit/logfood_page_cubit.dart';

class _LineRow {
  _LineRow({
    required this.mealFoodId,
    required this.food,
    required double quantity,
  }) : qtyController = TextEditingController(text: _LineRow._fmtQty(quantity));

  final int? mealFoodId;
  final FoodModel food;
  final TextEditingController qtyController;
  late final ObjectKey key = ObjectKey(this);

  static String _fmtQty(double q) =>
      q == q.roundToDouble() ? q.round().toString() : q.toStringAsFixed(2);

  double readQuantity() {
    final v = double.tryParse(qtyController.text.trim().replaceAll(',', '.'));
    if (v == null) return 1;
    if (v < 0.01) return 0.01;
    return v;
  }

  void dispose() => qtyController.dispose();
}

/// Full-screen edit: metadata, quantities, remove / add foods (not a food-detail flow).
class EditMealPage extends StatefulWidget {
  const EditMealPage({
    super.key,
    required this.mealId,
    required this.availableFoods,
  });

  final int mealId;
  final List<FoodModel> availableFoods;

  @override
  State<EditMealPage> createState() => _EditMealPageState();
}

class _EditMealPageState extends State<EditMealPage> {
  final _nameController = TextEditingController();
  final _directionsController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _foodSearchController = TextEditingController();
  final List<_LineRow> _lines = [];
  final Set<int> _initialMealFoodIds = {};
  final Map<int, double> _initialQty = {};
  int _shareWith = 1;
  bool _loading = true;
  bool _isSaving = false;
  Object? _loadError;
  final List<FoodModel> _apiSearchResults = [];
  bool _isSearchingFoods = false;
  int _foodSearchSeq = 0;
  Timer? _foodSearchDebounce;
  String? _pickedImagePath;

  Color get _primary => Colors.blue[600]!;

  double get _totalCalories =>
      _lines.fold(0.0, (sum, l) => sum + l.food.calories * l.readQuantity());
  double get _totalCarbs => _lines.fold(
    0.0,
    (sum, l) => sum + (l.food.carbs ?? 0) * l.readQuantity(),
  );
  double get _totalFat =>
      _lines.fold(0.0, (sum, l) => sum + (l.food.fat ?? 0) * l.readQuantity());
  double get _totalProtein => _lines.fold(
    0.0,
    (sum, l) => sum + (l.food.protein ?? 0) * l.readQuantity(),
  );
  double get _totalFiber => _lines.fold(
    0.0,
    (sum, l) => sum + (l.food.fiber ?? 0) * l.readQuantity(),
  );
  double get _totalSugar => _lines.fold(
    0.0,
    (sum, l) =>
        sum + (l.food.nutrients[NutrientKeys.sugarsG] ?? 0) * l.readQuantity(),
  );
  double get _totalSaturatedFat => _lines.fold(
    0.0,
    (sum, l) =>
        sum +
        (l.food.nutrients[NutrientKeys.fatSaturatedG] ?? 0) * l.readQuantity(),
  );
  double get _totalCholesterol => _lines.fold(
    0.0,
    (sum, l) =>
        sum +
        (l.food.nutrients[NutrientKeys.cholesterolMg] ?? 0) * l.readQuantity(),
  );
  double get _totalSodium => _lines.fold(
    0.0,
    (sum, l) => sum + (l.food.sodium ?? 0) * l.readQuantity(),
  );
  double get _totalPotassium => _lines.fold(
    0.0,
    (sum, l) =>
        sum +
        (l.food.nutrients[NutrientKeys.potassiumMg] ?? 0) * l.readQuantity(),
  );
  Map<String, double> get _totalMicronutrients => {
    for (final field in AppNutrients.micronutrients)
      field.key: _lines.fold(
        0.0,
        (sum, l) => sum + (l.food.nutrients[field.key] ?? 0) * l.readQuantity(),
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

  String _servingSizeUnitLabel(FoodModel food) {
    if (food.units.isEmpty) return 'serving';
    final idx =
        (food.unitShowIndex >= 0 && food.unitShowIndex < food.units.length)
        ? food.unitShowIndex
        : 0;
    final unit = food.units[idx].trim();
    return unit.isEmpty ? 'serving' : unit;
  }

  @override
  void initState() {
    super.initState();
    _loadMeal();
  }

  @override
  void dispose() {
    _foodSearchDebounce?.cancel();
    for (final line in _lines) {
      line.dispose();
    }
    _nameController.dispose();
    _directionsController.dispose();
    _imageUrlController.dispose();
    _foodSearchController.dispose();
    super.dispose();
  }

  FoodModel _fallbackFood(MealLineItem item) {
    final q = item.quantity <= 0 ? 1.0 : item.quantity;
    final nutrients = <String, double>{};
    if (item.lineCalories > 0) {
      nutrients[NutrientKeys.caloriesKcal] = item.lineCalories / q;
    }
    return FoodModel(
      id: item.foodId,
      name: item.displayName,
      description: item.displayName,
      brand: item.food?.brandName,
      isVerified: item.food?.isVerified ?? false,
      servingPerContainer: 1,
      units: const ['1 serving'],
      unitSizes: const [1],
      unitShowIndex: 0,
      quantity: 1,
      nutrients: nutrients,
    );
  }

  Future<void> _loadMeal() async {
    setState(() {
      _loading = true;
      _loadError = null;
    });
    final repo = getIt<FoodRepository>();
    final result = await repo.getMealDetail(widget.mealId);
    if (!mounted) return;

    MealDetail? detail;
    Object? err;
    result.fold((d) => detail = d, (e) => err = e);
    if (err != null) {
      setState(() {
        _loadError = err;
        _loading = false;
      });
      return;
    }

    final d = detail!;
    for (final line in _lines) {
      line.dispose();
    }
    _lines.clear();
    _initialMealFoodIds.clear();
    _initialQty.clear();

    _nameController.text = d.name;
    _directionsController.text = d.directions ?? '';
    _imageUrlController.text = d.imageUrl ?? '';
    _shareWith = d.shareWith;

    final idsToFetch = d.items.map((item) => item.foodId).toList();
    final batchResult = await repo.getFoodsByIds(idsToFetch);

    if (!mounted) return;

    List<FoodModel> foods = [];
    batchResult.fold(
      (list) {
        final foodMap = {for (final f in list) f.id: f};
        foods = d.items
            .map((item) => foodMap[item.foodId] ?? _fallbackFood(item))
            .toList();
      },
      (_) {
        foods = d.items.map(_fallbackFood).toList();
      },
    );

    if (!mounted) return;
    for (var i = 0; i < d.items.length; i++) {
      final item = d.items[i];
      final row = _LineRow(
        mealFoodId: item.mealFoodId,
        food: foods[i],
        quantity: item.quantity,
      );
      _lines.add(row);
      if (item.mealFoodId > 0) {
        _initialMealFoodIds.add(item.mealFoodId);
        _initialQty[item.mealFoodId] = item.quantity;
      }
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _runFoodSearch(String raw) async {
    final q = raw.trim();
    if (q.length < 2) {
      if (!mounted) return;
      setState(() {
        _foodSearchSeq++;
        _apiSearchResults.clear();
        _isSearchingFoods = false;
      });
      return;
    }
    final seq = ++_foodSearchSeq;
    if (!mounted) return;
    setState(() => _isSearchingFoods = true);

    final result = await getIt<FoodRepository>().searchFoods(
      q,
      includeAll: true,
      mineOnly: false,
    );

    if (!mounted || seq != _foodSearchSeq) return;
    result.fold(
      (foods) => setState(() {
        _apiSearchResults
          ..clear()
          ..addAll(foods);
        _isSearchingFoods = false;
      }),
      (_) => setState(() {
        _apiSearchResults.clear();
        _isSearchingFoods = false;
      }),
    );
  }

  void _scheduleFoodSearch(String value) {
    _foodSearchDebounce?.cancel();
    _foodSearchDebounce = Timer(const Duration(milliseconds: 350), () {
      if (!mounted) return;
      _runFoodSearch(value);
    });
  }

  void _appendFood(FoodModel food) {
    final id = food.id;
    if (id == null) return;
    setState(() {
      _lines.add(_LineRow(mealFoodId: null, food: food, quantity: 1));
    });
  }

  void _removeLine(int index) {
    final removed = _lines[index];
    setState(() {
      _lines.removeAt(index);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      removed.dispose();
    });
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      AppDialogs.showWarningSnackBar(message: 'Meal name is required');
      return;
    }
    for (final line in _lines) {
      if (line.readQuantity() < 0.01) {
        AppDialogs.showWarningSnackBar(
          message: 'Each food needs quantity at least 0.01',
        );
        return;
      }
    }

    LogFoodPageCubit? pageCubit;
    try {
      pageCubit = context.read<LogFoodPageCubit>();
    } catch (_) {}

    setState(() => _isSaving = true);
    final repo = getIt<FoodRepository>();
    final mealId = widget.mealId;
    var failed = false;
    var imageUrl = _imageUrlController.text.trim();

    if (_pickedImagePath != null && _pickedImagePath!.isNotEmpty) {
      try {
        imageUrl = await FirebaseStorageUploadService.uploadImageFile(
          filePath: _pickedImagePath!,
          folder: 'meal-images',
          ownerId: Storage.userID?.toString(),
        );
        _imageUrlController.text = imageUrl;
      } catch (_) {
        if (mounted) setState(() => _isSaving = false);
        AppDialogs.showErrorSnackBar(
          message: 'Failed to upload image to Firebase Storage',
        );
        return;
      }
    }

    final metaResult = await repo.updateMeal(
      mealId,
      name: name,
      directions: _directionsController.text.trim(),
      shareWith: _shareWith,
      imageUrl: imageUrl,
    );
    metaResult.fold((_) {}, (_) => failed = true);

    if (failed) {
      if (mounted) setState(() => _isSaving = false);
      AppDialogs.showErrorSnackBar(message: 'Failed to update meal');
      return;
    }

    final currentPersisted = _lines
        .where((l) => l.mealFoodId != null)
        .map((l) => l.mealFoodId!)
        .toSet();

    for (final id in _initialMealFoodIds.difference(currentPersisted)) {
      final rem = await repo.removeMealItem(mealId, id);
      rem.fold((_) {}, (_) => failed = true);
      if (failed) break;
    }

    if (!failed) {
      for (final line in _lines) {
        final mfid = line.mealFoodId;
        if (mfid == null) continue;
        final orig = _initialQty[mfid];
        final q = line.readQuantity();
        if (orig != null && (orig - q).abs() >= 0.0001) {
          final up = await repo.updateMealItem(mealId, mfid, quantity: q);
          up.fold((_) {}, (_) => failed = true);
          if (failed) break;
        }
      }
    }

    if (!failed) {
      for (final line in _lines.where((l) => l.mealFoodId == null)) {
        final fid = line.food.id;
        if (fid == null) continue;
        final add = await repo.addFoodToMeal(
          mealId,
          foodId: fid,
          quantity: line.readQuantity(),
        );
        add.fold((_) {}, (_) => failed = true);
        if (failed) break;
      }
    }

    if (failed) {
      if (mounted) setState(() => _isSaving = false);
      AppDialogs.showSnackBar(
        message: 'Failed to sync meal foods',
        backgroundColor: Colors.red,
      );
      return;
    }

    if (pageCubit != null) {
      try {
        await pageCubit.reloadTab('My Meals');
      } catch (_) {}
    }

    if (!mounted) return;
    setState(() => _isSaving = false);
    AppDialogs.showSnackBar(
      message: 'Meal updated',
      backgroundColor: Colors.green,
    );
    Navigator.of(context).pop(true);
  }

  Future<void> _pickMealImageFromGallery() async {
    try {
      final file = await ImagePickerService.pickFromGallery();
      if (file == null) return;
      if (!mounted) return;
      setState(() {
        _pickedImagePath = file.path;
      });
      AppDialogs.showSnackBar(
        message: 'Image selected. Save meal to upload to Firebase Storage.',
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

  Future<void> _takeMealPhoto() async {
    try {
      final file = await ImagePickerService.takePhoto();
      if (file == null) return;
      if (!mounted) return;
      setState(() {
        _pickedImagePath = file.path;
      });
      AppDialogs.showSnackBar(
        message: 'Photo captured. Save meal to upload to Firebase Storage.',
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

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context).copyWith(
      colorScheme: Theme.of(
        context,
      ).colorScheme.copyWith(primary: _primary, secondary: _primary),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
        ),
      ),
    );
    if (_loading) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Edit Meal', style: TextStyle(fontSize: 18.sp)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_loadError != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Edit Meal', style: TextStyle(fontSize: 18.sp)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Could not load meal.', style: TextStyle(fontSize: 16.sp)),
                SizedBox(height: 16.h),
                FilledButton(onPressed: _loadMeal, child: const Text('Retry')),
              ],
            ),
          ),
        ),
      );
    }

    final browseFoods = widget.availableFoods;
    final query = _foodSearchController.text.trim();
    final displayFoods = query.isEmpty
        ? browseFoods
        : List<FoodModel>.from(_apiSearchResults);

    return Theme(
      data: localTheme,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Edit Meal',
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
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: ElevatedButton(
                onPressed: _isSaving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.blue[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: _isSaving
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
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            children: [
              _sectionCard(
                title: 'Meal Information',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _fieldLabel('Meal title'),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: _nameController,
                      decoration: _inputDecoration(
                        hint: 'Ex: High Protein Breakfast',
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _fieldLabel('Share with'),
                    SizedBox(height: 8.h),
                    DropdownButtonFormField<int>(
                      initialValue: _shareWith,
                      items: const [
                        DropdownMenuItem(value: 1, child: Text('Private')),
                        DropdownMenuItem(value: 2, child: Text('Community')),
                      ],
                      onChanged: (v) => setState(() => _shareWith = v ?? 1),
                      decoration: _inputDecoration(),
                    ),
                    SizedBox(height: 12.h),
                    _fieldLabel('Directions'),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: _directionsController,
                      maxLines: 4,
                      decoration: _inputDecoration(
                        hint: 'How to prepare this meal...',
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _isSaving
                                ? null
                                : _pickMealImageFromGallery,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _primary,
                              side: BorderSide(color: Colors.blue[200]!),
                            ),
                            icon: const Icon(Icons.photo_library_outlined),
                            label: const Text('Gallery'),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _isSaving ? null : _takeMealPhoto,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _primary,
                              side: BorderSide(color: Colors.blue[200]!),
                            ),
                            icon: const Icon(Icons.photo_camera_outlined),
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
                      SizedBox(height: 8.h),
                      _imagePreview(),
                    ],
                    if (_pickedImagePath == null &&
                        _imageUrlController.text.trim().isNotEmpty) ...[
                      SizedBox(height: 8.h),
                      _imagePreview(),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              _sectionCard(
                title: 'Foods in this meal',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_lines.isEmpty)
                      Text(
                        'No foods yet. Add from the catalog below.',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[600],
                        ),
                      )
                    else
                      ...List.generate(_lines.length, (index) {
                        final line = _lines[index];
                        return Container(
                          key: line.key,
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      line.food.name,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      'Quantity (servings)',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    TextField(
                                      controller: line.qtyController,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      onChanged: (_) => setState(() {}),
                                      decoration: _inputDecoration(),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red[400],
                                ),
                                onPressed: () => _removeLine(index),
                              ),
                            ],
                          ),
                        );
                      }),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              _sectionCard(
                title: 'Nutrition Summary',
                child: _EditNutritionCard(
                  calories: _totalCalories.ceil(),
                  carbsPercent: _carbsPercent,
                  fatPercent: _fatPercent,
                  proteinPercent: _proteinPercent,
                  carbsGrams: _totalCarbs,
                  fatGrams: _totalFat,
                  proteinGrams: _totalProtein,
                ),
              ),
              SizedBox(height: 16.h),
              _EditNutritionFactsExpansion(
                child: _EditNutritionFactsCard(
                  calories: _totalCalories,
                  carbs: _totalCarbs,
                  fat: _totalFat,
                  protein: _totalProtein,
                  fiber: _totalFiber,
                  sugar: _totalSugar,
                  saturatedFat: _totalSaturatedFat,
                  cholesterol: _totalCholesterol,
                  sodium: _totalSodium,
                  potassium: _totalPotassium,
                  micronutrients: _totalMicronutrients,
                ),
              ),
              SizedBox(height: 16.h),
              _sectionCard(
                title: 'Add foods from catalog',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _foodSearchController,
                      onChanged: (value) {
                        setState(() {});
                        _scheduleFoodSearch(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search foods',
                        prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.blue[200]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: Colors.blue[100]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: _primary),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    if (_isSearchingFoods && query.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Center(
                          child: SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: _primary,
                            ),
                          ),
                        ),
                      )
                    else if (displayFoods.isEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Text(
                          query.isEmpty
                              ? (browseFoods.isEmpty
                                    ? 'Type to search foods, or add items under My Foods first.'
                                    : 'Tap + to add a food from the list, or search the full catalog.')
                              : 'No results found',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      )
                    else
                      ...displayFoods.map((food) {
                        final id = food.id ?? -1;
                        if (id < 0) return const SizedBox.shrink();
                        final servingLabel = _servingSizeUnitLabel(food);
                        return Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: ListTile(
                            title: Text(
                              food.name,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              food.hasCaloriesData
                                  ? '${food.calories.toStringAsFixed(0)} kcal / $servingLabel'
                                  : '—',
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: _primary,
                              ),
                              onPressed: () => _appendFood(food),
                            ),
                          ),
                        );
                      }),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
            ],
          ),
        ),
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

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
        color: Colors.grey[700],
      ),
    );
  }

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

  Widget _imagePreview() {
    final localPath = _pickedImagePath;
    final remoteUrl = _imageUrlController.text.trim();
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: double.infinity,
        height: 140.h,
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
}

class _EditNutritionCard extends StatelessWidget {
  const _EditNutritionCard({
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _EditCaloriesDonut(
            calories: calories,
            carbsPercent: carbsPercent,
            fatPercent: fatPercent,
            proteinPercent: proteinPercent,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _EditMacroStat(
                  percent: (carbsPercent * 100).round(),
                  grams: (carbsGrams * 10).round() / 10,
                  label: 'Carbs',
                  color: Colors.orange[400]!,
                ),
                const SizedBox(height: 8),
                _EditMacroStat(
                  percent: (fatPercent * 100).round(),
                  grams: (fatGrams * 10).round() / 10,
                  label: 'Fat',
                  color: Colors.red[400]!,
                ),
                const SizedBox(height: 8),
                _EditMacroStat(
                  percent: (proteinPercent * 100).round(),
                  grams: (proteinGrams * 10).round() / 10,
                  label: 'Protein',
                  color: Colors.green[400]!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EditCaloriesDonut extends StatelessWidget {
  const _EditCaloriesDonut({
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
        painter: _EditMacroDonutPainter(
          carbsPercent: carbsPercent,
          fatPercent: fatPercent,
          proteinPercent: proteinPercent,
          trackColor: Colors.grey[200]!,
          carbsColor: Colors.orange[400]!,
          fatColor: Colors.red[400]!,
          proteinColor: Colors.green[400]!,
          strokeWidth: 12,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$calories',
                style: const TextStyle(
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

class _EditMacroDonutPainter extends CustomPainter {
  _EditMacroDonutPainter({
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _EditMacroStat extends StatelessWidget {
  const _EditMacroStat({
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
          SizedBox(
            width: 40,
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

class _EditNutritionFactsCard extends StatelessWidget {
  const _EditNutritionFactsCard({
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          _EditFactRow(
            name: 'Energy',
            value: '${calories.toStringAsFixed(1)} kcal',
          ),
          _EditFactRow(
            name: 'Carbohydrate',
            value: '${carbs.toStringAsFixed(1)} g',
          ),
          _EditFactRow(name: 'Fat', value: '${fat.toStringAsFixed(1)} g'),
          _EditFactRow(
            name: 'Protein',
            value: '${protein.toStringAsFixed(1)} g',
          ),
          _EditFactRow(name: 'Fiber', value: '${fiber.toStringAsFixed(1)} g'),
          _EditFactRow(name: 'Sugar', value: '${sugar.toStringAsFixed(1)} g'),
          _EditFactRow(
            name: 'Saturated Fat',
            value: '${saturatedFat.toStringAsFixed(1)} g',
          ),
          _EditFactRow(
            name: 'Cholesterol',
            value: '${cholesterol.toStringAsFixed(1)} mg',
          ),
          _EditFactRow(
            name: 'Sodium',
            value: '${sodium.toStringAsFixed(1)} mg',
          ),
          _EditFactRow(
            name: 'Potassium',
            value: '${potassium.toStringAsFixed(1)} mg',
          ),
          for (final field in AppNutrients.micronutrients)
            _EditFactRow(
              name: field.label,
              value:
                  '${(micronutrients[field.key] ?? 0).toStringAsFixed(1)} ${field.unit}',
            ),
        ],
      ),
    );
  }
}

class _EditNutritionFactsExpansion extends StatelessWidget {
  const _EditNutritionFactsExpansion({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.only(bottom: 10.h),
          iconColor: scheme.primary,
          collapsedIconColor: scheme.onSurfaceVariant,
          title: Text(
            'Nutrition Facts',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          children: [child],
        ),
      ),
    );
  }
}

class _EditFactRow extends StatelessWidget {
  const _EditFactRow({required this.name, required this.value});

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
