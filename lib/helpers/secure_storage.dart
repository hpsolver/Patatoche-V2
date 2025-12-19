import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static FlutterSecureStorage? secureStorage;

  static Future<void> saveAccessToken(String? accessToken) async {
    if (secureStorage != null) {
      await secureStorage!.write(key: 'accessToken', value: accessToken ?? '');
      await secureStorage!.write(key: 'tokenSavedAt', value: DateTime.now().toIso8601String());
    } else {
      throw Exception("FlutterSecureStorage not initialized");
    }
  }

  static Future<DateTime?> getTokenSavedTime() async {
    final value = await secureStorage!.read(key: 'tokenSavedAt');
    if (value == null) return null;
    return DateTime.tryParse(value);
  }

  static Future<void> saveDfnsToken(String? token) async {
    if (secureStorage != null) {
      await secureStorage!.write(key: 'dfnsToken', value: token ?? '');
    } else {
      throw Exception("FlutterSecureStorage not initialized");
    }
  }

  static Future<String?> getAccessToken() async {
    if (secureStorage != null) {
      return await secureStorage!.read(key: 'accessToken');
    } else {
      throw Exception("FlutterSecureStorage not initialized");
    }
  }

  static Future<String?> getDfnsToken() async {
    if (secureStorage != null) {
      return await secureStorage!.read(key: 'dfnsToken');
    } else {
      throw Exception("FlutterSecureStorage not initialized");
    }
  }

  static Future<void> setPasscode(String passcode) async {
    if (secureStorage != null) {
      await secureStorage!.write(key: 'passcode', value: passcode);
    } else {
      throw Exception("FlutterSecureStorage not initialized");
    }
  }

  static Future<String?> getPasscode() async {
    if (secureStorage != null) {
      return await secureStorage!.read(key: 'passcode');
    } else {
      throw Exception("FlutterSecureStorage not initialized");
    }
  }

  static Future<void> delete() async {
    if (secureStorage != null) {
      await secureStorage!.deleteAll();
    } else {
      throw Exception("FlutterSecureStorage not initialized");
    }
  }
}
