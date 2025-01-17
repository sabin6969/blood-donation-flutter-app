import 'package:blood_donation_flutter_app/core/routes/app_named_route.dart';
import 'package:blood_donation_flutter_app/controllers/onboarding_controller.dart';
import 'package:blood_donation_flutter_app/services/get_storage_service.dart';

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

  late PageController _pageController;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _pageController = PageController();
    _pageController.addListener(() {
      onboardingController.currentIndex.value =
          _pageController.page?.round() ?? 0;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
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
                        controller: _pageController,
                        onDotClicked: (index) {
                          _pageController.animateToPage(
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
            GetX<OnboardingController>(
              builder: (controller) {
                // Displaying Get Started button on the last onboarding page
                if (controller.currentIndex.value ==
                    onboardingController.onboadingContents.length - 1) {
                  return TextButton(
                    onPressed: () {
                      GetStorageService.setAsOnboarded();
                      Get.offNamed(AppNamedRoute.loginSignupView);
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
                          _pageController.animateToPage(
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
                          _pageController.nextPage(
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
            )
          ],
        ),
      ),
    );
  }
}
