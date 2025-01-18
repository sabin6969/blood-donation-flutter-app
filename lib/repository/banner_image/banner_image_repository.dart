import 'dart:convert';

import 'package:blood_donation_flutter_app/core/const/api_endpoint_constants.dart';
import 'package:blood_donation_flutter_app/data/network/network_api_service.dart';
import 'package:blood_donation_flutter_app/models/banner_image/banner_image_response_model.dart';
import 'package:blood_donation_flutter_app/services/get_storage_service.dart';
import 'package:http/http.dart';

class BannerImageRepository {
  final NetworkApiService _networkApiService = NetworkApiService();

  Future<BannerImageResponseModel> getBannerImages() async {
    try {
      Response response = await _networkApiService.getRequest(
        url: Uri.parse("$baseUrl/$bannerRoute/getBannerImages"),
        headers: {
          "Authorization": "Bearer ${GetStorageService.getAccessToken()}"
        },
      );
      return BannerImageResponseModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Future.error(e);
    }
  }
}
