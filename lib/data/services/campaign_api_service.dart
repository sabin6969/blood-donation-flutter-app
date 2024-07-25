import 'package:blood_donation_flutter_app/constants/api_endpoint_constants.dart';
import 'package:blood_donation_flutter_app/models/campaign_response_model.dart';
import 'package:blood_donation_flutter_app/utils/json_response.dart';
import 'package:http/http.dart';

class CampaignApiService {
  static late Response _response;

  static Future<CampaignResponse> getActiveCampaings() async {
    try {
      _response = await get(
        Uri.parse("$baseUrl/$campaignRoute/getAllCampaign"),
      );
      var jsonData = getJsonResponse(response: _response);
      return CampaignResponse.fromJson(jsonData);
    } catch (e) {
      return Future.error(e);
    }
  }
}
