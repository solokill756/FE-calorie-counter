import 'package:caloriecounter/src/modules/logfood/data/models/recipe_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('withSourceMetadata tags AI builder recipes', () {
    const draft = RecipeModel(
      id: 0,
      name: 'Test',
      servings: 1,
    );

    final tagged = draft.withSourceMetadata(
      sourceType: RecipeModel.sourceAiRecipeBuilder,
      mealSlot: 'lunch',
      dateKey: '2026-06-17',
    );

    expect(tagged.isAiBuilderRecipe, isTrue);
    expect(tagged.isFridgeAiPlan, isFalse);
    expect(tagged.isAiGenerated, isTrue);
    expect(tagged.mealSlot, 'lunch');
    expect(tagged.toPayload()['sourceType'], 'ai_recipe_builder');
  });
}
