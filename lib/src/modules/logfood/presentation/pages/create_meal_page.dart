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
import '../../domain/repository/food_repository.dart';
import '../application/cubit/logfood_page_cubit.dart';

class CreateMealPage extends StatefulWidget {
  const CreateMealPage({super.key, required this.availableFoods});

  final List<FoodModel> availableFoods;

  @override
  State<CreateMealPage> createState() => _CreateMealPageState();
}

class _CreateMealPageState extends State<CreateMealPage> {
  final _nameController = TextEditingController();
  final _directionsController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _foodSearchController = TextEditingController();
  final Map<int, FoodModel> _selectedFoods = {};
  int _shareWith = 1;
  bool _isSaving = false;

  /// Same API as tab All: GET api/Food?search=&includeAll=true
  final List<FoodModel> _apiSearchResults = [];
  bool _isSearchingFoods = false;
  int _foodSearchSeq = 0;
  Timer? _foodSearchDebounce;

  Color get _primary => Colors.blue[600]!;

  @override
  void dispose() {
    _foodSearchDebounce?.cancel();
    _nameController.dispose();
    _directionsController.dispose();
    _imageUrlController.dispose();
    _foodSearchController.dispose();
    super.dispose();
  }

  double get _totalCalories =>
      _selectedFoods.values.fold(0, (sum, f) => sum + f.calories);
  double get _totalCarbs =>
      _selectedFoods.values.fold(0, (sum, f) => sum + (f.carbs ?? 0));
  double get _totalFat =>
      _selectedFoods.values.fold(0, (sum, f) => sum + (f.fat ?? 0));
  double get _totalProtein =>
      _selectedFoods.values.fold(0, (sum, f) => sum + (f.protein ?? 0));
  double get _totalFiber =>
      _selectedFoods.values.fold(0, (sum, f) => sum + (f.fiber ?? 0));
  double get _totalSugar => _selectedFoods.values.fold(
    0,
    (sum, f) => sum + (f.nutrients[NutrientKeys.sugarsG] ?? 0),
  );
  double get _totalSaturatedFat => _selectedFoods.values.fold(
    0,
    (sum, f) => sum + (f.nutrients[NutrientKeys.fatSaturatedG] ?? 0),
  );
  double get _totalCholesterol => _selectedFoods.values.fold(
    0,
    (sum, f) => sum + (f.nutrients[NutrientKeys.cholesterolMg] ?? 0),
  );
  double get _totalSodium =>
      _selectedFoods.values.fold(0, (sum, f) => sum + (f.sodium ?? 0));
  double get _totalPotassium => _selectedFoods.values.fold(
    0,
    (sum, f) => sum + (f.nutrients[NutrientKeys.potassiumMg] ?? 0),
  );
  Map<String, double> get _totalMicronutrients => {
    for (final field in AppNutrients.micronutrients)
      field.key: _selectedFoods.values.fold(
        0,
        (sum, f) => sum + (f.nutrients[field.key] ?? 0),
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

  Future<void> _saveMeal() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      AppDialogs.showSnackBar(
        message: 'Meal name is required',
        backgroundColor: Colors.orange,
      );
      return;
    }
    setState(() => _isSaving = true);
    final cubit = context.read<LogFoodPageCubit>();
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
        if (!mounted) return;
        setState(() => _isSaving = false);
        AppDialogs.showSnackBar(
          message: 'Failed to upload image to Firebase Storage',
          backgroundColor: Colors.red,
        );
        return;
      }
    }
    final created = await cubit.createMeal(
      name,
      imageUrl: imageUrl.isEmpty ? null : imageUrl,
    );
    if (!mounted) return;
    if (!created) {
      setState(() => _isSaving = false);
      AppDialogs.showSnackBar(
        message: 'Failed to create meal',
        backgroundColor: Colors.red,
      );
      return;
    }

    final latestState = cubit.state;
    int? mealId;
    if (latestState is LogFoodPageLoaded && latestState.myMeals.isNotEmpty) {
      mealId = latestState.myMeals.first.id;
    }
    if (mealId != null) {
      await cubit.updateMeal(
        mealId,
        directions: _directionsController.text.trim(),
        shareWith: _shareWith,
        imageUrl: imageUrl.isEmpty ? null : imageUrl,
      );
      for (final food in _selectedFoods.values) {
        final foodId = food.id;
        if (foodId != null) {
          await cubit.addFoodToMeal(mealId, foodId);
        }
      }
    }

    if (!mounted) return;
    setState(() => _isSaving = false);
    AppDialogs.showSnackBar(
      message: 'Meal created successfully',
      backgroundColor: Colors.green,
    );
    Navigator.of(context).pop(true);
  }

  String? _pickedImagePath;

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
    } catch (e) {
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
            'Create Meal',
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
                onPressed: _isSaving ? null : _saveMeal,
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
                      _selectedImagePreview(_pickedImagePath),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              _sectionCard(
                title: 'Nutrition Summary',
                child: _NutritionCard(
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
              _CreateNutritionFactsExpansion(
                child: _CreateNutritionFactsCard(
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
                title: 'Add Food Items',
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
                    if (_selectedFoods.isNotEmpty) ...[
                      Builder(
                        builder: (context) {
                          final colorScheme = Theme.of(context).colorScheme;
                          final selectedFoods = _selectedFoods.values.toList();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selected foods (${selectedFoods.length})',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: 104.h),
                                child: SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  child: Wrap(
                                    spacing: 8.w,
                                    runSpacing: 8.h,
                                    children: selectedFoods.map((food) {
                                      final id = food.id;
                                      return InputChip(
                                        label: Text(
                                          food.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                colorScheme.onPrimaryContainer,
                                          ),
                                        ),
                                        onDeleted: id == null
                                            ? null
                                            : () => setState(() {
                                                _selectedFoods.remove(id);
                                              }),
                                        deleteIcon: Icon(
                                          Icons.close,
                                          size: 16.sp,
                                          color: colorScheme.onPrimaryContainer,
                                        ),
                                        backgroundColor:
                                            colorScheme.primaryContainer,
                                        side: BorderSide(
                                          color: colorScheme.primary.withValues(
                                            alpha: 0.25,
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          );
                        },
                      ),
                    ],
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
                                    : 'Pick foods below, or type to search the full catalog.')
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
                        final selected = _selectedFoods.containsKey(id);
                        final servingLabel = _servingSizeUnitLabel(food);
                        return Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          decoration: BoxDecoration(
                            color: selected ? Colors.blue[50] : Colors.grey[50],
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: selected
                                  ? Colors.blue[300]!
                                  : Colors.grey[200]!,
                            ),
                          ),
                          child: CheckboxListTile(
                            value: selected,
                            activeColor: _primary,
                            controlAffinity: ListTileControlAffinity.leading,
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
                            onChanged: (_) {
                              setState(() {
                                if (selected) {
                                  _selectedFoods.remove(id);
                                } else {
                                  _selectedFoods[id] = food;
                                }
                              });
                            },
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

  Widget _selectedImagePreview(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return const SizedBox.shrink();
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: double.infinity,
        height: 140.h,
        color: Colors.grey[100],
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Center(
            child: Icon(Icons.broken_image_outlined, color: Colors.grey[500]),
          ),
        ),
      ),
    );
  }
}

class _NutritionCard extends StatelessWidget {
  const _NutritionCard({
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
          _CaloriesDonut(
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
                _MacroStat(
                  percent: (carbsPercent * 100).round(),
                  grams: (carbsGrams * 10).round() / 10,
                  label: 'Carbs',
                  color: Colors.orange[400]!,
                ),
                const SizedBox(height: 8),
                _MacroStat(
                  percent: (fatPercent * 100).round(),
                  grams: (fatGrams * 10).round() / 10,
                  label: 'Fat',
                  color: Colors.red[400]!,
                ),
                const SizedBox(height: 8),
                _MacroStat(
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

class _MacroStat extends StatelessWidget {
  const _MacroStat({
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

class _CreateNutritionFactsCard extends StatelessWidget {
  const _CreateNutritionFactsCard({
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
          _CreateFactRow(
            name: 'Energy',
            value: '${calories.toStringAsFixed(1)} kcal',
          ),
          _CreateFactRow(
            name: 'Carbohydrate',
            value: '${carbs.toStringAsFixed(1)} g',
          ),
          _CreateFactRow(name: 'Fat', value: '${fat.toStringAsFixed(1)} g'),
          _CreateFactRow(
            name: 'Protein',
            value: '${protein.toStringAsFixed(1)} g',
          ),
          _CreateFactRow(name: 'Fiber', value: '${fiber.toStringAsFixed(1)} g'),
          _CreateFactRow(name: 'Sugar', value: '${sugar.toStringAsFixed(1)} g'),
          _CreateFactRow(
            name: 'Saturated Fat',
            value: '${saturatedFat.toStringAsFixed(1)} g',
          ),
          _CreateFactRow(
            name: 'Cholesterol',
            value: '${cholesterol.toStringAsFixed(1)} mg',
          ),
          _CreateFactRow(
            name: 'Sodium',
            value: '${sodium.toStringAsFixed(1)} mg',
          ),
          _CreateFactRow(
            name: 'Potassium',
            value: '${potassium.toStringAsFixed(1)} mg',
          ),
          for (final field in AppNutrients.micronutrients)
            _CreateFactRow(
              name: field.label,
              value:
                  '${(micronutrients[field.key] ?? 0).toStringAsFixed(1)} ${field.unit}',
            ),
        ],
      ),
    );
  }
}

class _CreateNutritionFactsExpansion extends StatelessWidget {
  const _CreateNutritionFactsExpansion({required this.child});

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

class _CreateFactRow extends StatelessWidget {
  const _CreateFactRow({required this.name, required this.value});

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
