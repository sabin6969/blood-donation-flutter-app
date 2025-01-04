import 'package:blood_donation_flutter_app/core/static/app_lottie_animations.dart';
import 'package:blood_donation_flutter_app/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NoInternetView extends StatefulWidget {
  const NoInternetView({super.key});

  @override
  State<NoInternetView> createState() => _NoInternetViewState();
}

class _NoInternetViewState extends State<NoInternetView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            AppLottieAnimationPath.errorLottieAnimationPath,
          ),
          const Text(
            "Please check your internet connection",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
              Get.find<SplashController>().verifyAuthToken();
            },
            child: const Text("Try Again"),
          )
        ],
      ),
    );
  }
}
