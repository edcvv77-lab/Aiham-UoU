import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  FirebaseService._();

  static bool _isAvailable = false;

  /// Remote chat stays opt-in until a Firebase project is configured.
  /// Build with --dart-define=USE_FIREBASE_CHAT=true to enable it.
  static const bool _remoteRequested = bool.fromEnvironment(
    'USE_FIREBASE_CHAT',
    defaultValue: false,
  );

  static bool get isAvailable => _isAvailable;

  static bool get remoteChatEnabled => _remoteRequested && _isAvailable;

  static Future<bool> initialize() async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }
      _isAvailable = true;
    } catch (_) {
      // The debug APK intentionally remains usable before google-services.json
      // is added. It falls back to the in-memory demo repository.
      _isAvailable = false;
    }
    return _isAvailable;
  }
}
