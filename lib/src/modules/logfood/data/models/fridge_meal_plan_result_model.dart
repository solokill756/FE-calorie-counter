class FridgeMealPlanSlotResult {
  const FridgeMealPlanSlotResult({
    required this.mealSlot,
    required this.status,
    this.reason,
    this.recommendation = '',
    this.safetyWarnings = const [],
    this.generationWarnings = const [],
  });

  final String mealSlot;
  final String status;
  final String? reason;
  final String recommendation;
  final List<String> safetyWarnings;
  final List<String> generationWarnings;

  factory FridgeMealPlanSlotResult.fromJson(Map<String, dynamic> json) {
    List<String> strList(dynamic value) {
      if (value is! List) return const [];
      return value.map((item) => '$item').toList();
    }

    return FridgeMealPlanSlotResult(
      mealSlot: (json['mealSlot'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      reason: json['reason']?.toString(),
      recommendation: (json['recommendation'] ?? '').toString(),
      safetyWarnings: strList(json['safetyWarnings']),
      generationWarnings: strList(json['generationWarnings']),
    );
  }
}

class FridgeMealPlanResult {
  const FridgeMealPlanResult({
    required this.dateKey,
    required this.sourceType,
    required this.slots,
  });

  final String dateKey;
  final String sourceType;
  final List<FridgeMealPlanSlotResult> slots;

  int get createdCount =>
      slots.where((s) => s.status == 'created').length;

  int get existingCount =>
      slots.where((s) => s.status == 'existing').length;

  int get skippedCount =>
      slots.where((s) => s.status == 'skipped').length;

  List<String> get allSafetyWarnings => slots
      .expand((slot) => slot.safetyWarnings)
      .where((warning) => warning.trim().isNotEmpty)
      .toList();

  List<String> get allGenerationWarnings => slots
      .expand((slot) => slot.generationWarnings)
      .where((warning) => warning.trim().isNotEmpty)
      .toList();

  String get summaryMessage {
    final parts = <String>[];
    if (createdCount > 0) {
      parts.add(
        createdCount == 1 ? '1 new recipe' : '$createdCount new recipes',
      );
    }
    if (existingCount > 0) {
      parts.add(
        existingCount == 1 ? '1 existing' : '$existingCount existing',
      );
    }
    if (skippedCount > 0) {
      parts.add(
        skippedCount == 1 ? '1 skipped' : '$skippedCount skipped',
      );
    }
    if (parts.isEmpty) return 'Fridge plan finished with no changes.';
    return 'Fridge plan ready: ${parts.join(', ')}.';
  }

  factory FridgeMealPlanResult.fromJson(Map<String, dynamic> json) {
    final slotsRaw = json['slots'];
    final slots = slotsRaw is List
        ? slotsRaw
            .whereType<Map<String, dynamic>>()
            .map(FridgeMealPlanSlotResult.fromJson)
            .toList()
        : const <FridgeMealPlanSlotResult>[];

    return FridgeMealPlanResult(
      dateKey: (json['dateKey'] ?? json['date'] ?? '').toString(),
      sourceType: (json['sourceType'] ?? '').toString(),
      slots: slots,
    );
  }
}
