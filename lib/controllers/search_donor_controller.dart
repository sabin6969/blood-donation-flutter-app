import 'package:app_settings/app_settings.dart';
import 'package:blood_donation_flutter_app/core/routes/app_named_route.dart';
import 'package:blood_donation_flutter_app/services/get_storage_service.dart';
import 'package:blood_donation_flutter_app/data/services/user_api_service.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:blood_donation_flutter_app/models/donors_response_model.dart';
import 'package:blood_donation_flutter_app/models/nearby_donor_model.dart';
import 'package:blood_donation_flutter_app/utils/determine_user_location.dart';
import 'package:blood_donation_flutter_app/utils/widgets/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class SearchDonorController extends GetxService with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      try {
        await DetermineLocation.determineUserLocation();
        isLocationDisabled.value = false;
      } on LocationNotEnabledException {
        isLocationDisabled.value = true;
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  RxBool isLoading = RxBool(false);
  RxBool isNearByDonorLoading = RxBool(false);
  DonorsResponse? response;
  NearByDonorResponse? nearByDonorResponse;

  RxBool isLocationDisabled = RxBool(false);

  RxDouble distance = 100.0.obs;
  RxBool isActivelyDonating = true.obs;

  @override
  void onInit() {
    fetchAllDonors();
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void fetchAllDonors({int? page}) async {
    try {
      isLoading.value = true;
      String accessToken = GetStorageService.getAccessToken() ?? "";
      response = await UserApiService.getAllDonors(
        accessToken: accessToken,
        page: page,
      );
    } on UnauthorizedException catch (e) {
      Get.snackbar("Unauthorized", e.errorMessage);
      Get.offAllNamed(AppNamedRoute.loginView);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  void fetchNearByDonors() async {
    try {
      isNearByDonorLoading.value = true;
      Position position = await DetermineLocation.determineUserLocation();
      String accessToken = GetStorageService.getAccessToken() ?? "";

      nearByDonorResponse = await UserApiService.getNearByDonors(
        accessToken: accessToken,
        isActivelyDonating: isActivelyDonating.value,
        position: position,
        maxDistanceRange: distance.value * 1000,
      );
    } on UnauthorizedException catch (e) {
      Get.snackbar("Unauthorized", e.errorMessage);
      Get.offAllNamed(AppNamedRoute.loginView);
    } on LocationNotEnabledException catch (e) {
      isLocationDisabled.value = true;
      showToastMessage(message: e.errorMessage);
      AppSettings.openAppSettings(type: AppSettingsType.location);
    } on AppException catch (e) {
      Get.snackbar("Error", e.errorMessage);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isNearByDonorLoading.value = false;
    }
  }
}
