import 'package:blood_donation_flutter_app/constants/app_lottie_animations.dart';
import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/controllers/campaign_controller.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:blood_donation_flutter_app/utils/widgets/custom_auth_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CampaingNearMeView extends StatefulWidget {
  const CampaingNearMeView({super.key});

  @override
  State<CampaingNearMeView> createState() => CampaingNearMeViewState();
}

class CampaingNearMeViewState extends State<CampaingNearMeView> {
  @override
  void initState() {
    Get.find<CampaingController>().fetchNearestCampaign();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<CampaingController>(
        builder: (controller) {
          if (controller.isNearestCampaignLoading.value) {
            return Center(
              child: Lottie.asset(
                AppLottieAnimations.loadingLottieAnimationPath,
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                controller.fetchNearestCampaign();
              },
              child: controller.nearestCampaignResponse.data!.isEmpty
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
                            "There are no active campaings right\nNear your location",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount:
                          controller.nearestCampaignResponse.data!.length,
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
                                        controller.nearestCampaignResponse
                                                .data![index].campaignName ??
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
                                      controller.nearestCampaignResponse
                                              .data![index].date ??
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
                                      controller.nearestCampaignResponse
                                              .data![index].time ??
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
                                        controller
                                            .nearestCampaignResponse
                                            .data![index]
                                            .campaignOrganizedBy!
                                            .imageUrl!,
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
                                      controller
                                              .nearestCampaignResponse
                                              .data![index]
                                              .campaignOrganizedBy!
                                              .fullName ??
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
                                      controller
                                              .nearestCampaignResponse
                                              .data![index]
                                              .campaignOrganizedBy!
                                              .email ??
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
                                              .nearestCampaignResponse
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
                                            .nearestCampaignResponse
                                            .data![index]
                                            .location!
                                            .coordinates!
                                            .first,
                                        "lng": controller
                                            .nearestCampaignResponse
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
          }
        },
      ),
    );
  }
}
