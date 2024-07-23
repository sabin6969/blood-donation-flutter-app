import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/data/services/get_storage_service.dart';
import 'package:blood_donation_flutter_app/data/services/user_api_service.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:blood_donation_flutter_app/models/donors_response_model.dart';
import 'package:get/get.dart';

class SearchDonorController extends GetxService {
  RxBool isLoading = RxBool(false);
  DonorsResponse? response;

  @override
  void onInit() {
    fetchAllDonors();
    super.onInit();
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
      Get.offAllNamed(AppRoutes.loginView);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
