import 'package:app_settings/app_settings.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:blood_donation_flutter_app/utils/determine_user_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  RxBool isPasswordVisible = RxBool(true);
  Rx<XFile?> imageFile = Rx(null);
  RxBool isAvailableForDonation = RxBool(true);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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

  void registerUser() async {
    if (formKey.currentState!.validate()) {
      if (selectedBloodGroup == null) {
        Get.snackbar("Error", "Please select your blood group");
        return;
      } else if (imageFile.value == null) {
        Get.snackbar("Error", "Please select your profile image");
      } else {
        try {
          Position position = await DetermineLocaltion.determineUserLocation();
          debugPrint(position.latitude.toString());
          debugPrint(position.longitude.toString());
        } on AppException catch (e) {
          Get.snackbar("Error", e.errorMessage);
          AppSettings.openAppSettings(type: AppSettingsType.location);
        } catch (e) {
          Get.snackbar("Error", "Something went wrong");
        }
      }
    }
  }
}
