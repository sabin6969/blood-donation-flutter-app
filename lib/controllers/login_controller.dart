import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/data/services/user_api_service.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isLoading = RxBool(false);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isPasswordVisible = RxBool(true);

  void login({required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Both Email and Password are required");
    } else {
      if (!email.isEmail) {
        Get.snackbar("Error", "Please enter a valid Email");
        return;
      }
      try {
        isLoading.value = true;
        String message =
            await UserApiService.login(email: email, password: password);
        Get.snackbar("Sucess", message);
        Get.offNamed(AppRoutes.homeView);
      } on AppException catch (e) {
        Get.snackbar("Error", e.errorMessage);
      } catch (e) {
        Get.snackbar("Error", "Something went wrong");
      } finally {
        isLoading.value = false;
      }
    }
  }
}