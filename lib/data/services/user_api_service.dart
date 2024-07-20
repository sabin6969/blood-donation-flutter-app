import 'dart:convert';

import 'package:blood_donation_flutter_app/constants/api_endpoint_constants.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';

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

  static dynamic getJsonResponse({required Response response}) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
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
