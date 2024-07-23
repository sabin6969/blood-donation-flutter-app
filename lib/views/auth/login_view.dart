import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/constants/image_path.dart';
import 'package:blood_donation_flutter_app/controllers/login_controller.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:blood_donation_flutter_app/utils/widgets/custom_auth_button.dart';
import 'package:blood_donation_flutter_app/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                key: loginController.formKey,
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
                      return CustomAuthButton(
                        buttonColor: Colors.red,
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Log In",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                        onPressed: () {
                          loginController.login(
                            email: loginController.emailController.text,
                            password: loginController.passwordController.text,
                          );
                        },
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
                            Get.toNamed(AppRoutes.signupView);
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
