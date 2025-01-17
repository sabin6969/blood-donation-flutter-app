import 'dart:convert';

import 'package:blood_donation_flutter_app/data/network/base_api_service.dart';
import 'package:http/http.dart';

import '../exceptions/app_exceptions.dart';

class NetworkApiService extends BaseApiService {
  Response _getResponse({required Response response}) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
      case 400:
        throw BadRequestException(
            errorMessage:
                jsonDecode(response.body)["message"] ?? "Bad Request");
      case 401:
        throw UnauthorizedException(
            errorMessage:
                jsonDecode(response.body)["message"] ?? "Unauthorized Request");
      case 404:
        throw NotFoundException(
            errorMessage: jsonDecode(response.body)["message"] ??
                "Request resource is not found on the server");
      case 409:
        throw ConflictException(
            errorMessage: jsonDecode(response.body)["message"] ?? "Conflict");
      case 500:
      default:
        throw InternalServerException(
            errorMessage: jsonDecode(response.body)["message"] ??
                "Internal server erorr");
    }
  }

  @override
  Future<Response> deleteRequest(
      {required Uri url,
      required Map<String, String> headers,
      required Map<String, dynamic> requestBody}) async {
    try {
      Response response = await delete(url);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<Response> getRequest(
      {required Uri url,
      required Map<String, String> headers,
      Map<String, String>? queryParams}) async {
    try {
      Response response = await get(
        url,
        headers: headers,
      );
      return _getResponse(response: response);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<Response> patchRequest(
      {required Uri url,
      required Map<String, String> headers,
      required Map<String, dynamic> requestBody}) async {
    try {
      Response response = await patch(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );
      return _getResponse(response: response);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<Response> postRequest(
      {required Uri url,
      required Map<String, String> headers,
      required Map<String, dynamic> requestBody}) async {
    try {
      Response response = await post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );
      return _getResponse(response: response);
    } catch (e) {
      return Future.error(e);
    }
  }
}
