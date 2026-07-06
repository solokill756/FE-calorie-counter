class MealSummaryModel {
  const MealSummaryModel({
    required this.id,
    required this.name,
    this.directions,
    this.imageUrl,
    this.createdAt,
    this.calories = 0,
    this.carbs = 0,
    this.fat = 0,
    this.protein = 0,
  });

  final int id;
  final String name;
  final String? directions;
  final String? imageUrl;
  final DateTime? createdAt;
  final double calories;
  final double carbs;
  final double fat;
  final double protein;
}
