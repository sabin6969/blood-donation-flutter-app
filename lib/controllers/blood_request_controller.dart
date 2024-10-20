import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/data/services/bloods_api_service.dart';
import 'package:blood_donation_flutter_app/data/services/get_storage_service.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:blood_donation_flutter_app/models/approved_blood_request_model.dart';
import 'package:blood_donation_flutter_app/models/pending_blood_request_mode.dart';
import 'package:blood_donation_flutter_app/models/rejected_blood_request_model.dart';
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
  RxBool isApprovedBloodRequestLoading = RxBool(false);
  RxBool isPendingBloodRequestLoading = RxBool(false);
  RxBool isRejectedBloodRequestLoading = RxBool(false);

  ApprovedBloodRequestModel? approvedBloodRequestModel;
  PendingBloodRequestModel? pendingBloodRequestModel;
  RejectedBloodRequestModel? rejectedBloodRequestModel;

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

  void fetchApprovedBloodRequest() async {
    try {
      isApprovedBloodRequestLoading.value = true;
      String accessToken = GetStorageService.getAccessToken() ?? "";
      approvedBloodRequestModel =
          await BloodServiceApi.getAllMyApprovedBloodRequests(
              accessToken: accessToken);
    } on UnauthorizedException catch (e) {
      Get.offAllNamed(AppRoutes.loginView);
      Get.snackbar("Unauthorized Access", e.errorMessage);
    } on InternalServerException catch (e) {
      Get.snackbar("Internal server erro", e.errorMessage);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isApprovedBloodRequestLoading.value = false;
    }
  }

  void fetchPendingBloodRequest() async {
    try {
      isPendingBloodRequestLoading.value = true;
      String accessToken = GetStorageService.getAccessToken() ?? "";
      pendingBloodRequestModel =
          await BloodServiceApi.getAllMyPendingBloodRequest(
              accessToken: accessToken);
    } on UnauthorizedException catch (e) {
      Get.offAllNamed(AppRoutes.loginView);
      Get.snackbar("Unauthorized", e.errorMessage);
    } on AppException catch (e) {
      Get.snackbar("Error", e.errorMessage);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isPendingBloodRequestLoading.value = false;
    }
  }

  void fetchRejectedBloodRequest() async {
    try {
      isRejectedBloodRequestLoading.value = true;
      String accessToken = GetStorageService.getAccessToken() ?? "";
      rejectedBloodRequestModel = await BloodServiceApi.getAllMyRejectedBloodRequests(accessToken: accessToken);
    } on UnauthorizedException catch (e) {
      Get.offAllNamed(AppRoutes.loginView);
      Get.snackbar("Unauthorized", e.errorMessage);
    } on AppException catch (e) {
      Get.snackbar("Error", e.errorMessage);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isRejectedBloodRequestLoading.value = false;
    }
  }
}
