import 'package:caloriecounter/src/core/data/remote/base/api_error.dart';
import 'package:caloriecounter/src/modules/auth/data/auth_me_json_mapper.dart';
import 'package:caloriecounter/src/modules/auth/data/models/user_profile_model.dart';
import 'package:caloriecounter/src/modules/more/presentation/pages/edit_health_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const profile = UserProfileModel(
    age: 36,
    gender: 'Male',
    heightCm: 173.5,
    conditionTypes: ['legacy-condition'],
    barriers: ['Legacy, allergy'],
    mealSplits: {'breakfast': 20, 'lunch': 35, 'dinner': 30, 'snack': 15},
  );

  Future<void> openEditor(
    WidgetTester tester,
    Future<ApiError?> Function(Map<String, Object?>) onSave,
  ) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        builder: (_, _) => MaterialApp(
          home: EditHealthProfilePage(profile: profile, onSave: onSave),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> tapVisible(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  test(
    'maps effective meal percentages and preserves an older gender value',
    () {
      final mapped = userProfileFromAuthMeJson({
        'gender': 'another-value',
        'mealSplits': profile.mealSplits,
      });
      expect(mapped.gender, 'another-value');
      expect(mapped.mealSplits, profile.mealSplits);
      expect(
        UserProfileModel.fromJson(mapped.toJson()).mealSplits,
        profile.mealSplits,
      );
    },
  );

  testWidgets('changing a condition preserves saved legacy entries', (
    tester,
  ) async {
    Map<String, Object?>? submitted;
    await openEditor(tester, (changes) async {
      submitted = changes;
      return null;
    });

    await tapVisible(tester, find.text('Diabetes'));
    await tapVisible(tester, find.text('Save'));

    expect(submitted, {
      'conditionTypes': ['legacy-condition', 'diabetes'],
    });
  });

  testWidgets('reset sends an explicit null meal split', (tester) async {
    Map<String, Object?>? submitted;
    await openEditor(tester, (changes) async {
      submitted = changes;
      return null;
    });

    await tapVisible(tester, find.text('Reset to defaults'));
    await tapVisible(tester, find.text('Save'));

    expect(submitted, {'mealSplits': null});
  });

  testWidgets('an invalid meal total prevents saving', (tester) async {
    var saved = false;
    await openEditor(tester, (_) async {
      saved = true;
      return null;
    });

    final breakfast = find.widgetWithText(TextFormField, 'Breakfast');
    await tester.ensureVisible(breakfast);
    await tester.enterText(breakfast, '50');
    await tester.pumpAndSettle();
    await tapVisible(tester, find.text('Save'));

    expect(saved, isFalse);
    expect(find.text('Meal percentages must add up to 100%.'), findsOneWidget);
  });
  testWidgets('saving unchanged values skips the request', (tester) async {
    var saved = false;
    await openEditor(tester, (_) async {
      saved = true;
      return null;
    });

    await tapVisible(tester, find.text('Save'));

    expect(saved, isFalse);
  });

  testWidgets('custom allergies preserve saved values containing commas', (
    tester,
  ) async {
    Map<String, Object?>? submitted;
    await openEditor(tester, (changes) async {
      submitted = changes;
      return null;
    });

    final field = find.widgetWithText(TextFormField, 'Add other allergies');
    await tester.ensureVisible(field);
    await tester.enterText(field, ' kiwi, lentils ');
    await tester.pumpAndSettle();
    await tapVisible(tester, find.text('Save'));

    expect(submitted, {
      'allergies': ['Legacy, allergy', 'kiwi', 'lentils'],
    });
  });

  testWidgets('failed saves show the server error and retain the draft', (
    tester,
  ) async {
    final submissions = <Map<String, Object?>>[];
    await openEditor(tester, (changes) async {
      submissions.add(changes);
      return ApiError(422, 'Unable to update health profile');
    });

    await tapVisible(tester, find.text('Reset to defaults'));
    await tapVisible(tester, find.text('Save'));

    expect(find.text('Unable to update health profile'), findsOneWidget);
    await tapVisible(tester, find.text('Save'));
    expect(submissions, [
      {'mealSplits': null},
      {'mealSplits': null},
    ]);
  });
}
