import 'package:blood_donation_flutter_app/core/routes/app_named_route.dart';
import 'package:blood_donation_flutter_app/data/services/user_api_service.dart';
import 'package:blood_donation_flutter_app/utils/determine_user_location.dart';
import 'package:blood_donation_flutter_app/utils/get_fcm_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../data/exceptions/app_exceptions.dart';

class RegisterController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  RxBool isPasswordVisible = RxBool(true);
  Rx<XFile?> imageFile = Rx(null);
  RxBool isAvailableForDonation = RxBool(true);
  GlobalKey<FormState> formKeyForRegistration = GlobalKey<FormState>();
  String? selectedBloodGroup;
  List<String> bloodGroups = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
  ];
  RxBool isLoading = RxBool(false);

  void registerUser() async {
    if (formKeyForRegistration.currentState!.validate()) {
      if (selectedBloodGroup == null) {
        Get.snackbar("Error", "Please select your blood group");
        return;
      } else if (imageFile.value == null) {
        Get.snackbar("Error", "Please select your profile image");
      } else {
        try {
          isLoading.value = true;
          Position position = await DetermineLocation.determineUserLocation();
          String fcmToken = await getFcmToken() ?? "";
          String message = await UserApiService.registerUser(
            fullName: fullNameController.text,
            email: emailController.text,
            password: passwordController.text,
            phoneNumber: phoneNumberController.text,
            bloodGroup: selectedBloodGroup ?? "A+",
            isAvailableForDonation: isAvailableForDonation.value,
            fcmToken: fcmToken,
            role: "USER",
            position: position,
            profileImage: imageFile.value!,
          );
          Get.snackbar("Sucess", message);
          isLoading.value = false;
          Get.offNamed(AppNamedRoute.loginView);
        } on AppException catch (e) {
          Get.snackbar("Error", e.errorMessage);
          // AppSettings.openAppSettings(type: AppSettingsType.location);
          debugPrint(e.errorMessage);
        } catch (e) {
          Get.snackbar("Error", "Something went wrong");
        } finally {
          isLoading.value = false;
        }
      }
    }
  }
}
