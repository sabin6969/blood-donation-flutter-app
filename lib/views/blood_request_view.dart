import 'package:blood_donation_flutter_app/controllers/blood_request_controller.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:blood_donation_flutter_app/utils/widgets/custom_auth_button.dart';
import 'package:blood_donation_flutter_app/utils/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BloodRequestView extends StatefulWidget {
  const BloodRequestView({super.key});

  @override
  State<BloodRequestView> createState() => _RequestBloodViewState();
}

class _RequestBloodViewState extends State<BloodRequestView> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Create a Blood Request",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          child: Form(
            key: Get.find<BloodRequestController>().formKey,
            child: Column(
              children: [
                CustomTextField(
                  hintText: "Enter City Name",
                  prefixIcon: const Icon(
                    Icons.location_city,
                  ),
                  controller: Get.find<BloodRequestController>().cityController,
                  textInputType: TextInputType.streetAddress,
                  validator: (value) => value == null || value.isEmpty
                      ? "This field is required"
                      : null,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                CustomTextField(
                  hintText: "Enter Hospital Name",
                  prefixIcon: const Icon(Icons.local_hospital),
                  controller:
                      Get.find<BloodRequestController>().hospitalController,
                  textInputType: TextInputType.name,
                  validator: (value) => value == null || value.isEmpty
                      ? "This field is required"
                      : null,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                DropdownMenu(
                  width: size.width * 0.9,
                  label: const Text("Select Required Blood Group"),
                  leadingIcon: const Icon(Icons.bloodtype),
                  dropdownMenuEntries:
                      Get.find<BloodRequestController>().bloodGroups.map((e) {
                    return DropdownMenuEntry(value: e, label: e);
                  }).toList(),
                  onSelected: (value) =>
                      Get.find<BloodRequestController>().requestedBlood = value,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                CustomTextField(
                  hintText: "Note",
                  prefixIcon: const Icon(Icons.notes),
                  controller: Get.find<BloodRequestController>().noteController,
                  textInputType: TextInputType.text,
                  validator: null,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                GetX<BloodRequestController>(
                  builder: (controller) {
                    return CustomAuthButton(
                      buttonColor: Colors.red,
                      onPressed: () {
                        Get.find<BloodRequestController>().requestForBlood();
                      },
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Request Blood",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
