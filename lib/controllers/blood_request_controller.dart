import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/data/services/bloods_api_service.dart';
import 'package:blood_donation_flutter_app/data/services/get_storage_service.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:blood_donation_flutter_app/utils/widgets/show_blood_order_sucess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BloodRequestController extends GetxController {
  TextEditingController cityController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? requestedBlood;
  RxBool isLoading = RxBool(false);
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
  void requestForBlood() async {
    if (formKey.currentState!.validate()) {
      if (requestedBlood == null) {
        Get.snackbar("Error", "Please Select a blood group");
        return;
      }
      try {
        isLoading.value = true;
        String accessToken = GetStorageService.getAccessToken() ?? "";
        String message = await BloodServiceApi.requestBlood(
          city: cityController.text,
          hospital: hospitalController.text,
          requestedBloodGroup: requestedBlood!,
          accessToken: accessToken,
          note: noteController.text,
        );
        Get.snackbar("Sucess", message);
        showBloodOrderSucessDialog();
      } on UnauthorizedException catch (e) {
        Get.snackbar("Unauthorized", e.errorMessage);
        Get.offAllNamed(AppRoutes.loginView);
      } on AppException catch (e) {
        Get.snackbar("Error", e.errorMessage);
      } catch (e) {
        Get.snackbar("Error", "Something went wrong");
      } finally {
        isLoading.value = false;
        cityController.clear();
        hospitalController.clear();
        noteController.clear();
      }
    }
  }

  void fetchBloodRequestStatus() {
    try {
      String accessToken = GetStorageService.getAccessToken() ?? "";
      BloodServiceApi.getAllMyApprovedBloodRequests(accessToken: accessToken);
      BloodServiceApi.getAllMyPendingBloodRequest(accessToken: accessToken);
      BloodServiceApi.getAllMyRejectedBloodRequests(accessToken: accessToken);
    } catch (e) {
      debugPrint("An error occured");
    }
  }
}
