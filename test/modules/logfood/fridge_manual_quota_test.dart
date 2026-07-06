import 'package:caloriecounter/src/modules/logfood/data/models/fridge_manual_quota_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses generation in-progress status', () {
    final status = FridgeGenerationStatus.fromJson({
      'inProgress': true,
    });
    expect(status.inProgress, isTrue);
  });

  test('defaults inProgress to false when missing', () {
    final status = FridgeGenerationStatus.fromJson({});
    expect(status.inProgress, isFalse);
  });
}
