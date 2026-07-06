import 'package:caloriecounter/src/core/data/local/storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('migrates legacy full user_profile JSON to identity-only', () async {
    SharedPreferences.setMockInitialValues({
      'user_profile': '''
{
  "displayName": "Alice",
  "email": "alice@test.com",
  "avatarUrl": "https://cdn/avatar.jpg",
  "isProfileComplete": true,
  "dailyCalorieTarget": 2000,
  "macroCarbsG": 250,
  "nutritionalThresholds": [{"nutrient":"sugars","maxAmount":50,"unit":"g"}]
}
''',
    });
    await Storage.setup();

    final identity = Storage.userIdentity;
    expect(identity?.displayName, 'Alice');
    expect(identity?.email, 'alice@test.com');
    expect(identity?.isProfileComplete, true);

    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('user_profile') ?? '';
    expect(json.contains('nutritionalThresholds'), isFalse);
    expect(json.contains('macroCarbsG'), isFalse);
  });
}
