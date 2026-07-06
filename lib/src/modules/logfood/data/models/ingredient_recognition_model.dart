import '../../helper/log_food_helper.dart';
import 'food_model.dart';

class FoodCandidateModel {
  const FoodCandidateModel({
    required this.foodId,
    required this.foodName,
    required this.brandName,
    required this.servingSize,
    required this.servingUnit,
    required this.calories,
    required this.proteinG,
    required this.totalCarbohydratesG,
    required this.totalFatG,
    required this.sodiumMg,
    required this.isVerified,
    required this.score,
  });

  final int foodId;
  final String foodName;
  final String brandName;
  final double servingSize;
  final String servingUnit;
  final double calories;
  final double proteinG;
  final double totalCarbohydratesG;
  final double totalFatG;
  final double sodiumMg;
  final bool isVerified;
  final double score;

  factory FoodCandidateModel.fromJson(Map<String, dynamic> json) {
    int toInt(dynamic v) => v is int ? v : int.tryParse('$v') ?? 0;
    double toDouble(dynamic v) =>
        v is num ? v.toDouble() : double.tryParse('$v') ?? 0;
    return FoodCandidateModel(
      foodId: toInt(json['foodId']),
      foodName: (json['foodName'] ?? '').toString(),
      brandName: (json['brandName'] ?? '').toString(),
      servingSize: toDouble(json['servingSize']),
      servingUnit: (json['servingUnit'] ?? 'g').toString(),
      calories: toDouble(json['calories']),
      proteinG: toDouble(json['proteinG']),
      totalCarbohydratesG: toDouble(json['totalCarbohydratesG']),
      totalFatG: toDouble(json['totalFatG']),
      sodiumMg: toDouble(json['sodiumMg']),
      isVerified: json['isVerified'] == true,
      score: toDouble(json['score']),
    );
  }

  FoodModel toFoodModel() {
    return LogFoodHelper.mapApiFoodToModel({
      'id': foodId,
      'foodName': foodName,
      'description': foodName,
      'brandName': brandName,
      'servingSize': servingSize,
      'servingUnit': servingUnit,
      'servingsPerContainer': 1,
      'calories': calories,
      'proteinG': proteinG,
      'totalCarbohydratesG': totalCarbohydratesG,
      'totalFatG': totalFatG,
      'sodiumMg': sodiumMg,
      'isVerified': isVerified,
    });
  }
}

class DetectedIngredientModel {
  const DetectedIngredientModel({
    required this.clientIngredientId,
    required this.detectedName,
    required this.confidence,
    required this.candidates,
    this.notes,
  });

  final String clientIngredientId;
  final String detectedName;
  final double confidence;
  final String? notes;
  final List<FoodCandidateModel> candidates;

  factory DetectedIngredientModel.fromJson(Map<String, dynamic> json) {
    double toDouble(dynamic v) =>
        v is num ? v.toDouble() : double.tryParse('$v') ?? 0;
    return DetectedIngredientModel(
      clientIngredientId: (json['clientIngredientId'] ?? '').toString(),
      detectedName: (json['detectedName'] ?? '').toString(),
      confidence: toDouble(json['confidence']),
      notes: json['notes']?.toString(),
      candidates: ((json['candidates'] as List?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(FoodCandidateModel.fromJson)
          .toList(),
    );
  }
}

class IngredientRecognitionResultModel {
  const IngredientRecognitionResultModel({
    this.imageUrl,
    required this.ingredients,
  });

  final String? imageUrl;
  final List<DetectedIngredientModel> ingredients;

  factory IngredientRecognitionResultModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return IngredientRecognitionResultModel(
      imageUrl: json['imageUrl']?.toString(),
      ingredients: ((json['ingredients'] as List?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(DetectedIngredientModel.fromJson)
          .toList(),
    );
  }
}

