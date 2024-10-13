import 'package:blood_donation_flutter_app/constants/app_lottie_animations.dart';
import 'package:blood_donation_flutter_app/constants/app_routes.dart';
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
    Get.lazyPut(() => ProfileController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return GetX<ProfileController>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return buildProfileShimmer();
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
              ],
            ),
          );
        } else if (controller.isLoading.value == false) {
          return buildProfile(controller: controller);
        }
        return const SizedBox();
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
            horizontal: size.width * 0.04,
            vertical: size.height * 0.01,
          ),
          child: Skeletonizer(
            enabled: controller.isLoading.value,
            child: ListView(
              children: [
                Container(
                  height: size.height * 0.25,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 6,
                        spreadRadius: 1,
                      )
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        controller.response.data.first.imageUrl!,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SettingTileWrapper(
                  controller: controller,
                  childrens: [
                    ListTile(
                      leading: const Icon(
                        Icons.email,
                      ),
                      title: const Text("Email"),
                      subtitle: Text(
                        controller.response.data.first.email ?? "",
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.blue,
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
                    const Divider(
                      thickness: 1,
                      color: Colors.blue,
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
                    const Divider(
                      thickness: 1,
                      color: Colors.blue,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.volunteer_activism,
                      ),
                      title: const Text("Requested for Blood"),
                      subtitle: Text(
                        "${controller.response.data.first.bloodRequestCount} Times",
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.blue,
                    ),
                    Obx(
                      () => SwitchListTile(
                        value: controller.isAvailableForDonation.value,
                        onChanged: (value) {
                          controller.updateDonationAvailability(
                            isAvailableForDonation: value,
                          );
                        },
                        title: const Text(
                          "Available for Donation",
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                SettingTileWrapper(
                  controller: controller,
                  childrens: [
                    ListTile(
                      leading: const Icon(Icons.share),
                      title: const Text("Invite a friend"),
                      onTap: () {
                        Get.snackbar(
                            "Comming Soon", "This feature is comming soon");
                      },
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.blue,
                    ),
                    ListTile(
                      leading: const Icon(Icons.help),
                      onTap: () {
                        Get.snackbar(
                            "Comming soon", "This feature is comming soon");
                      },
                      title: const Text("Get Help"),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.blue,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.notifications,
                      ),
                      onTap: () {
                        Get.toNamed(AppRoutes.notificationConfigurationView);
                      },
                      title: const Text(
                        "Manage Notifications",
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                InkWell(
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        title: const Text(
                          "Logout Confirmation",
                        ),
                        content:
                            const Text("Are you sure you want to log out?"),
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
                      ),
                    );
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        11,
                      ),
                      color: Colors.red.shade200,
                      border: const Border(
                        top: BorderSide(
                          width: 2,
                          color: Colors.red,
                        ),
                        left: BorderSide(
                          width: 2,
                          color: Colors.red,
                        ),
                        right: BorderSide(
                          width: 2,
                          color: Colors.red,
                        ),
                        bottom: BorderSide(
                          width: 6,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    child: const ListTile(
                      leading: Icon(
                        Icons.logout,
                      ),
                      subtitle: Text(
                        "Logout from this device",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingTileWrapper extends StatelessWidget {
  final ProfileController controller;
  final List<Widget> childrens;
  const SettingTileWrapper({
    super.key,
    required this.controller,
    required this.childrens,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          11,
        ),
        border: const Border(
          top: BorderSide(
            width: 2,
            color: Colors.blue,
          ),
          left: BorderSide(
            width: 2,
            color: Colors.blue,
          ),
          right: BorderSide(
            width: 2,
            color: Colors.blue,
          ),
          bottom: BorderSide(
            width: 6,
            color: Colors.blue,
          ),
        ),
      ),
      child: Column(
        children: [
          ...childrens,
        ],
      ),
    );
  }
}

Widget buildProfileShimmer() {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: size.width * 0.04,
      vertical: size.height * 0.01,
    ),
    child: Skeletonizer(
      enabled: true,
      child: ListView(
        children: [
          Container(
            height: size.height * 0.25,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  spreadRadius: 1,
                  color: Colors.grey.shade200,
                )
              ],
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          const ListTile(
            leading: Icon(
              Icons.email,
            ),
            title: Text("Email"),
            subtitle: Text(
              "Email Address",
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.bloodtype,
            ),
            title: Text("Blood Group"),
            subtitle: Text(
              "Blood Group",
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.phone,
            ),
            title: Text("Phone Number"),
            subtitle: Text(
              "Phone Number",
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.volunteer_activism,
            ),
            title: Text("Requested for Blood"),
            subtitle: Text("This is subtitle"),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          const ListTile(
            leading: Icon(Icons.share),
            title: Text("Invite a friend"),
          ),
          const ListTile(
            leading: Icon(Icons.help),
            title: Text("Get Help"),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
        ],
      ),
    ),
  );
}
