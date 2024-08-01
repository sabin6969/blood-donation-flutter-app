import 'dart:io';

import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/data/services/get_storage_service.dart';
import 'package:blood_donation_flutter_app/data/services/user_api_service.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:blood_donation_flutter_app/utils/get_fcm_token.dart';
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
      String? accessToken = GetStorageService.getAccessToken();
      if (accessToken != null) {
        String fcmToken = await getFcmToken() ?? "";
        String message = await UserApiService.verifyAccessToken(
          accessToken: accessToken,
          fcmToken: fcmToken,
        );
        FlutterNativeSplash.remove();
        showToastMessage(message: message);
        await Future.delayed(const Duration(milliseconds: 100));
        Get.offNamed(AppRoutes.landingView);
      } else {
        FlutterNativeSplash.remove();
        await Future.delayed(const Duration(milliseconds: 100));
        showToastMessage(message: "Welcome! Proceed with Login or Signup");
        Get.offNamed(AppRoutes.loginView);
      }
    } on SocketException {
      showToastMessage(message: "No internet");
      Get.offNamed(AppRoutes.noInternetView);
    } on ServerRequestTimeoutError {
      showToastMessage(message: "No internet");
      Get.offNamed(AppRoutes.noInternetView);
    } on UnauthorizedException catch (e) {
      showToastMessage(message: e.errorMessage);
      Get.offNamed(AppRoutes.loginView);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      FlutterNativeSplash.remove();
    }
  }
}
