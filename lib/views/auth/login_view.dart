import 'package:blood_donation_flutter_app/core/routes/app_named_route.dart';
import 'package:blood_donation_flutter_app/core/static/app_image_path.dart';
import 'package:blood_donation_flutter_app/controllers/login_controller.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:blood_donation_flutter_app/utils/widgets/custom_auth_button.dart';
import 'package:blood_donation_flutter_app/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_button/animated_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController loginController = Get.find<LoginController>();

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
              child: Form(
                key: loginController.formKeyForLogin,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Image.asset(
                      AppImagePath.loginImage,
                      width: size.width * 0.8,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    CustomTextField(
                      controller: loginController.emailController,
                      textInputType: TextInputType.emailAddress,
                      hintText: "Email",
                      prefixIcon: const Icon(
                        Icons.email,
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "Email is required"
                          : value.isEmail
                              ? null
                              : "Please enter a valid email",
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GetX<LoginController>(builder: (controller) {
                      return CustomTextField(
                        controller: loginController.passwordController,
                        validator: (value) => value == null || value.isEmpty
                            ? "Password is required"
                            : null,
                        textInputType: TextInputType.visiblePassword,
                        hintText: "Password",
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        isObsecure: controller.isPasswordVisible.value,
                        suffixIconButton: IconButton(
                          onPressed: () {
                            controller.isPasswordVisible.value =
                                !controller.isPasswordVisible.value;
                          },
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    GetX<LoginController>(builder: (controller) {
                      return AnimatedButton(
                        isLoading: controller.isLoading.value,
                        color: Colors.red,
                        onTap: () {
                          loginController.login(
                            email: loginController.emailController.text,
                            password: loginController.passwordController.text,
                          );
                        },
                        buttonName: "Log In",
                        height: size.height * 0.07,
                        radius: BorderRadius.circular(20),
                        width: size.width,
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(AppNamedRoute.signupView);
                          },
                          child: const Text(
                            "Register now",
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
