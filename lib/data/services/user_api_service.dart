import 'dart:convert';
import 'dart:io';

import 'package:blood_donation_flutter_app/constants/api_endpoint_constants.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:blood_donation_flutter_app/models/donors_response_model.dart';
import 'package:blood_donation_flutter_app/models/nearby_donor_model.dart';
import 'package:blood_donation_flutter_app/models/profile_response_model.dart';
import 'package:blood_donation_flutter_app/models/top_blood_requestor_model.dart';
import 'package:blood_donation_flutter_app/utils/json_response.dart';
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class UserApiService {
  static late Response _response;
  static Future login({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    try {
      _response = await post(
        Uri.parse(
          "$baseUrl/$userRoute/login",
        ),
        body: jsonEncode(
          {
            "email": email,
            "password": password,
            "fcmToken": fcmToken,
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
        'location[coordinates][0]': position.longitude.toString(),
        'location[coordinates][1]': position.latitude.toString(),
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
      {required String accessToken, int? page}) async {
    try {
      _response = await get(
        Uri.parse(
          "$baseUrl/$userRoute/getAllDonors?page=$page",
        ),
        headers: {"Authorization": "Bearer $accessToken"},
      );
      return DonorsResponse.fromJson(getJsonResponse(response: _response));
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future verifyAccessToken(
      {required String accessToken, required String fcmToken}) async {
    try {
      _response = await post(
        Uri.parse(
          "$baseUrl/$authRoute/verifyAuth",
        ),
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "fcmToken": fcmToken,
          },
        ),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw ServerRequestTimeoutError(
            errorMessage: "Server Request Timeout",
          );
        },
      );
      String message = getJsonResponse(response: _response)["message"];
      return message;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<TopBloodRequestor> getTopBloodRequestor(
      {required String accessToken}) async {
    try {
      _response = await get(
        Uri.parse(
          "$baseUrl/$userRoute/getTopBloodRequestor",
        ),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );
      return TopBloodRequestor.fromJson(getJsonResponse(response: _response));
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future updateDonationAvailability({
    required bool isAvailableForDonation,
    required String accessToken,
  }) async {
    try {
      _response = await patch(
        Uri.parse(
          "$baseUrl/$userRoute/updateUserAvailabilityForDonation",
        ),
        body: jsonEncode(
          {
            "isAvailableForDonation": isAvailableForDonation,
          },
        ),
        headers: {
          "authorization": "Bearer $accessToken",
          "Content-Type": "application/json",
        },
      );

      return getJsonResponse(response: _response);
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<NearByDonorResponse> getNearByDonors({
    required String accessToken,
    required bool isActivelyDonating,
    required Position position,
    required double maxDistanceRange,
  }) async {
    try {
      debugPrint(
          "$baseUrl/$userRoute/getNearestDonor?lng=${position.longitude}&lat=${position.latitude}&maxDistance=$maxDistanceRange&isAvailableForDonation=$isActivelyDonating");
      _response = await get(
        Uri.parse(
          "$baseUrl/$userRoute/getNearestDonor?lng=${position.longitude}&lat=${position.latitude}&maxDistance=$maxDistanceRange&isAvailableForDonation=$isActivelyDonating",
        ),
        headers: {
          "Authorization": "Bearer $accessToken",
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      return NearByDonorResponse.fromJson(getJsonResponse(response: _response));
    } catch (e) {
      return Future.error(e);
    }
  }
}
