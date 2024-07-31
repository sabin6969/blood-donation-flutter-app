import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/constants/image_path.dart';
import 'package:blood_donation_flutter_app/controllers/register_controller.dart';
import 'package:blood_donation_flutter_app/utils/widgets/custom_auth_button.dart';
import 'package:blood_donation_flutter_app/utils/widgets/custom_text_field.dart';
import 'package:blood_donation_flutter_app/utils/image_picker_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  late RegisterController registerController;

  @override
  void initState() {
    super.initState();
    registerController = Get.put(RegisterController());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Form(
            key: registerController.formKeyForRegistration,
            child: Column(
              children: [
                GetX<RegisterController>(
                  builder: (controller) {
                    return Stack(
                      children: [
                        CircleAvatar(
                          radius: size.width * 0.15,
                          backgroundImage: controller.imageFile.value == null
                              ? AssetImage(ImagePath.profileAvatarPath)
                                  as ImageProvider
                              : FileImage(
                                  File(
                                    controller.imageFile.value!.path,
                                  ),
                                ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            radius: size.width * 0.05,
                            backgroundColor: Colors.blue.shade200,
                            child: IconButton(
                              onPressed: () async {
                                registerController.imageFile.value =
                                    await ImagePickerUtility
                                        .pickImageFromGallery();
                              },
                              icon: const Icon(Icons.edit),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
                SizedBox(height: size.height * 0.015),
                CustomTextField(
                  hintText: "Full Name",
                  textCapitalization: TextCapitalization.words,
                  prefixIcon: const Icon(Icons.person),
                  controller: registerController.fullNameController,
                  textInputType: TextInputType.name,
                  validator: (value) => value == null || value.isEmpty
                      ? "Full Name is required"
                      : null,
                ),
                SizedBox(height: size.height * 0.015),
                CustomTextField(
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  controller: registerController.emailController,
                  textInputType: TextInputType.emailAddress,
                  validator: (value) => value == null || value.isEmpty
                      ? "Email is required"
                      : value.isEmail
                          ? null
                          : "Please enter a valid email address",
                ),
                SizedBox(height: size.height * 0.015),
                GetX<RegisterController>(
                  builder: (controller) {
                    return CustomTextField(
                      hintText: "Password",
                      isObsecure: registerController.isPasswordVisible.value,
                      suffixIconButton: IconButton(
                        onPressed: () {
                          registerController.isPasswordVisible.value =
                              !registerController.isPasswordVisible.value;
                        },
                        icon: Icon(
                          registerController.isPasswordVisible.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      controller: registerController.passwordController,
                      textInputType: TextInputType.visiblePassword,
                      validator: (value) => value == null || value.isEmpty
                          ? "Password is required"
                          : value.length < 5
                              ? "Enter a Strong password"
                              : null,
                    );
                  },
                ),
                SizedBox(height: size.height * 0.015),
                CustomTextField(
                  hintText: "Phone Number",
                  prefixIcon: const Icon(Icons.phone),
                  controller: registerController.phoneNumberController,
                  textInputType: TextInputType.phone,
                  validator: (value) => value == null || value.isEmpty
                      ? "Phone Number is required"
                      : value.isPhoneNumber
                          ? null
                          : "Enter a valid phone number",
                  maxLength: 10,
                ),
                SizedBox(height: size.height * 0.015),
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 200),
                  child: DropdownMenu(
                    width: size.width * 0.9,
                    label: const Text("Select your Blood Group"),
                    leadingIcon: const Icon(Icons.bloodtype),
                    dropdownMenuEntries:
                        registerController.bloodGroups.map((e) {
                      return DropdownMenuEntry(value: e, label: e);
                    }).toList(),
                    onSelected: (value) =>
                        registerController.selectedBloodGroup = value,
                  ),
                ),
                SizedBox(height: size.height * 0.015),
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 600),
                  child: GetX<RegisterController>(
                    builder: (controller) {
                      return CheckboxListTile(
                        value: controller.isAvailableForDonation.value,
                        onChanged: (value) {
                          controller.isAvailableForDonation.value = value!;
                        },
                        title: const Text(
                          "Are you currently available for donation?",
                        ),
                      );
                    },
                  ),
                ),
                GetX<RegisterController>(
                  builder: (controller) {
                    return CustomAuthButton(
                      onPressed: () {
                        registerController.registerUser();
                      },
                      buttonColor: Colors.red,
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Register",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                    );
                  },
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
