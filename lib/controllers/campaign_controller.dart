import 'package:blood_donation_flutter_app/core/routes/app_named_route.dart';
import 'package:blood_donation_flutter_app/data/services/campaign_api_service.dart';
import 'package:blood_donation_flutter_app/services/get_storage_service.dart';

import 'package:blood_donation_flutter_app/models/campaign_response_model.dart';
import 'package:blood_donation_flutter_app/utils/determine_user_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../data/exceptions/app_exceptions.dart';

class CampaingController extends GetxService {
  RxBool isActiveCampaignLoading = RxBool(false);
  RxBool isNearestCampaignLoading = RxBool(false);
  RxBool isLocactionDisabled = RxBool(false);
  RxBool isNearestCampaignLoaded = RxBool(false);
  RxBool isAllCampaignLoaded = RxBool(false);

  @override
  void onInit() {
    fetchActiveCampaign();
    fetchNearestCampaign();
    super.onInit();
  }

  CampaignResponseModel? campaignResponse;
  late CampaignResponseModel nearestCampaignResponse;
  void fetchActiveCampaign() async {
    try {
      isActiveCampaignLoading.value = true;
      String accessToken = GetStorageService.getAccessToken() ?? "";
      campaignResponse =
          await CampaignApiService.getActiveCampaings(accessToken: accessToken);
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
      String accessToken = GetStorageService.getAccessToken() ?? "";
      Position userPosition = await DetermineLocation.determineUserLocation();
      nearestCampaignResponse = await CampaignApiService.getNearestCampaign(
        lat: userPosition.latitude,
        lng: userPosition.longitude,
        accessToken: accessToken,
      );
      isNearestCampaignLoaded.value = true;
    } on LocationNotEnabledException {
      isLocactionDisabled.value = true;
    } on InternalServerException {
      Get.snackbar("Error", "Internal Server Error Occured!!");
    } on AppException catch (e) {
      Get.snackbar("Error", e.errorMessage);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isNearestCampaignLoading.value = false;
    }
  }

  void particupateInCampaign({required String campaignId}) async {
    try {
      isActiveCampaignLoading.value = true;
      String accessToken = GetStorageService.getAccessToken() ?? "";
      campaignResponse = await CampaignApiService.participateInCampaign(
        accessToken: accessToken,
        campaignId: campaignId,
      );
      Get.snackbar("Sucess", campaignResponse!.message ?? "");
    } on UnauthorizedException catch (e) {
      Get.offAllNamed(AppNamedRoute.loginView);
      Get.snackbar("Unauthorized", e.errorMessage);
    } on AppException catch (e) {
      Get.snackbar("Error", e.errorMessage);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isActiveCampaignLoading.value = false;
    }
  }
}
