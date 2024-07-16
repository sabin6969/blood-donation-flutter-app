import 'package:blood_donation_flutter_app/constants/app_strings.dart';
import 'package:blood_donation_flutter_app/constants/image_path.dart';
import 'package:blood_donation_flutter_app/models/onboarding_content_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxService {
  PageController pageController = PageController();
  RxInt currentIndex = RxInt(0);

  List<OnboardingContent> onboadingContents = [
    OnboardingContent(
        imagePath: ImagePath.onboardingFirstImagePath,
        mainTitle: AppStrings.onboardingFirstTitle,
        subTitile: AppStrings.onboardingFirstSubtitle),
    OnboardingContent(
      imagePath: ImagePath.onboardingSecondImagePath,
      mainTitle: AppStrings.onboardingSecondTitle,
      subTitile: AppStrings.onboardingSecondSubtitle,
    ),
  ];
}
