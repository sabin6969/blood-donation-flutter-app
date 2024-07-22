import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/data/services/get_storage_service.dart';
import 'package:blood_donation_flutter_app/data/services/user_api_service.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isLoading = RxBool(false);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isPasswordVisible = RxBool(true);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void login({required String email, required String password}) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      try {
        isLoading.value = true;
        var data = await UserApiService.login(email: email, password: password);
        Get.snackbar("Sucess", data["message"]);
        // storing access token of a user once logged in
        await GetStorageService.setAccessToken(
            accessToken: data["data"]["accessToken"]);
        Get.offNamed(AppRoutes.landingView);
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
