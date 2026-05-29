import 'package:caloriecounter/src/core/data/local/storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await Storage.setup();
  });

  setUp(() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  });

  test('defaults to false when autoCreatePlanRecipes is unset', () {
    expect(Storage.autoCreatePlanRecipes, isFalse);
  });

  test('returns the stored true value when it exists', () async {
    await Storage.setAutoCreatePlanRecipes(true);

    expect(Storage.autoCreatePlanRecipes, isTrue);
  });

  test('returns the stored false value when it exists', () async {
    await Storage.setAutoCreatePlanRecipes(false);

    expect(Storage.autoCreatePlanRecipes, isFalse);
  });
}
