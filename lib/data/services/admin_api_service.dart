import 'package:blood_donation_flutter_app/constants/api_endpoint_constants.dart';
import 'package:blood_donation_flutter_app/models/admin_response_model.dart';
import 'package:blood_donation_flutter_app/utils/json_response.dart';
import 'package:http/http.dart';

class AdminApiService {
  static late Response _response;
  static Future<AdminsResponse> getAllAdmins(
      {required String accessToken}) async {
    try {
      _response = await get(
        Uri.parse(
          "$baseUrl/$userRoute/getAllAdmins",
        ),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );
      return AdminsResponse.fromJson(getJsonResponse(response: _response));
    } catch (e) {
      return Future.error(e); 
    }
  }
}
