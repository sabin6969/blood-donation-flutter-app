import 'package:blood_donation_flutter_app/constants/app_lottie_animations.dart';
import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/controllers/campaign_controller.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:blood_donation_flutter_app/utils/widgets/custom_auth_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ActiveCampaingView extends StatefulWidget {
  const ActiveCampaingView({super.key});

  @override
  State<ActiveCampaingView> createState() => _ActiveCampaingViewState();
}

class _ActiveCampaingViewState extends State<ActiveCampaingView> {
  @override
  void initState() {
    Get.find<CampaingController>().fetchActiveCampaign();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: GetX<CampaingController>(
        builder: (controller) {
          if (controller.isActiveCampaignLoading.value) {
            return Center(
              child:
                  Lottie.asset(AppLottieAnimations.loadingLottieAnimationPath),
            );
          } else if (controller.isAllCampaignLoaded.value) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.fetchActiveCampaign();
              },
              child: controller.campaignResponse.data!.isEmpty
                  ? ListView(
                      children: [
                        Lottie.asset(
                            AppLottieAnimations.errorLottieAnimationPath),
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "There are no active campaings right now",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: controller.campaignResponse.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.02,
                          ),
                          child: Card(
                            child: ExpansionTile(
                              title: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        controller.campaignResponse.data![index]
                                                .campaignName ??
                                            "Campaign Name",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              childrenPadding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05,
                              ),
                              expandedAlignment: Alignment.topLeft,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.date_range,
                                    ),
                                    Text(
                                      controller.campaignResponse.data![index]
                                              .date ??
                                          "Date",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.schedule,
                                    ),
                                    Text(
                                      controller.campaignResponse.data![index]
                                              .time ??
                                          "Date",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Organizer's Detail",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        controller.campaignResponse.data![index]
                                            .campaignOrganizedBy!.imageUrl!,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(Icons.person_outline),
                                    Text(
                                      controller.campaignResponse.data![index]
                                              .campaignOrganizedBy!.fullName ??
                                          "Organizer's Name",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(Icons.email_outlined),
                                    Text(
                                      controller.campaignResponse.data![index]
                                              .campaignOrganizedBy!.email ??
                                          "Email address",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(Icons.phone_outlined),
                                    Text(
                                      controller
                                              .campaignResponse
                                              .data![index]
                                              .campaignOrganizedBy!
                                              .phoneNumber ??
                                          "Phone Number",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomAuthButton(
                                  buttonColor: Colors.blue,
                                  onPressed: () {
                                    Get.toNamed(
                                      AppRoutes.gooleMapView,
                                      arguments: {
                                        "lat": controller
                                            .campaignResponse
                                            .data![index]
                                            .location!
                                            .coordinates!
                                            .first,
                                        "lng": controller
                                            .campaignResponse
                                            .data![index]
                                            .location!
                                            .coordinates![1],
                                      },
                                    );
                                  },
                                  child: const Text(
                                    "View Location on Map",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Something went wrong"),
                  TextButton(
                    onPressed: () {
                      controller.fetchActiveCampaign();
                    },
                    child: const Text(
                      "Try Again",
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
