import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/data/services/admin_api_service.dart';
import 'package:blood_donation_flutter_app/services/get_storage_service.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:blood_donation_flutter_app/models/admin_response_model.dart';
import 'package:get/get.dart';

class AdminController extends GetxService {
  RxBool isLoading = RxBool(false);
  AdminsResponse? response;

  @override
  void onInit() {
    fetchAdmins();
    super.onInit();
  }

  void fetchAdmins() async {
    try {
      isLoading.value = true;
      String accessToken = GetStorageService.getAccessToken() ?? "";
      response = await AdminApiService.getAllAdmins(accessToken: accessToken);
    } on UnauthorizedException catch (e) {
      Get.snackbar("Error", e.errorMessage);
      Get.offAllNamed(AppRoutes.loginView);
    } on AppException catch (e) {
      Get.snackbar("Error", e.errorMessage);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
