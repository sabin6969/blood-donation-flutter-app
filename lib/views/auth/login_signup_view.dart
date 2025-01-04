import 'package:blood_donation_flutter_app/core/routes/app_named_route.dart';
import 'package:blood_donation_flutter_app/core/static/image_path.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:blood_donation_flutter_app/utils/widgets/custom_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginSignupView extends StatefulWidget {
  const LoginSignupView({super.key});

  @override
  State<LoginSignupView> createState() => _LoginSignupViewState();
}

class _LoginSignupViewState extends State<LoginSignupView> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Image.asset(
                    AppImagePath.bloodImagePath,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Dare to Donate",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "You can donate for ones in need and request blood if you need.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: Column(
                children: [
                  CustomAuthButton(
                    buttonColor: Colors.red.shade100,
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      Get.offNamed(AppNamedRoute.loginView);
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  CustomAuthButton(
                    buttonColor: Colors.red,
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Get.offNamed(AppNamedRoute.signupView);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
