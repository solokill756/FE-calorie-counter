import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../helpers/nutrition_date_range.dart';
import 'api/nutrition_api_service.dart';

class NutritionCsvExportService {
  final NutritionApiService _apiService;

  const NutritionCsvExportService(this._apiService);

  Future<String?> exportNutritionToCsv({
    required DateTime currentDate,
    required String period,
  }) async {
    final range = NutritionDateRangeHelper.forPeriod(currentDate, period);
    final items = await _apiService.fetchLogFoodsFromApi(
      startDate: range.startApi,
      endDate: range.endApi,
      includeQuickAdd: true,
      page: 1,
      pageSize: 1000,
    );

    if (items.isEmpty) return null;

    final csv = _buildCsv(items);
    final directory = await getTemporaryDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final file = File('${directory.path}/nutrition_export_$timestamp.csv');
    await file.writeAsString(csv);
    return file.path;
  }

  Future<void> shareCsvFile(String filePath) async {
    await Share.shareXFiles(
      [XFile(filePath)],
      text: 'Nutrition data export',
      subject: 'Nutrition Data Export',
    );
  }

  String _buildCsv(List<Map<String, dynamic>> items) {
    final buffer = StringBuffer();
    buffer.writeln(
      'Date,Meal,Food Name,Calories,Carbs (g),Protein (g),Fat (g),Sodium (mg),Fiber (g),Sugars (g),Saturated Fat (g),Cholesterol (mg),Potassium (mg),Calcium (mg),Iron (mg),Magnesium (mg),Phosphorus (mg),Zinc (mg),Vitamin A (mcg),Vitamin C (mg),Vitamin D (mcg),Vitamin E (mg),Vitamin K (mcg),Vitamin B6 (mg),Vitamin B12 (mcg),Folate DFE (mcg),Serving Size,Servings',
    );

    final sortedItems = [...items]
      ..sort((a, b) {
        final aDate = _string(a, ['loggedAt', 'LoggedAt', 'loggedOn', 'date']);
        final bDate = _string(b, ['loggedAt', 'LoggedAt', 'loggedOn', 'date']);
        return aDate.compareTo(bDate);
      });

    for (final item in sortedItems) {
      final row = [
        _date(item),
        _string(item, ['meal', 'mealType']),
        _foodName(item),
        _numberText(item, ['calories', 'caloriesKcal']),
        _numberText(item, ['totalCarbohydratesG', 'carbs']),
        _numberText(item, ['proteinG', 'protein']),
        _numberText(item, ['totalFatG', 'fat']),
        _numberText(item, ['sodiumMg', 'sodium']),
        _numberText(item, ['dietaryFibersG', 'fiber', 'totalFiberG']),
        _numberText(item, ['sugarsG', 'sugar']),
        _numberText(item, ['saturatedFatG', 'saturatedFat']),
        _numberText(item, ['cholesterolMg', 'cholesterol']),
        _numberText(item, ['potassiumMg', 'potassium']),
        _numberText(item, ['calciumMg', 'calcium']),
        _numberText(item, ['ironMg', 'iron']),
        _numberText(item, ['magnesiumMg', 'magnesium']),
        _numberText(item, ['phosphorusMg', 'phosphorus']),
        _numberText(item, ['zincMg', 'zinc']),
        _numberText(item, ['vitaminAUg', 'vitaminA']),
        _numberText(item, ['vitaminCMg', 'vitaminC']),
        _numberText(item, ['vitaminDUg', 'vitaminD']),
        _numberText(item, ['vitaminEMg', 'vitaminE']),
        _numberText(item, ['vitaminKUg', 'vitaminK']),
        _numberText(item, ['vitaminB6Mg', 'vitaminB6']),
        _numberText(item, ['vitaminB12Ug', 'vitaminB12']),
        _numberText(item, ['folateDfeUg', 'folateDfe']),
        _numberText(item, ['servingSize']),
        _numberText(item, ['numberOfServings']),
      ];
      buffer.writeln(row.map(_escape).join(','));
    }

    return buffer.toString();
  }

  String _date(Map<String, dynamic> item) {
    final raw = _string(item, ['loggedAt', 'LoggedAt', 'loggedOn', 'date']);
    return raw.length >= 10 ? raw.substring(0, 10) : raw;
  }

  String _foodName(Map<String, dynamic> item) {
    final direct = _string(item, ['foodName', 'FoodName', 'description']);
    if (direct.isNotEmpty) return direct;
    final food = item['food'];
    if (food is Map<String, dynamic>) {
      final description =
          food['description'] ?? food['foodName'] ?? food['name'];
      if (description is String) return description;
    }
    return '';
  }

  String _numberText(Map<String, dynamic> item, List<String> keys) {
    for (final key in keys) {
      final value = item[key];
      if (value is num) return value.toStringAsFixed(value % 1 == 0 ? 0 : 2);
      if (value is String && value.trim().isNotEmpty) return value.trim();
    }
    return '0';
  }

  String _string(Map<String, dynamic> item, List<String> keys) {
    for (final key in keys) {
      final value = item[key];
      if (value != null) return value.toString();
    }
    return '';
  }

  String _escape(String value) {
    final escaped = value.replaceAll('"', '""');
    if (escaped.contains(',') ||
        escaped.contains('\n') ||
        escaped.contains('\r') ||
        escaped.contains('"')) {
      return '"$escaped"';
    }
    return escaped;
  }
}
