import 'dart:convert';
import 'dart:io';

import 'package:blood_donation_flutter_app/core/const/api_endpoint_constants.dart';
import 'package:blood_donation_flutter_app/data/network/network_api_service.dart';
import 'package:blood_donation_flutter_app/models/campaign/campaign_response_model.dart';
import 'package:http/http.dart';

class CampaignRepository {
  final NetworkApiService _networkApiService = NetworkApiService();

  Future<CampaignResponse> getAllCampaigns(
      {required String accessToken}) async {
    try {
      Response response = await _networkApiService.getRequest(
        url: Uri.parse("$baseUrl/$campaignRoute/getAllCampaign"),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $accessToken",
        },
      );
      return CampaignResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<CampaignResponse> participateInCampaign({
    required String accessToken,
    required String campaignId,
  }) async {
    try {
      Response response = await _networkApiService.postRequest(
        url: Uri.parse(
            "$baseUrl/$campaignRoute/participateInCampaign/$campaignId"),
        headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"},
        requestBody: {},
      );
      return CampaignResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Future.error(e);
    }
  }
}
