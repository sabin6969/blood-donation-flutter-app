import 'dart:convert';
import 'dart:ffi';

import 'package:blood_donation_flutter_app/constants/api_endpoint_constants.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:flutter/material.dart';
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

  static Future<String> registerUser({
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
      request.fields["fullName"] = fullName;
      request.fields["email"] = email;
      request.fields["password"] = password;
      request.fields["phoneNumber"] = phoneNumber;
      request.fields["bloodGroup"] = bloodGroup;
      request.fields["isAvailableForDonation"] =
          isAvailableForDonation.toString();
      request.fields["fcmToken"] = fcmToken;
      request.files.add(await MultipartFile.fromPath(
        "profileImage",
        profileImage.path,
      ));
      request.fields["role"] = role;
      request.fields["location[type]"] = "Point";
      List<String> coordinates = [
        position.latitude.toString(),
        position.longitude.toString()
      ];
      request.fields["location[coordinates]"] = jsonEncode(coordinates);
      _response = await Response.fromStream(await request.send());
      return getJsonResponse(response: _response);
    } catch (e) {
      return Future.error(e);
    }
  }

  static dynamic getJsonResponse({required Response response}) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body)["message"] ?? "Login Sucessfull";
      case 201:
        return jsonDecode(response.body)["message"];
      case 400:
        throw BadRequestException(
            errorMessage:
                jsonDecode(response.body)["message"] ?? "Bad request");
      case 409:
        throw ResourceConflictException(
            errorMessage: jsonDecode(response.body)["message"]);
      case 500:
        throw InternalServerException(
            errorMessage: jsonDecode(response.body)["message"] ??
                "Internal server error");
      case 404:
        throw NotFoundException(
            errorMessage: jsonDecode(response.body)["message"] ?? "Not found");
      case 401:
        throw UnauthorizedException(
            errorMessage: jsonDecode(response.body)["message"]);
      default:
        throw const AppException(errorMessage: "Something went wrong");
    }
  }
}
