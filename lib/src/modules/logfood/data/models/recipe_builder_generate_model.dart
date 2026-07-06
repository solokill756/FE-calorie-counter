import 'recipe_model.dart';

class RecipeBuilderGenerateResult {
  const RecipeBuilderGenerateResult({
    required this.recipeDraft,
    required this.recommendation,
    required this.safetyWarnings,
    required this.generationWarnings,
    this.budgetStatus,
    this.score,
    this.scoreWarnings = const [],
  });

  final RecipeModel recipeDraft;
  final String recommendation;
  final List<String> safetyWarnings;
  final List<String> generationWarnings;
  final String? budgetStatus;
  final double? score;
  final List<String> scoreWarnings;

  factory RecipeBuilderGenerateResult.fromJson(Map<String, dynamic> json) {
    final recipeRaw = json['recipe'];
    final recipeMap =
        recipeRaw is Map<String, dynamic> ? recipeRaw : <String, dynamic>{};

    List<String> strList(dynamic v) {
      if (v is! List) return const [];
      return v.map((e) => '$e').toList();
    }

    double? parseScore(dynamic v) {
      if (v is num) return v.toDouble();
      return double.tryParse('${v ?? ''}');
    }

    final recommendation = (json['recommendation'] ?? '').toString();
    final safetyWarnings = strList(json['safetyWarnings']);
    final generationWarnings = strList(json['generationWarnings']);
    final scoreWarnings = strList(json['scoreWarnings']);
    final score = parseScore(json['score']);

    final mergedWarnings = <String>[
      ...safetyWarnings,
      ...generationWarnings,
      ...scoreWarnings,
    ];

    return RecipeBuilderGenerateResult(
      recipeDraft: RecipeModel.fromRecipeBuilderJson(
        recipeMap,
        recommendation: recommendation,
        safetyWarnings: safetyWarnings,
        generationWarnings: generationWarnings,
        score: score,
        warnings: mergedWarnings,
      ),
      recommendation: recommendation,
      safetyWarnings: safetyWarnings,
      generationWarnings: generationWarnings,
      budgetStatus: json['budgetStatus']?.toString(),
      score: score,
      scoreWarnings: scoreWarnings,
    );
  }
}
