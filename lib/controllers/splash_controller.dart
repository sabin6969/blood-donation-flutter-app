import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/data/services/get_storage_service.dart';
import 'package:blood_donation_flutter_app/data/services/user_api_service.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:blood_donation_flutter_app/utils/widgets/toast_message.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    verifyAuthToken();
    super.onInit();
  }

  void verifyAuthToken() async {
    try {
      String accessToken = GetStorageService.getAccessToken() ?? "";
      String message =
          await UserApiService.verifyAccessToken(accessToken: accessToken);
      showToastMessage(message: message);
      Get.offNamed(AppRoutes.landingView);
    } on UnauthorizedException catch (e) {
      // Get.snackbar("Error", e.errorMessage);
      showToastMessage(message: e.errorMessage);
      Get.offNamed(AppRoutes.loginView);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      FlutterNativeSplash.remove();
    }
  }
}
