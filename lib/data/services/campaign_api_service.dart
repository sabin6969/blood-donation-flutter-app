import 'package:blood_donation_flutter_app/constants/api_endpoint_constants.dart';
import 'package:blood_donation_flutter_app/models/campaign_response_model.dart';
import 'package:blood_donation_flutter_app/utils/json_response.dart';
import 'package:http/http.dart';

class CampaignApiService {
  static late Response _response;

  static Future<CampaignResponseModel> getActiveCampaings(
      {required String accessToken}) async {
    try {
      _response = await get(Uri.parse("$baseUrl/$campaignRoute/getAllCampaign"),
          headers: {"Authorization": "Bearer $accessToken"});
      var jsonData = getJsonResponse(response: _response);
      return CampaignResponseModel.fromJson(jsonData);
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<CampaignResponseModel> getNearestCampaign(
      {required double lat, required lng, required String accessToken}) async {
    try {
      _response = await get(
          Uri.parse(
              "$baseUrl/$campaignRoute/getNearestCampaign?lat=$lat&lng=$lng"),
          headers: {
            "Authorization": "Bearer $accessToken",
          });
      return CampaignResponseModel.fromJson(
        getJsonResponse(
          response: _response,
        ),
      );
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<CampaignResponseModel> participateInCampaign(
      {required String accessToken, required String campaignId}) async {
    try {
      _response = await post(
        Uri.parse(
          "$baseUrl/$campaignRoute/participateInCampaign/$campaignId",
        ),
        headers: {"Authorization": "Bearer $accessToken"},
      );
      return CampaignResponseModel.fromJson(
          getJsonResponse(response: _response));
    } catch (e) {
      return Future.error(e);
    }
  }
}
