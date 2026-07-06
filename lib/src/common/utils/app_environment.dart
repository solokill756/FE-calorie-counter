import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnvironment {
  static setup() async {
    await dotenv.load(fileName: '.env');
  }

  static final apiUrl = dotenv.env['API_URL'] ?? '';
  static final appStoreId = dotenv.env['APP_STORE_ID'] ?? '';
  static final googlePlayId = dotenv.env['GOOGLE_PLAY_ID'] ?? '';
  // Web Client ID từ Firebase Console → cần thiết để Google trả về idToken
  static final googleServerClientId = dotenv.env['SERVER_CLIENT_ID'] ?? '';
}
