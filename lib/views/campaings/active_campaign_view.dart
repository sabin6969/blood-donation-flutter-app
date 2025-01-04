import 'package:blood_donation_flutter_app/core/static/app_image_path.dart';
import 'package:blood_donation_flutter_app/core/static/app_lottie_animations_path.dart';
import 'package:blood_donation_flutter_app/core/routes/app_named_route.dart';
import 'package:blood_donation_flutter_app/controllers/campaign_controller.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:blood_donation_flutter_app/utils/widgets/toast_message.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ActiveCampaingView extends StatefulWidget {
  const ActiveCampaingView({super.key});

  @override
  State<ActiveCampaingView> createState() => _ActiveCampaingViewState();
}

class _ActiveCampaingViewState extends State<ActiveCampaingView> {
  void _displayOrganizersDetails({
    required String name,
    required String email,
    required String phoneNumber,
    required String imageUrl,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          elevation: 3,
          title: const Text("Organizer's Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: CachedNetworkImageProvider(
                  imageUrl,
                ),
              ),
              _organizersDetailRow(
                data: name,
                icon: Icons.person,
              ),
              _organizersDetailRow(
                data: email,
                icon: Icons.email,
                onPressed: () async {
                  Uri emailUri = Uri.parse(
                      "mailto:$email?subject=Assistance with Blood Donation Campaign");
                  try {
                    if (await canLaunchUrl(emailUri)) {
                      launchUrl(emailUri);
                    }
                  } catch (e) {
                    showToastMessage(message: "Failed to redirect to gmail");
                  }
                },
              ),
              _organizersDetailRow(
                data: phoneNumber,
                icon: Icons.call,
                onPressed: () async {
                  try {
                    Uri uri = Uri.parse("tel:+977 $phoneNumber");
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  } catch (e) {
                    showToastMessage(
                      message: "Failed to redirect to phone call",
                    );
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  Row _organizersDetailRow({
    required String data,
    required IconData icon,
    void Function()? onPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          disabledColor: Colors.black,
        ),
        Text(
          data,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  void _askForCampaignParticipationConfirmation(
      {required CampaingController controller, required int index}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Participation Confirmation"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                controller.particupateInCampaign(
                  campaignId: controller.campaignResponse!.data[index].id!,
                );
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.green,
                ),
              ),
              child: const Text(
                "Yes",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.red,
                ),
              ),
              child: const Text(
                "No",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "Are you sure you want to participate in this blood donation campaign? Once registered, you cannot unregister")
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: GetX<CampaingController>(
        builder: (controller) {
          if (controller.isActiveCampaignLoading.value) {
            return Center(
              child: Lottie.asset(
                  AppLottieAnimationPath.loadingLottieAnimationPath),
            );
          } else if (controller.campaignResponse != null) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.fetchActiveCampaign();
              },
              child: controller.campaignResponse!.data.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImagePath.emptyCartImage,
                          height: size.height * 0.35,
                          width: size.width,
                        ),
                        const Text(
                          "There are no active campaings right now",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.fetchActiveCampaign();
                          },
                          child: const Text(
                            "Refresh",
                          ),
                        )
                      ],
                    )
                  : ListView.builder(
                      itemCount: controller.campaignResponse!.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.03,
                            vertical: size.height * 0.01,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: size.height * 0.01,
                            ),
                            constraints: BoxConstraints(
                              minHeight: size.height * 0.3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFE082),
                              // color: Colors.green,
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                              border: const Border(
                                top: BorderSide(
                                  color: Colors.black,
                                  width: 3,
                                ),
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 3,
                                ),
                                left: BorderSide(
                                  width: 3,
                                  color: Colors.black,
                                ),
                                bottom: BorderSide(
                                  width: 6,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        controller.campaignResponse!.data[index]
                                                .campaignName ??
                                            "",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        _displayOrganizersDetails(
                                          name: controller
                                              .campaignResponse!
                                              .data[index]
                                              .campaignOrganizedBy!
                                              .fullName!,
                                          email: controller
                                              .campaignResponse!
                                              .data[index]
                                              .campaignOrganizedBy!
                                              .email!,
                                          phoneNumber: controller
                                              .campaignResponse!
                                              .data[index]
                                              .campaignOrganizedBy!
                                              .phoneNumber!,
                                          imageUrl: controller
                                              .campaignResponse!
                                              .data[index]
                                              .campaignOrganizedBy!
                                              .imageUrl!,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.info,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(Icons.date_range),
                                    Text(
                                      controller
                                          .campaignResponse!.data[index].date!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(Icons.schedule),
                                    Text(
                                      controller
                                          .campaignResponse!.data[index].time!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.group,
                                    ),
                                    Text(
                                      controller.campaignResponse!.data[index]
                                                  .noOfParticipants ==
                                              0
                                          ? "Be first to Participate"
                                          : "${controller.campaignResponse!.data[index].noOfParticipants} Participants",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: controller.campaignResponse!
                                              .data[index].isAlreadyRegistered!
                                          ? null
                                          : () {
                                              _askForCampaignParticipationConfirmation(
                                                controller: controller,
                                                index: index,
                                              );
                                            },
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                          controller
                                                  .campaignResponse!
                                                  .data[index]
                                                  .isAlreadyRegistered!
                                              ? Colors.grey
                                              : Colors.blue,
                                        ),
                                      ),
                                      child: const Text(
                                        "Participate",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.toNamed(
                                          AppNamedRoute.gooleMapView,
                                          arguments: {
                                            "lat": controller
                                                .campaignResponse!
                                                .data[index]
                                                .location!
                                                .coordinates
                                                .first,
                                            "lng": controller
                                                .campaignResponse!
                                                .data[index]
                                                .location!
                                                .coordinates[1],
                                          },
                                        );
                                      },
                                      style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                          Colors.blue,
                                        ),
                                      ),
                                      child: const Text(
                                        "View in Map",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
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
