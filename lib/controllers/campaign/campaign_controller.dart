import 'dart:developer';

import 'package:blood_donation_flutter_app/core/const/app_enums.dart';
import 'package:blood_donation_flutter_app/core/routes/app_named_route.dart';
import 'package:blood_donation_flutter_app/data/exceptions/app_exceptions.dart';
import 'package:blood_donation_flutter_app/models/campaign/campaign_response_model.dart';
import 'package:blood_donation_flutter_app/repository/campaign/campaign_repository.dart';
import 'package:blood_donation_flutter_app/services/get_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CampaignController extends GetxController with WidgetsBindingObserver {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  final RxMap<String, bool> _isLoadingMap = <String, bool>{}.obs;

  RxMap<String, bool> get isLoadingMap => _isLoadingMap;

  CampaignRepository campaignRepository;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  CampaignController({required this.campaignRepository});

  late CampaignResponse _campaignResponse;

  final Rx<AppViewState> _appViewState = AppViewState.idel.obs;

  AppViewState get appViewState => _appViewState.value;

  CampaignResponse get campaignResponse => _campaignResponse;

  void getCampaign() async {
    try {
      _appViewState.value = AppViewState.loading;
      String? accessToken = GetStorageService.getAccessToken();
      _campaignResponse = await campaignRepository.getAllCampaigns(
        accessToken: accessToken ?? "",
      );
      _appViewState.value = AppViewState.sucess;
    } on UnauthorizedException catch (e) {
      Get.offAllNamed(AppNamedRoute.loginView);
      Get.snackbar("Unauthorized", e.errorMessage);
    } on AppException catch (e) {
      _errorMessage = e.errorMessage;
      _appViewState.value = AppViewState.error;
    } catch (e) {
      _errorMessage = "Something went wrong";
      log("The error is $e");
      _appViewState.value = AppViewState.error;
    }
  }

  void getNearestCampaign() async {
    try {} catch (e) {
      _appViewState.value = AppViewState.error;
    }
  }

  void participateInCampaign({required String campaignId}) async {
    try {
      _isLoadingMap[campaignId] = true;
      update([campaignId]);
      String? accessToken = GetStorageService.getAccessToken();
      await campaignRepository.participateInCampaign(
          accessToken: accessToken ?? "", campaignId: campaignId);
      var data = campaignResponse.data
          .where((element) => element.id == campaignId)
          .toList();
      data.first.isAlreadyParticipated = true;
      _appViewState.value = AppViewState.sucess;
      _isLoadingMap[campaignId] = false;
      update([campaignId]);
    } on UnauthorizedException catch (e) {
      Get.snackbar("Unauthorized", e.errorMessage);
      Get.offAllNamed(AppNamedRoute.loginView);
    } on AppException catch (e) {
      _isLoadingMap[campaignId] = false;
      update([campaignId]);
      _errorMessage = e.errorMessage;
      _appViewState.value = AppViewState.error;
    } catch (e) {
      _isLoadingMap[campaignId] = false;
      _appViewState.value = AppViewState.error;
      _errorMessage = "Something went wrong";
      update([campaignId]);
    }
  }
}
