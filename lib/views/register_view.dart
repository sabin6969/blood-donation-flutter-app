import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/controllers/register_controller.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:blood_donation_flutter_app/utils/custom_auth_button.dart';
import 'package:blood_donation_flutter_app/utils/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  RegisterController registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Register",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: size.width * 0.15,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              CustomTextField(
                hintText: "Full Name",
                prefixIcon: const Icon(
                  Icons.person,
                ),
                controller: registerController.fullNameController,
                textInputType: TextInputType.name,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              CustomTextField(
                hintText: "Email",
                prefixIcon: const Icon(Icons.email),
                controller: registerController.emailController,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              CustomTextField(
                hintText: "Password",
                prefixIcon: const Icon(Icons.lock),
                controller: registerController.emailController,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              CustomTextField(
                hintText: "Phone Number",
                prefixIcon: const Icon(Icons.phone),
                controller: registerController.emailController,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              DropdownMenu(
                width: size.width * 0.9,
                label: const Text("Select your Blood Group"),
                leadingIcon: const Icon(
                  Icons.bloodtype,
                ),
                dropdownMenuEntries: registerController.bloodGroups.map((e) {
                  return DropdownMenuEntry(value: e, label: e);
                }).toList(),
                onSelected: (value) =>
                    registerController.selectedBloodGroup = value,
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              CustomAuthButton(
                onPressed: () {},
                buttonColor: Colors.red,
                child: const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.loginView);
                    },
                    child: const Text("Login"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
