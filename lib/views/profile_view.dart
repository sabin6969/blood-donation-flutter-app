import 'package:blood_donation_flutter_app/controllers/profile_controller.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileView> {
  @override
  void initState() {
    Get.put(ProfileController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return GetX<ProfileController>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.hasError.value) {
          return Center(
            child: Text(controller.errorMessage ?? "An unknown error occured"),
          );
        } else {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.015,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: size.width * 0.2,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          size.width * 0.5,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: controller.response.data!.imageUrl!,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    ExpansionTile(
                      leading: const Icon(
                        Icons.person,
                      ),
                      title: Text(
                        controller.response.data!.fullName ?? "",
                      ),
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.email,
                          ),
                          title: Text(
                            controller.response.data!.email ?? "",
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.bloodtype,
                          ),
                          title: Text(
                            controller.response.data!.bloodGroup ?? "",
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.phone,
                          ),
                          title: Text(
                            controller.response.data!.phoneNumber ?? "",
                          ),
                        )
                      ],
                    ),
                    SwitchListTile(
                      title: const Text("Available for donation"),
                      value: controller.response.data!.isAvailableForDonation ??
                          false,
                      onChanged: (value) {},
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.share),
                      title: const Text("Invite a friend"),
                      onTap: () {
                        Get.snackbar(
                            "Comming Soon", "This feature is comming soon");
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.help),
                      onTap: () {
                        Get.snackbar(
                            "Comming soon", "This feature is comming soon");
                      },
                      title: const Text("Get Help"),
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Icons.logout,
                      ),
                      subtitle: const Text("Logout from this device"),
                      title: const Text("Logout"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
