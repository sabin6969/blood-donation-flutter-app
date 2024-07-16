import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/controllers/onboarding_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => OnboardingViewState();
}

class OnboardingViewState extends State<OnboardingView> {
  OnboardingController onboardingController = Get.find<OnboardingController>();

  @override
  void initState() {
    onboardingController.pageController.addListener(() {
      onboardingController.currentIndex.value =
          onboardingController.pageController.page?.round() ?? 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: PageView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: onboardingController.pageController,
              itemCount: onboardingController.onboadingContents.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Spacer(),
                    Image.asset(
                      onboardingController.onboadingContents[index].imagePath,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      onboardingController.onboadingContents[index].mainTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      onboardingController.onboadingContents[index].subTitile,
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
                      controller: onboardingController.pageController,
                      onDotClicked: (index) {
                        onboardingController.pageController.animateToPage(
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
            child: GetX<OnboardingController>(
              builder: (controller) {
                // Displaying Get Started button on the last onboarding page
                if (controller.currentIndex.value ==
                    onboardingController.onboadingContents.length - 1) {
                  return TextButton(
                    onPressed: () {
                      Get.offNamed(AppRoutes.loginSignupView);
                    },
                    child: const Text(
                      "Get Started",
                    ),
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          onboardingController.pageController.animateToPage(
                            onboardingController.onboadingContents.length - 1,
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text(
                          "Skip",
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          onboardingController.pageController.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text(
                          "Next",
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
