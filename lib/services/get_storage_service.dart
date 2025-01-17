import 'package:get_storage/get_storage.dart';

class GetStorageService {
  static final _box = GetStorage();
  static const String _accessTokenKey = "accessToken";
  static const String _isOnboardedKey = "isOnboarded";
  static Future<void> setAccessToken({required String accessToken}) async {
    await _box.write(_accessTokenKey, accessToken);
  }

  static String? getAccessToken() {
    return _box.read(_accessTokenKey);
  }

  static Future<void> clearAccessToken() async {
    return await _box.remove(_accessTokenKey);
  }

  static Future<void> setAsOnboarded() async {
    await _box.write(_isOnboardedKey, true);
  }

  static Future<bool>? isAlreadyOnboarded() async {
    return await _box.read(_isOnboardedKey) ?? false;
  }
}
