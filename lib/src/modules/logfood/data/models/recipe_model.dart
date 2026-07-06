import 'food_model.dart';

class RecipeIngredientModel {
  const RecipeIngredientModel({
    this.id,
    this.foodId,
    required this.name,
    required this.quantity,
    required this.unit,
    this.calories = 0,
    this.protein = 0,
    this.carbs = 0,
    this.fat = 0,
    this.fiber = 0,
    this.sodium = 0,
    this.sugar = 0,
    this.saturatedFat = 0,
    this.cholesterol = 0,
    this.potassium = 0,
    this.micronutrients = const {},
    this.order = 0,
  });

  final int? id;
  final int? foodId;
  final String name;
  final double quantity;
  final String unit;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double fiber;
  final double sodium;
  final double sugar;
  final double saturatedFat;
  final double cholesterol;
  final double potassium;
  final Map<String, double> micronutrients;
  final int order;

  factory RecipeIngredientModel.fromJson(Map<String, dynamic> json) {
    double toDouble(dynamic v) =>
        v is num ? v.toDouble() : double.tryParse('$v') ?? 0;
    int toInt(dynamic v) => v is int ? v : int.tryParse('$v') ?? 0;
    return RecipeIngredientModel(
      id: json['id'] as int?,
      foodId: (json['foodId'] ?? json['food_id']) == null
          ? null
          : toInt(json['foodId'] ?? json['food_id']),
      name: (json['name'] ?? '').toString(),
      quantity: toDouble(json['quantity']),
      unit: (json['unit'] ?? '').toString(),
      calories: toDouble(json['calories']),
      protein: toDouble(json['protein']),
      carbs: toDouble(json['carbs']),
      fat: toDouble(json['fat']),
      fiber: toDouble(json['fiber']),
      sodium: toDouble(json['sodium']),
      sugar: toDouble(json['sugar']),
      saturatedFat: toDouble(json['saturatedFat']),
      cholesterol: toDouble(json['cholesterol']),
      potassium: toDouble(json['potassium']),
      micronutrients: {
        for (final field in AppNutrients.micronutrients)
          if (json[field.apiKey] != null || json[field.key] != null)
            field.key: toDouble(json[field.apiKey] ?? json[field.key]),
      },
      order: toInt(json['order']),
    );
  }

  Map<String, dynamic> toJson() => {
    if (foodId != null) 'foodId': foodId,
    'name': name,
    'quantity': quantity,
    'unit': unit,
    'calories': calories,
    'protein': protein,
    'carbs': carbs,
    'fat': fat,
    'fiber': fiber,
    'sodium': sodium,
    'sugar': sugar,
    'saturatedFat': saturatedFat,
    'cholesterol': cholesterol,
    'potassium': potassium,
    for (final field in AppNutrients.micronutrients)
      field.apiKey: micronutrients[field.key] ?? 0,
  };
}

class RecipeStepModel {
  const RecipeStepModel({
    this.id,
    required this.order,
    required this.instruction,
    this.duration,
    this.tips,
  });

  final int? id;
  final int order;
  final String instruction;
  final int? duration;
  final String? tips;

  factory RecipeStepModel.fromJson(Map<String, dynamic> json) {
    int toInt(dynamic v) => v is int ? v : int.tryParse('$v') ?? 0;
    return RecipeStepModel(
      id: json['id'] as int?,
      order: toInt(json['order']),
      instruction: (json['instruction'] ?? '').toString(),
      duration: json['duration'] == null ? null : toInt(json['duration']),
      tips: json['tips']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'order': order,
    'instruction': instruction,
    if (duration != null) 'duration': duration,
    if (tips != null && tips!.trim().isNotEmpty) 'tips': tips!.trim(),
  };
}

class RecipeModel {
  const RecipeModel({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.shareWith = 1,
    this.servings = 1,
    this.prepMinutes = 0,
    this.cookMinutes = 0,
    this.difficulty = 'easy',
    this.tags = const [],
    this.ingredients = const [],
    this.steps = const [],
    this.sourceType,
    this.dateKey,
    this.mealSlot,
    this.isVerified = false,
    this.score,
    this.warnings = const [],
  });

  final int id;
  final String name;
  final String? description;
  final String? imageUrl;
  final int shareWith;
  final int servings;
  final int prepMinutes;
  final int cookMinutes;
  final String difficulty;
  final List<String> tags;
  final List<RecipeIngredientModel> ingredients;
  final List<RecipeStepModel> steps;
  final String? sourceType;
  final String? dateKey;
  final String? mealSlot;
  final bool isVerified;
  final double? score;
  final List<String> warnings;

  bool get isFridgeAiPlan => sourceType == sourceFridgeAiDailyPlan;

  static const sourceFridgeAiDailyPlan = 'fridge_ai_daily_plan';
  static const sourceAiRecipeBuilder = 'ai_recipe_builder';

  bool get isAiBuilderRecipe => sourceType == sourceAiRecipeBuilder;

  bool get isAiGenerated => isFridgeAiPlan || isAiBuilderRecipe;

  RecipeModel withSourceMetadata({
    String? sourceType,
    String? mealSlot,
    String? dateKey,
  }) {
    return RecipeModel(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      shareWith: shareWith,
      servings: servings,
      prepMinutes: prepMinutes,
      cookMinutes: cookMinutes,
      difficulty: difficulty,
      tags: tags,
      ingredients: ingredients,
      steps: steps,
      sourceType: sourceType ?? this.sourceType,
      dateKey: dateKey ?? this.dateKey,
      mealSlot: mealSlot ?? this.mealSlot,
      isVerified: isVerified,
      score: score,
      warnings: warnings,
    );
  }

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    int toInt(dynamic v) => v is int ? v : int.tryParse('$v') ?? 0;
    return RecipeModel(
      id: toInt(json['id']),
      name: (json['name'] ?? '').toString(),
      description: json['description']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      shareWith: toInt(json['shareWith'] ?? 1),
      servings: toInt(json['servings'] ?? 1),
      prepMinutes: toInt(
        json['prepMinutes'] ??
            json['preparationTime'] ??
            json['prepTimeMinutes'] ??
            0,
      ),
      cookMinutes: toInt(
        json['cookMinutes'] ??
            json['cookingTime'] ??
            json['cookTimeMinutes'] ??
            0,
      ),
      difficulty: (json['difficulty'] ?? 'easy').toString(),
      tags: ((json['tags'] as List?) ?? const []).map((e) => '$e').toList(),
      ingredients: ((json['ingredients'] as List?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(RecipeIngredientModel.fromJson)
          .toList(),
      steps: ((json['steps'] as List?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(RecipeStepModel.fromJson)
          .toList(),
      sourceType: json['sourceType']?.toString(),
      dateKey: json['dateKey']?.toString(),
      mealSlot: json['mealSlot']?.toString(),
      isVerified:
          (json['isVerified'] as bool?) ?? (json['is_verified'] as bool?) ?? false,
      score: json['score'] is num
          ? (json['score'] as num).toDouble()
          : double.tryParse('${json['score'] ?? ''}'),
      warnings: ((json['warnings'] as List?) ?? const [])
          .map((e) => '$e')
          .where((e) => e.trim().isNotEmpty)
          .toList(),
    );
  }

  Map<String, dynamic> toPayload() => {
    'name': name,
    if (description != null && description!.trim().isNotEmpty)
      'description': description!.trim(),
    if (imageUrl != null && imageUrl!.trim().isNotEmpty)
      'imageUrl': imageUrl!.trim(),
    'shareWith': shareWith,
    'servings': servings,
    'prepMinutes': prepMinutes,
    'cookMinutes': cookMinutes,
    'difficulty': difficulty,
    'tags': tags,
    'ingredients': ingredients.map((e) => e.toJson()).toList(),
    'steps': steps.map((e) => e.toJson()).toList(),
    if (sourceType != null && sourceType!.trim().isNotEmpty)
      'sourceType': sourceType!.trim(),
    if (dateKey != null && dateKey!.trim().isNotEmpty) 'dateKey': dateKey!.trim(),
    if (mealSlot != null && mealSlot!.trim().isNotEmpty) 'mealSlot': mealSlot!.trim(),
    if (score != null) 'score': score,
    if (warnings.isNotEmpty) 'warnings': warnings,
  };

  /// Appends readable sections from generate API metadata (Vietnamese labels for users).
  static String? _mergeGenerateMetaIntoDescription(
    String? description, {
    String? recommendation,
    List<String>? safetyWarnings,
    List<String>? generationWarnings,
  }) {
    final rec = recommendation?.trim() ?? '';
    final safe = (safetyWarnings ?? const [])
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final gen = (generationWarnings ?? const [])
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    if (rec.isEmpty && safe.isEmpty && gen.isEmpty) {
      return description;
    }

    final b = StringBuffer();
    final base = description?.trim();
    if (base != null && base.isNotEmpty) {
      b.writeln(base);
      b.writeln();
    }

    b.writeln('────────────────────────────');
    b.writeln();

    if (rec.isNotEmpty) {
      b.writeln('Assistant Recommendations');
      b.writeln();
      b.writeln(rec);
      b.writeln();
    }
    if (safe.isNotEmpty) {
      b.writeln('Safety Warnings');
      b.writeln();
      for (final s in safe) {
        b.writeln('• $s');
      }
      b.writeln();
    }
    if (gen.isNotEmpty) {
      b.writeln('Recipe Generation Notices');
      b.writeln();
      for (final s in gen) {
        b.writeln('• $s');
      }
    }

    return b.toString().trimRight();
  }

  factory RecipeModel.fromRecipeBuilderJson(
    Map<String, dynamic> json, {
    String? recommendation,
    List<String>? safetyWarnings,
    List<String>? generationWarnings,
    double? score,
    List<String>? warnings,
  }) {
    int toInt(dynamic v) => v is int ? v : int.tryParse('$v') ?? 0;
    double toD(dynamic v) {
      if (v == null) return 0;
      if (v is num) return v.toDouble();
      return double.tryParse('$v') ?? 0;
    }

    var order = 0;
    final ingredients = ((json['ingredients'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map((e) {
          order += 1;
          final hasAmount =
              e.containsKey('amount') &&
              e['amount'] != null &&
              toD(e['amount']) > 0;
          final hasAg =
              e.containsKey('amount_g') &&
              e['amount_g'] != null &&
              toD(e['amount_g']) > 0;
          final double qty;
          if (hasAmount) {
            qty = toD(e['amount']);
          } else if (hasAg) {
            final servRaw = toD(e['servingSizeG'] ?? e['serving_size_g']);
            final serv = servRaw > 0 ? servRaw : 100.0;
            qty = toD(e['amount_g']) / serv;
          } else {
            qty = 0;
          }
          final fid = e['foodId'] ?? e['food_id'];
          return RecipeIngredientModel(
            foodId: fid == null ? null : toInt(fid),
            name: (e['name'] ?? '').toString(),
            quantity: qty,
            unit: (e['unit'] ?? 'g').toString(),
            order: order - 1,
            calories: toD(e['calories']),
            protein: toD(e['protein']),
            carbs: toD(e['carbs']),
            fat: toD(e['fat']),
            fiber: toD(e['fiber']),
            sodium: toD(e['sodium']),
            sugar: toD(e['sugar']),
            saturatedFat: toD(e['saturatedFat']),
            cholesterol: toD(e['cholesterol']),
            potassium: toD(e['potassium']),
            micronutrients: {
              for (final field in AppNutrients.micronutrients)
                if (e[field.apiKey] != null || e[field.key] != null)
                  field.key: toD(e[field.apiKey] ?? e[field.key]),
            },
          );
        })
        .toList();

    final steps = ((json['steps'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(
          (s) => RecipeStepModel(
            order: toInt(s['order']),
            instruction: (s['instruction'] ?? '').toString(),
            duration: s['duration'] == null ? null : toInt(s['duration']),
            tips: s['tips']?.toString(),
          ),
        )
        .toList();

    final diff = (json['difficulty'] ?? 'easy').toString().toLowerCase();
    final safeDiff = ['easy', 'medium', 'hard'].contains(diff) ? diff : 'easy';
    final servings = toInt(json['servings']);
    final n = json['nutritionPerServing'];
    String? desc = json['description']?.toString();
    if (n is Map<String, dynamic>) {
      final cal = n['calories'];
      final p = n['protein'];
      final c = n['carbs'];
      final f = n['fat'];
      if (cal != null || p != null || c != null || f != null) {
        final line =
            'Per serving (enriched): ${cal ?? '—'} kcal, P ${p ?? '—'}g, C ${c ?? '—'}g, F ${f ?? '—'}g.';
        desc = desc == null || desc.isEmpty ? line : '$desc\n$line';
      }
    }

    desc = RecipeModel._mergeGenerateMetaIntoDescription(
      desc,
      recommendation: recommendation,
      safetyWarnings: safetyWarnings,
      generationWarnings: generationWarnings,
    );

    return RecipeModel(
      id: 0,
      name: (json['name'] ?? 'Suggested recipe').toString(),
      description: desc,
      servings: servings <= 0 ? 1 : servings,
      prepMinutes: toInt(json['preparationTime']),
      cookMinutes: toInt(json['cookingTime']),
      difficulty: safeDiff,
      tags: const [],
      ingredients: ingredients,
      steps: steps.isEmpty
          ? [
              const RecipeStepModel(
                order: 1,
                instruction: 'Combine ingredients and cook until done.',
              ),
            ]
          : steps,
      sourceType: json['sourceType']?.toString(),
      dateKey: json['dateKey']?.toString(),
      mealSlot: json['mealSlot']?.toString(),
      isVerified:
          (json['isVerified'] as bool?) ?? (json['is_verified'] as bool?) ?? false,
      score: score,
      warnings: warnings ?? const [],
    );
  }
}
