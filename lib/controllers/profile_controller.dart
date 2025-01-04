import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/services/get_storage_service.dart';
import 'package:blood_donation_flutter_app/data/services/user_api_service.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:blood_donation_flutter_app/models/profile_response_model.dart';
import 'package:get/get.dart';

class ProfileController extends GetxService {
  late RxBool _isAvailableForDonation;

  RxBool get isAvailableForDonation => _isAvailableForDonation;

  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }

  late ProfileResponse response;
  RxBool isLoading = RxBool(true);
  RxBool hasError = RxBool(false);
  String? errorMessage;
  void fetchProfile() async {
    try {
      isLoading.value = true;
      String accessToken = GetStorageService.getAccessToken() ?? "";
      response = await UserApiService.getProfile(accessToken: accessToken);
      _isAvailableForDonation =
          RxBool(response.data.first.isAvailableForDonation!);
    } on UnauthorizedException catch (e) {
      Get.snackbar("Unauthorized", e.errorMessage);
      Get.offAllNamed(AppRoutes.loginView);
    } on AppException catch (e) {
      hasError.value = true;
      errorMessage = e.errorMessage;
      Get.snackbar("Error", e.errorMessage);
    } catch (e) {
      hasError.value = true;
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  void logout() async {
    try {
      String accessToken = GetStorageService.getAccessToken() ?? "";
      String message = await UserApiService.logout(accessToken: accessToken);
      await GetStorageService.clearAccessToken();
      Get.offAllNamed(AppRoutes.loginView);
      Get.snackbar("Sucess", message);
    } on UnauthorizedException catch (e) {
      Get.snackbar("Unauthorized", e.errorMessage);
      Get.offAllNamed(AppRoutes.loginView);
    } on AppException catch (e) {
      Get.snackbar("Error", e.errorMessage);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }
  }

  void updateDonationAvailability(
      {required bool isAvailableForDonation}) async {
    try {
      String accessToken = GetStorageService.getAccessToken() ?? "";
      var jsonData = await UserApiService.updateDonationAvailability(
        isAvailableForDonation: isAvailableForDonation,
        accessToken: accessToken,
      );

      _isAvailableForDonation.value =
          jsonData["data"]["isAvailableForDonation"];
      Get.snackbar("Sucess", "Sucessfully updated Availability Status");
    } on UnauthorizedException catch (e) {
      Get.snackbar("Error", e.errorMessage);
      Get.offAllNamed(AppRoutes.loginView);
    } on AppException catch (e) {
      Get.snackbar("Error", e.errorMessage);
    } catch (e) {
      Get.snackbar("Error", "An unknown error occured");
    }
  }
}
