import 'package:blood_donation_flutter_app/data/services/campaign_api_service.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:blood_donation_flutter_app/models/campaign_response_model.dart';
import 'package:get/get.dart';

class CampaingController extends GetxService {
  RxBool isActiveCampaignLoading = RxBool(false);
  late CampaignResponse campaignResponse;
  void fetchActiveCampaign() async {
    try {
      isActiveCampaignLoading.value = true;
      campaignResponse = await CampaignApiService.getActiveCampaings();
    } on AppException catch (e) {
      Get.snackbar("Error", e.errorMessage);
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isActiveCampaignLoading.value = false;
    }
  }
}
