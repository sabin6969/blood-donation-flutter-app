import 'package:blood_donation_flutter_app/services/get_storage_service.dart';
import 'package:blood_donation_flutter_app/data/services/user_api_service.dart';
import 'package:blood_donation_flutter_app/models/top_blood_requestor_model.dart';
import 'package:get/get.dart';

import '../data/exceptions/app_exceptions.dart';

class HomeController extends GetxService {
  @override
  void onInit() {
    fetchTopBloodRequestor();
    super.onInit();
  }

  RxBool isLoading = RxBool(false);
  late TopBloodRequestor topBloodRequestor;

  void fetchTopBloodRequestor() async {
    try {
      isLoading.value = true;
      String accessToken = GetStorageService.getAccessToken() ?? "";
      topBloodRequestor = await UserApiService.getTopBloodRequestor(
        accessToken: accessToken,
      );
    } on AppException catch (e) {
      Get.snackbar("Error", e.errorMessage);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
