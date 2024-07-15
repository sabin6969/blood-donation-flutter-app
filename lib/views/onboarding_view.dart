import 'package:blood_donation_flutter_app/constants/app_strings.dart';
import 'package:blood_donation_flutter_app/constants/image_path.dart';
import 'package:blood_donation_flutter_app/models/onboarding_content_model.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => OnboardingViewState();
}

class OnboardingViewState extends State<OnboardingView> {
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

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: PageView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: pageController,
              itemCount: onboadingContents.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(),
                    Image.asset(
                      onboadingContents[index].imagePath,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      onboadingContents[index].mainTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      onboadingContents[index].subTitile,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SmoothPageIndicator(
                      controller: pageController,
                      onDotClicked: (index) {
                        pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      },
                      effect: const WormEffect(),
                      count: 2,
                    ),
                    const Spacer(),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Skip",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                    );
                  },
                  child: const Text(
                    "Next",
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
