import 'package:blood_donation_flutter_app/core/static/app_strings.dart';
import 'package:blood_donation_flutter_app/core/static/app_image_path.dart';
import 'package:blood_donation_flutter_app/models/onboarding_content_model.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxService {
  RxInt currentIndex = RxInt(0);

  List<OnboardingContent> onboadingContents = [
    OnboardingContent(
        imagePath: AppImagePath.onboardingFirstImagePath,
        mainTitle: AppStrings.onboardingFirstTitle,
        subTitile: AppStrings.onboardingFirstSubtitle),
    OnboardingContent(
      imagePath: AppImagePath.onboardingSecondImagePath,
      mainTitle: AppStrings.onboardingSecondTitle,
      subTitile: AppStrings.onboardingSecondSubtitle,
    ),
  ];
}
