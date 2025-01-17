import 'package:http/http.dart';

abstract class BaseApiService {
  Future<Response> getRequest({
    required Uri url,
    required Map<String, String> headers,
    Map<String, String>? queryParams,
  });

  Future<Response> postRequest({
    required Uri url,
    required Map<String, String> headers,
    required Map<String, dynamic> requestBody,
  });

  Future<Response> patchRequest({
    required Uri url,
    required Map<String, String> headers,
    required Map<String, dynamic> requestBody,
  });

  Future<Response> deleteRequest({
    required Uri url,
    required Map<String, String> headers,
    required Map<String, dynamic> requestBody,
  });
}
