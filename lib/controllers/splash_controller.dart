import 'dart:developer';

import 'package:blood_donation_flutter_app/core/routes/app_named_route.dart';
import 'package:blood_donation_flutter_app/services/get_storage_service.dart';
import 'package:get/get.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    navigateUser();
    super.onInit();
  }

  void navigateUser() async {
    await Future.delayed(const Duration(seconds: 2));
    bool isAlreadyOnboarded =
        await GetStorageService.isAlreadyOnboarded() ?? false;
    String? accessToken = GetStorageService.getAccessToken();
    if (isAlreadyOnboarded) {
      if (accessToken == null) {
        Get.offNamed(AppNamedRoute.loginView);
        return;
      }
      try {
        JWT.verify(
          accessToken,
          SecretKey(
            "accessTokEnSecreT",
          ),
        );
        Get.offNamed(AppNamedRoute.landingView);
      } on JWTExpiredException {
        Get.snackbar("Token expired", "Please login again");
        Get.offNamed(AppNamedRoute.loginView);
      } catch (e) {
        log("Error is $e");
        log("An error occured");
      }
    } else {
      Get.offNamed(AppNamedRoute.onboardingView);
    }
  }
}
