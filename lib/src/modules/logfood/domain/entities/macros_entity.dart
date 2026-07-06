class MacrosEntity {
  const MacrosEntity({
    required this.carbs,
    required this.fat,
    required this.protein,
    required this.calories,
    this.sodiumMg = 0,
    this.fiberG = 0,
    this.saturatedFatG = 0,
    this.cholesterolMg = 0,
    this.sugarsG = 0,
    this.potassiumMg = 0,
  });

  final double carbs;
  final double fat;
  final double protein;
  final double calories;
  final double sodiumMg;
  final double fiberG;
  final double saturatedFatG;
  final double cholesterolMg;
  final double sugarsG;
  final double potassiumMg;

  // Calculate total calories from macros
  double get totalMacroCalories {
    return (carbs * 4.0) + (fat * 9.0) + (protein * 4.0);
  }

  // Calculate percentage of each macro from total macro calories (ensures 100% total)
  double get carbsPercentage {
    final total = totalMacroCalories;
    if (total == 0) return 0;
    return (carbs * 4.0) / total;
  }

  double get fatPercentage {
    final total = totalMacroCalories;
    if (total == 0) return 0;
    return (fat * 9.0) / total;
  }

  double get proteinPercentage {
    final total = totalMacroCalories;
    if (total == 0) return 0;
    return (protein * 4.0) / total;
  }

  // Create a copy with different values
  MacrosEntity copyWith({
    double? carbs,
    double? fat,
    double? protein,
    double? calories,
    double? sodiumMg,
    double? fiberG,
    double? saturatedFatG,
    double? cholesterolMg,
    double? sugarsG,
    double? potassiumMg,
  }) {
    return MacrosEntity(
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      protein: protein ?? this.protein,
      calories: calories ?? this.calories,
      sodiumMg: sodiumMg ?? this.sodiumMg,
      fiberG: fiberG ?? this.fiberG,
      saturatedFatG: saturatedFatG ?? this.saturatedFatG,
      cholesterolMg: cholesterolMg ?? this.cholesterolMg,
      sugarsG: sugarsG ?? this.sugarsG,
      potassiumMg: potassiumMg ?? this.potassiumMg,
    );
  }

  // Create MacrosEntity from FoodEntity with multiplier
  factory MacrosEntity.fromFood({
    required double carbs,
    required double fat,
    required double protein,
    required double calories,
    required double multiplier,
    required double servingSize,
    double sodiumPerServing = 0,
    double fiberPerServing = 0,
    double saturatedFatPerServing = 0,
    double cholesterolPerServing = 0,
    double sugarsPerServing = 0,
    double potassiumPerServing = 0,
  }) {
    final scale = servingSize * multiplier;
    return MacrosEntity(
      carbs: (carbs * scale),
      fat: (fat * scale),
      protein: (protein * scale),
      calories: (calories * scale),
      sodiumMg: sodiumPerServing * scale,
      fiberG: fiberPerServing * scale,
      saturatedFatG: saturatedFatPerServing * scale,
      cholesterolMg: cholesterolPerServing * scale,
      sugarsG: sugarsPerServing * scale,
      potassiumMg: potassiumPerServing * scale,
    );
  }

  /// Sums macro grams and calories across multiple scaled portions.
  factory MacrosEntity.sum(Iterable<MacrosEntity> items) {
    var carbs = 0.0;
    var fat = 0.0;
    var protein = 0.0;
    var calories = 0.0;
    var sodium = 0.0;
    var fiber = 0.0;
    var saturatedFat = 0.0;
    var cholesterol = 0.0;
    var sugars = 0.0;
    var potassium = 0.0;
    for (final m in items) {
      carbs += m.carbs;
      fat += m.fat;
      protein += m.protein;
      calories += m.calories;
      sodium += m.sodiumMg;
      fiber += m.fiberG;
      saturatedFat += m.saturatedFatG;
      cholesterol += m.cholesterolMg;
      sugars += m.sugarsG;
      potassium += m.potassiumMg;
    }
    return MacrosEntity(
      carbs: carbs,
      fat: fat,
      protein: protein,
      calories: calories,
      sodiumMg: sodium,
      fiberG: fiber,
      saturatedFatG: saturatedFat,
      cholesterolMg: cholesterol,
      sugarsG: sugars,
      potassiumMg: potassium,
    );
  }

  @override
  String toString() {
    return 'MacrosEntity(carbs: $carbs, fat: $fat, protein: $protein, calories: $calories, sodiumMg: $sodiumMg, fiberG: $fiberG, saturatedFatG: $saturatedFatG, cholesterolMg: $cholesterolMg, sugarsG: $sugarsG, potassiumMg: $potassiumMg)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MacrosEntity &&
        other.carbs == carbs &&
        other.fat == fat &&
        other.protein == protein &&
        other.calories == calories &&
        other.sodiumMg == sodiumMg &&
        other.fiberG == fiberG &&
        other.saturatedFatG == saturatedFatG &&
        other.cholesterolMg == cholesterolMg &&
        other.sugarsG == sugarsG &&
        other.potassiumMg == potassiumMg;
  }

  @override
  int get hashCode {
    return carbs.hashCode ^
        fat.hashCode ^
        protein.hashCode ^
        calories.hashCode ^
        sodiumMg.hashCode ^
        fiberG.hashCode ^
        saturatedFatG.hashCode ^
        cholesterolMg.hashCode ^
        sugarsG.hashCode ^
        potassiumMg.hashCode;
  }
}
