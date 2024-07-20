import 'package:get_storage/get_storage.dart';

class GetStorageService {
  static final box = GetStorage();
  static String accessTokenKey = "accessToken";
  static void setAccessToken({required String accessToken}) async {
    await box.write(accessTokenKey, accessToken);
  }

  static String? getAccessToken() {
    return box.read(accessTokenKey);
  }
}
