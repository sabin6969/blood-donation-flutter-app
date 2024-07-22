import 'dart:convert';

import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:http/http.dart';

dynamic getJsonResponse({required Response response}) {
  switch (response.statusCode) {
    case 200:
      return jsonDecode(response.body);
    case 201:
      return jsonDecode(response.body)["message"];
    case 400:
      throw BadRequestException(
          errorMessage: jsonDecode(response.body)["message"] ?? "Bad request");
    case 409:
      throw ResourceConflictException(
          errorMessage: jsonDecode(response.body)["message"]);
    case 500:
      throw InternalServerException(
          errorMessage:
              jsonDecode(response.body)["message"] ?? "Internal server error");
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
