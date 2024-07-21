import 'package:get_storage/get_storage.dart';

class GetStorageService {
  static final _box = GetStorage();
  static const String _accessTokenKey = "accessToken";
  static void setAccessToken({required String accessToken}) async {
    await _box.write(_accessTokenKey, accessToken);
  }

  static String? getAccessToken() {
    return _box.read(_accessTokenKey);
  }

  static Future<void> clearAccessToken() async {
    await _box.remove(_accessTokenKey);
  }
}
