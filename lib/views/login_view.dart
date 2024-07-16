import 'package:blood_donation_flutter_app/constants/image_path.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:blood_donation_flutter_app/utils/custom_auth_button.dart';
import 'package:blood_donation_flutter_app/utils/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.05,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Image.asset(
                    ImagePath.bloodImagePath,
                    height: size.height * 0.2,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  const CustomTextField(
                    hintText: "Email",
                    prefixIcon: Icon(
                      Icons.email,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  const CustomTextField(
                    hintText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  CustomAuthButton(
                    buttonName: "Log In",
                    textColor: Colors.white,
                    buttonColor: Colors.red,
                    onPressed: () {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Register now",
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
