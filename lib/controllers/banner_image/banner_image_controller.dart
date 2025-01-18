import 'dart:developer';

import 'package:blood_donation_flutter_app/core/const/api_endpoint_constants.dart';
import 'package:blood_donation_flutter_app/core/const/app_enums.dart';
import 'package:blood_donation_flutter_app/models/banner_image/banner_image_response_model.dart';
import 'package:blood_donation_flutter_app/repository/banner_image/banner_image_repository.dart';
import 'package:get/get.dart';

class BannerImageController extends GetxService {
  final BannerImageRepository bannerImageRepository;

  final Rx<AppViewState> _appViewState = AppViewState.idel.obs;

  AppViewState get appViewState => _appViewState.value;

  BannerImageController({required this.bannerImageRepository});

  List<String> bannerImagePaths = [];

  void getAllBannerImages() async {
    try {
      _appViewState.value = AppViewState.loading;
      BannerImageResponseModel bannerImage =
          await bannerImageRepository.getBannerImages();
      bannerImagePaths = bannerImage.data
          .map(
            (e) => "$baseCdnUrl/${e.imageUrl}",
          )
          .toList();
      _appViewState.value = AppViewState.sucess;
    } catch (e) {
      _appViewState.value = AppViewState.error;
      log("An error occured $e");
      Get.snackbar("Error", "Something went wrong");
    }
  }
}
