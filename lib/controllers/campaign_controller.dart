import 'package:blood_donation_flutter_app/data/services/campaign_api_service.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:blood_donation_flutter_app/models/campaign_response_model.dart';
import 'package:blood_donation_flutter_app/utils/determine_user_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CampaingController extends GetxService {
  RxBool isActiveCampaignLoading = RxBool(false);
  RxBool isNearestCampaignLoading = RxBool(false);
  RxBool isLocactionDisabled = RxBool(false);
  RxBool isNearestCampaignLoaded = RxBool(false);
  RxBool isAllCampaignLoaded = RxBool(false);

  late CampaignResponse campaignResponse;
  late CampaignResponse nearestCampaignResponse;
  void fetchActiveCampaign() async {
    try {
      isActiveCampaignLoading.value = true;
      campaignResponse = await CampaignApiService.getActiveCampaings();
      isAllCampaignLoaded.value = true;
    } on AppException catch (e) {
      Get.snackbar("Error", e.errorMessage);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isActiveCampaignLoading.value = false;
    }
  }

  void fetchNearestCampaign() async {
    try {
      isNearestCampaignLoading.value = true;
      Position userPosition = await DetermineLocation.determineUserLocation();
      nearestCampaignResponse = await CampaignApiService.getNearestCampaign(
          lat: userPosition.latitude, lng: userPosition.longitude);
      isNearestCampaignLoaded.value = true;
    } on LocationNotEnabledException {
      isLocactionDisabled.value = true;
    } on InternalServerException {
      Get.snackbar("Error", "Something went wrong");
    } on AppException catch (e) {
      Get.snackbar("Error", e.errorMessage);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isNearestCampaignLoading.value = false;
    }
  }
}
