import 'dart:convert';

import 'package:blood_donation_flutter_app/constants/api_endpoint_constants.dart';
import 'package:blood_donation_flutter_app/models/donors_response_model.dart';
import 'package:blood_donation_flutter_app/models/profile_response_model.dart';
import 'package:blood_donation_flutter_app/utils/json_response.dart';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class UserApiService {
  static late Response _response;
  static Future login({required String email, required String password}) async {
    try {
      _response = await post(
        Uri.parse(
          "$baseUrl/$userRoute/login",
        ),
        body: jsonEncode(
          {
            "email": email,
            "password": password,
          },
        ),
        headers: {
          "Content-Type": "application/json",
        },
      );

      return getJsonResponse(response: _response);
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future registerUser({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required String bloodGroup,
    required bool isAvailableForDonation,
    required String fcmToken,
    required String role,
    required Position position,
    required XFile profileImage,
  }) async {
    try {
      MultipartRequest request = MultipartRequest(
          "POST", Uri.parse("$baseUrl/$userRoute/createAccount"));
      request.fields.addAll({
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'bloodGroup': bloodGroup,
        'location[type]': 'Point',
        'role': role,
        'fcmToken': fcmToken,
        'isAvailableForDonation': isAvailableForDonation.toString(),
        'fullName': fullName,
        'location[coordinates][0]': position.latitude.toString(),
        'location[coordinates][1]': position.longitude.toString(),
      });

      request.files.add(await MultipartFile.fromPath(
        "profileImage",
        profileImage.path,
      ));
      _response = await Response.fromStream(await request.send());
      return getJsonResponse(response: _response);
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<ProfileResponse> getProfile(
      {required String accessToken}) async {
    try {
      _response = await get(
        Uri.parse("$baseUrl/$userRoute/getProfile"),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );
      var jsonData = getJsonResponse(response: _response);
      return ProfileResponse.fromJson(jsonData);
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<String> logout({required String accessToken}) async {
    try {
      _response = await post(
        Uri.parse(
          "$baseUrl/$userRoute/logout",
        ),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );
      var jsonResponse = getJsonResponse(response: _response);
      return jsonResponse["message"];
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<DonorsResponse> getAllDonors(
      {required String accessToken}) async {
    try {
      _response = await get(
          Uri.parse(
            "$baseUrl/$userRoute/getAllDonors",
          ),
          headers: {"Authorization": "Bearer $accessToken"});
      return DonorsResponse.fromJson(getJsonResponse(response: _response));
    } catch (e) {
      return Future.error(e);
    }
  }
}
