import 'package:blood_donation_flutter_app/controllers/splash_controller.dart';
import 'package:blood_donation_flutter_app/core/static/app_image_path.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Get.find<SplashController>().navigateUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              AppImagePath.bloodDonationIcon,
              height: size.height * 0.1,
              width: size.width * 0.2,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 20,
              ),
              child: Theme(
                data: ThemeData(
                  platform: TargetPlatform.iOS,
                ),
                child: Transform.scale(
                  scale: 1.5,
                  child: const CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
