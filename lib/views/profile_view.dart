import 'package:blood_donation_flutter_app/constants/app_lottie_animations.dart';
import 'package:blood_donation_flutter_app/controllers/profile_controller.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
          return buildLoadingProfile();
        } else if (controller.hasError.value) {
          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchProfile();
            },
            child: ListView(
              children: [
                LottieBuilder.asset(
                  AppLottieAnimations.errorLottieAnimationPath,
                ),
                Center(
                  child: Text(
                    controller.errorMessage ?? "An unknown error occured",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return buildProfile(controller: controller);
        }
      },
    );
  }

  SafeArea buildProfile({required ProfileController controller}) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          controller.fetchProfile();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.015,
          ),
          child: Skeletonizer(
            enabled: controller.isLoading.value,
            child: ListView(
              children: [
                Container(
                  height: size.height * 0.25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        controller.response.data.first.imageUrl!,
                      ),
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
                    controller.response.data.first.fullName ?? "",
                  ),
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.email,
                      ),
                      title: const Text("Email"),
                      subtitle: Text(
                        controller.response.data.first.email ?? "",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.bloodtype,
                      ),
                      title: const Text("Blood Group"),
                      subtitle: Text(
                        controller.response.data.first.bloodGroup ?? "",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.phone,
                      ),
                      title: const Text("Phone Number"),
                      subtitle: Text(
                        controller.response.data.first.phoneNumber ?? "",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.volunteer_activism,
                      ),
                      title: const Text("Requested for Blood"),
                      subtitle: Text(
                          "${controller.response.data.first.bloodRequestCount} times"),
                    )
                  ],
                ),
                SwitchListTile(
                  title: const Text("Available for donation"),
                  value:
                      controller.response.data.first.isAvailableForDonation ??
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
                  onTap: () {
                    Get.dialog(AlertDialog(
                      title: const Text(
                        "Logout?",
                      ),
                      content: const Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                            controller.logout();
                          },
                          child: const Text(
                            "Yes",
                          ),
                        ),
                      ],
                    ));
                  },
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
      ),
    );
  }
}

SafeArea buildLoadingProfile() {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.015,
      ),
      child: Skeletonizer(
        enabled: true,
        child: ListView(
          children: [
            Container(
              height: size.height * 0.25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300], // Placeholder color for loading
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            ExpansionTile(
              leading: Icon(
                Icons.person,
                color: Colors.grey[300], // Placeholder color for loading
              ),
              title: Container(
                height: 20,
                color: Colors.grey[300], // Placeholder color for loading
              ),
            ),
            SwitchListTile(
              title: Container(
                height: 20,
                color: Colors.grey[300], // Placeholder color for loading
              ),
              value: false,
              onChanged: null, // Disable switch during loading
            ),
            Divider(
              color: Colors.grey[300], // Placeholder color for loading
            ),
            ListTile(
              leading: Icon(
                Icons.share,
                color: Colors.grey[300], // Placeholder color for loading
              ),
              title: Container(
                height: 20,
                color: Colors.grey[300], // Placeholder color for loading
              ),
            ),
            Divider(
              color: Colors.grey[300], // Placeholder color for loading
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.grey[300], // Placeholder color for loading
              ),
              title: Container(
                height: 20,
                color: Colors.grey[300], // Placeholder color for loading
              ),
            ),
            Divider(
              color: Colors.grey[300], // Placeholder color for loading
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.grey[300], // Placeholder color for loading
              ),
              title: Container(
                height: 20,
                color: Colors.grey[300], // Placeholder color for loading
              ),
              subtitle: Container(
                height: 20,
                color: Colors.grey[300], // Placeholder color for loading
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
