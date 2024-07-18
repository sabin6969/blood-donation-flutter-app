import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  void registerUser() {
    if (formKey.currentState!.validate()) {
      if (selectedBloodGroup == null) {
        Get.snackbar("Error", "Please select your blood group");
        return;
      } else if (imageFile.value == null) {
        Get.snackbar("Error", "Please select your profile image");
      } else {
        // TODO Call API
        debugPrint(selectedBloodGroup);
      }
    }
  }
}
