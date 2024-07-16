import 'dart:convert';

import 'package:blood_donation_flutter_app/constants/api_endpoint_constants.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:http/http.dart';

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

  static dynamic getJsonResponse({required Response response}) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body)["message"] ?? "Login Sucessfull";
      case 400:
        throw BadRequestException(
            errorMessage:
                jsonDecode(response.body)["message"] ?? "Bad request");
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
