import 'dart:convert';

import 'package:blood_donation_flutter_app/constants/api_endpoint_constants.dart';
import 'package:blood_donation_flutter_app/utils/json_response.dart';
import 'package:http/http.dart';

class BloodServiceApi {
  static late Response _response;

  static Future<String> requestBlood({
    required String city,
    required String hospital,
    required String requestedBloodGroup,
    required String accessToken,
    String? note,
  }) async {
    try {
      _response = await post(
        Uri.parse("$baseUrl/$bloodRoute/requestForBlood"),
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "requestedBloodGroup": requestedBloodGroup,
          "city": city,
          "hospital": hospital,
          "note": note,
        }),
      );
      return getJsonResponse(response: _response);
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future getAllMyApprovedBloodRequests(
      {required String accessToken}) async {
    try {
      _response = await get(
        Uri.parse("$baseUrl/$bloodRoute/getAllMyApprovedBloodRequests"),
        headers: {"Authorization": "Bearer $accessToken"},
      );
      print("Approvied Blood request"+_response.body);
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future getAllMyRejectedBloodRequests(
      {required String accessToken}) async {
    try {
      _response = await get(
          Uri.parse("$baseUrl/$bloodRoute/getAllMyRejectedBloodRequests"),
          headers: {"Authorization": "Bearer $accessToken"});
      print("Rejected Blood Request "+_response.body);
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future getAllMyPendingBloodRequest(
      {required String accessToken}) async {
    try {
      _response = await get(
        Uri.parse("$baseUrl/$bloodRoute/getAllMyRejectedBloodRequests"),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );
      print("Bending Blood Request "+ _response.body);
    } catch (e) {
      return Future.error(e);
    }
  }
}
