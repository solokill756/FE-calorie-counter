import 'dart:convert';
import 'package:caloriecounter/src/modules/auth/data/models/local_user_identity.dart';
import 'package:caloriecounter/src/modules/auth/data/models/user_profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

import '../.././../common/extensions/optional_x.dart';

class _Keys {
  static const lang = 'lang';
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
  static const deviceId = 'device_id';
  static const pushToken = 'push_token';
  static const ratingShown = 'rating_shown';
  static const logSuccessCount = 'log_success_count';
  static const lastRatingPromptLogCount = 'last_rating_prompt_log_count';
  static const aiUsageCount = 'ai_usage_count';
  static const lastRatingPromptAiCount = 'last_rating_prompt_ai_count';
  static const userID = 'user_id';
  static const userProfile = 'user_profile';
  static const isProfileComplete = 'is_profile_complete';
  static const autoCreatePlanRecipes = 'auto_create_plan_recipes';
}

class Storage {
  static late final SharedPreferences _prefs;
  static late final RxSharedPreferences _rxPrefs;

  static const _storage = FlutterSecureStorage();

  static setup() async {
    _prefs = await SharedPreferences.getInstance();

    /// A shared preference wrapper providing [Stream] for listening updates
    /// from shared preference by key
    _rxPrefs = RxSharedPreferences(
      _prefs,
      // disable logging when running in release mode.
      kReleaseMode ? null : const RxSharedPreferencesDefaultLogger(),
    );
    await migrateLegacyUserProfileIfNeeded();
  }

  static T? _get<T>(String key) => _prefs.get(key).asOrNull<T>();

  /// set value to shared preference by [key].
  /// If you want the updated value to be notified for stream subscriptions
  /// created by [RxSharedPreferences], please set [notify] as `true`
  static Future<void> _set<T>(String key, T? val, {bool notify = false}) {
    if (val == null) {
      _rxPrefs.remove(key);
      return _prefs.remove(key);
    }
    if (val is bool) {
      return notify ? _rxPrefs.setBool(key, val) : _prefs.setBool(key, val);
    }
    if (val is double) {
      return notify ? _rxPrefs.setDouble(key, val) : _prefs.setDouble(key, val);
    }
    if (val is int) {
      return notify ? _rxPrefs.setInt(key, val) : _prefs.setInt(key, val);
    }
    if (val is String) {
      return notify ? _rxPrefs.setString(key, val) : _prefs.setString(key, val);
    }
    if (val is List<String>) {
      return notify
          ? _rxPrefs.setStringList(key, val)
          : _prefs.setStringList(key, val);
    }
    if (val is LocalUserIdentity) {
      final jsonString = jsonEncode(val.toJson());
      return notify
          ? _rxPrefs.setString(key, jsonString)
          : _prefs.setString(key, jsonString);
    }
    if (val is UserProfileModel) {
      final jsonString = jsonEncode(val.toJson());
      return notify
          ? _rxPrefs.setString(key, jsonString)
          : _prefs.setString(key, jsonString);
    }
    throw Exception('Type not supported!');
  }

  static Future<String?> _getSecure(String key) => _storage.read(key: key);

  static Future<void> _setSecure(String key, String? val) =>
      _storage.write(key: key, value: val);

  static String? get lang => _get(_Keys.lang);

  static Future setLang(String? val) => _set(_Keys.lang, val);

  static Future<String?> get accessToken => _getSecure(_Keys.accessToken);

  static Future setAccessToken(String? val) =>
      _setSecure(_Keys.accessToken, val);

  static Future<void> removeAccessToken() =>
      _storage.delete(key: _Keys.accessToken);

  static Future<String?> get refreshToken => _getSecure(_Keys.refreshToken);

  static Future setRefreshToken(String? val) =>
      _setSecure(_Keys.refreshToken, val);

  static Future<void> removeRefreshToken() =>
      _storage.delete(key: _Keys.refreshToken);
  static Future setDeviceId(String? val) => _set(_Keys.deviceId, val);

  static String? get pushToken => _get(_Keys.pushToken);

  static Future setPushToken(String? val) => _set(_Keys.pushToken, val);

  static Future setRatingShown(bool val) => _set(_Keys.ratingShown, val);

  static bool? get ratingShown => _get(_Keys.ratingShown);

  static Future setLogSuccessCount(int val) => _set(_Keys.logSuccessCount, val);

  static int get logSuccessCount => _get(_Keys.logSuccessCount) ?? 0;

  static Future setLastRatingPromptLogCount(int val) =>
      _set(_Keys.lastRatingPromptLogCount, val);

  static int? get lastRatingPromptLogCount =>
      _get(_Keys.lastRatingPromptLogCount);

  static Future setAiUsageCount(int val) => _set(_Keys.aiUsageCount, val);

  static int get aiUsageCount => _get(_Keys.aiUsageCount) ?? 0;

  static Future setLastRatingPromptAiCount(int val) =>
      _set(_Keys.lastRatingPromptAiCount, val);

  static int? get lastRatingPromptAiCount =>
      _get(_Keys.lastRatingPromptAiCount);

  static Future setUserID(int? val) => _set(_Keys.userID, val);

  static int? get userID => _get(_Keys.userID);

  static Future setUserIdentity(LocalUserIdentity? val) =>
      _set(_Keys.userProfile, val);

  static LocalUserIdentity? get userIdentity {
    final jsonString = _get<String>(_Keys.userProfile);
    if (jsonString == null) return null;

    try {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return LocalUserIdentity.fromJson(jsonMap);
    } catch (e) {
      if (kDebugMode) {
        print('Error parsing user identity from storage: $e');
      }
      return null;
    }
  }

  /// Persists identity fields only. Dynamic nutrition data lives in [UserProfileCubit].
  static Future setUserProfile(UserProfileModel? val) async {
    if (val == null) {
      await setUserIdentity(null);
      return;
    }
    await setUserIdentity(
      LocalUserIdentity(
        email: val.email,
        displayName: val.displayName,
        avatarUrl: val.avatarUrl,
        isProfileComplete: val.isProfileComplete,
      ),
    );
    await setIsProfileComplete(val.isProfileComplete);
  }

  /// Identity-only snapshot for unmigrated call sites. Macros/thresholds are empty until cubit loads.
  static UserProfileModel? get userProfile {
    final identity = userIdentity;
    if (identity == null) return null;
    return UserProfileModel(
      displayName: identity.displayName,
      email: identity.email,
      avatarUrl: identity.avatarUrl,
      isProfileComplete: identity.isProfileComplete,
    );
  }

  static Future<void> migrateLegacyUserProfileIfNeeded() async {
    final jsonString = _get<String>(_Keys.userProfile);
    if (jsonString == null) return;
    try {
      final map = jsonDecode(jsonString) as Map<String, dynamic>;
      if (!map.containsKey('dailyCalorieTarget') &&
          !map.containsKey('nutritionalThresholds') &&
          !map.containsKey('macroCarbsG')) {
        return;
      }
      final identity = LocalUserIdentity(
        email: map['email'] as String? ?? '',
        displayName: map['displayName'] as String?,
        avatarUrl: map['avatarUrl'] as String?,
        isProfileComplete: map['isProfileComplete'] as bool? ?? false,
      );
      await setUserIdentity(identity);
      await setIsProfileComplete(identity.isProfileComplete);
    } catch (e) {
      if (kDebugMode) {
        print('Legacy user profile migration failed: $e');
      }
    }
  }

  static Future setIsProfileComplete(bool? val) =>
      _set(_Keys.isProfileComplete, val);
  static bool? get isProfileComplete => _get(_Keys.isProfileComplete);

  static Future setAutoCreatePlanRecipes(bool val) =>
      _set(_Keys.autoCreatePlanRecipes, val);
  static bool get autoCreatePlanRecipes =>
      _get(_Keys.autoCreatePlanRecipes) ?? false;
}
