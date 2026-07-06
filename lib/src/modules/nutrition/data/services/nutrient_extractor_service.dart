import 'package:injectable/injectable.dart';
import '../../../logfood/data/models/food_model.dart';

/// Service responsible for extracting specific nutrients from food models
abstract class NutrientExtractorService {
  /// Extract a specific nutrient value from a food model
  double extract(FoodModel foodModel, String type);

  /// Get all nutrients from a food model
  Map<String, double> extractAll(FoodModel foodModel);

  /// Check if a nutrient type is valid
  bool isValidNutrientType(String type);

  /// Get all supported nutrient types
  List<String> getSupportedNutrients();
}

@LazySingleton(as: NutrientExtractorService)
class NutrientExtractorServiceImpl implements NutrientExtractorService {
  @override
  double extract(FoodModel foodModel, String type) {
    return _extractNutrient(foodModel, type);
  }

  @override
  Map<String, double> extractAll(FoodModel foodModel) {
    return {
      'calories': foodModel.calories,
      'carbohydrates': foodModel.carbs ?? 0.0,
      'fat': foodModel.fat ?? 0.0,
      'protein': foodModel.protein ?? 0.0,
      'fiber': foodModel.nutrients[NutrientKeys.fiberG] ?? 0.0,
      'sugar': foodModel.nutrients[NutrientKeys.sugarsG] ?? 0.0,
      'saturatedFat': foodModel.nutrients[NutrientKeys.fatSaturatedG] ?? 0.0,
      'cholesterol': foodModel.nutrients[NutrientKeys.cholesterolMg] ?? 0.0,
      'sodium': foodModel.nutrients[NutrientKeys.sodiumMg] ?? 0.0,
      'potassium': foodModel.nutrients[NutrientKeys.potassiumMg] ?? 0.0,
      'calcium': foodModel.nutrients[NutrientKeys.calciumMg] ?? 0.0,
      'iron': foodModel.nutrients[NutrientKeys.ironMg] ?? 0.0,
      'magnesium': foodModel.nutrients[NutrientKeys.magnesiumMg] ?? 0.0,
      'phosphorus': foodModel.nutrients[NutrientKeys.phosphorusMg] ?? 0.0,
      'zinc': foodModel.nutrients[NutrientKeys.zincMg] ?? 0.0,
      'vitaminA': foodModel.nutrients[NutrientKeys.vitaminAUg] ?? 0.0,
      'vitaminC': foodModel.nutrients[NutrientKeys.vitaminCMg] ?? 0.0,
      'vitaminD': foodModel.nutrients[NutrientKeys.vitaminDUg] ?? 0.0,
      'vitaminE': foodModel.nutrients[NutrientKeys.vitaminEMg] ?? 0.0,
      'vitaminK': foodModel.nutrients[NutrientKeys.vitaminKUg] ?? 0.0,
      'vitaminB6': foodModel.nutrients[NutrientKeys.vitaminB6Mg] ?? 0.0,
      'vitaminB12': foodModel.nutrients[NutrientKeys.vitaminB12Ug] ?? 0.0,
      'folateDfe': foodModel.nutrients[NutrientKeys.folateDfeUg] ?? 0.0,
    };
  }

  @override
  bool isValidNutrientType(String type) {
    return getSupportedNutrients().contains(_normalize(type));
  }

  @override
  List<String> getSupportedNutrients() {
    return [
      'calories',
      'carbohydrates',
      'fat',
      'protein',
      'fiber',
      'sugar',
      'saturatedfat',
      'cholesterol',
      'sodium',
      'potassium',
      'calcium',
      'iron',
      'magnesium',
      'phosphorus',
      'zinc',
      'vitamina',
      'vitaminc',
      'vitamind',
      'vitamine',
      'vitamink',
      'vitaminb6',
      'vitaminb12',
      'folatedfe',
    ];
  }

  double _extractNutrient(FoodModel foodModel, String type) {
    switch (_normalize(type)) {
      case 'calories':
        return foodModel.calories;
      case 'carbohydrates':
        return foodModel.carbs ?? 0.0;
      case 'fat':
        return foodModel.fat ?? 0.0;
      case 'protein':
        return foodModel.protein ?? 0.0;
      case 'fiber':
        return foodModel.nutrients[NutrientKeys.fiberG] ?? 0.0;
      case 'sugar':
      case 'sugars':
        return foodModel.nutrients[NutrientKeys.sugarsG] ?? 0.0;
      case 'saturatedfat':
        return foodModel.nutrients[NutrientKeys.fatSaturatedG] ?? 0.0;
      case 'cholesterol':
        return foodModel.nutrients[NutrientKeys.cholesterolMg] ?? 0.0;
      case 'sodium':
        return foodModel.nutrients[NutrientKeys.sodiumMg] ?? 0.0;
      case 'potassium':
        return foodModel.nutrients[NutrientKeys.potassiumMg] ?? 0.0;
      case 'calcium':
        return foodModel.nutrients[NutrientKeys.calciumMg] ?? 0.0;
      case 'iron':
        return foodModel.nutrients[NutrientKeys.ironMg] ?? 0.0;
      case 'magnesium':
        return foodModel.nutrients[NutrientKeys.magnesiumMg] ?? 0.0;
      case 'phosphorus':
        return foodModel.nutrients[NutrientKeys.phosphorusMg] ?? 0.0;
      case 'zinc':
        return foodModel.nutrients[NutrientKeys.zincMg] ?? 0.0;
      case 'vitamina':
        return foodModel.nutrients[NutrientKeys.vitaminAUg] ?? 0.0;
      case 'vitaminc':
        return foodModel.nutrients[NutrientKeys.vitaminCMg] ?? 0.0;
      case 'vitamind':
        return foodModel.nutrients[NutrientKeys.vitaminDUg] ?? 0.0;
      case 'vitamine':
        return foodModel.nutrients[NutrientKeys.vitaminEMg] ?? 0.0;
      case 'vitamink':
        return foodModel.nutrients[NutrientKeys.vitaminKUg] ?? 0.0;
      case 'vitaminb6':
        return foodModel.nutrients[NutrientKeys.vitaminB6Mg] ?? 0.0;
      case 'vitaminb12':
        return foodModel.nutrients[NutrientKeys.vitaminB12Ug] ?? 0.0;
      case 'folate':
      case 'folatedfe':
        return foodModel.nutrients[NutrientKeys.folateDfeUg] ?? 0.0;
      default:
        return 0.0;
    }
  }

  String _normalize(String type) =>
      type.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
}
