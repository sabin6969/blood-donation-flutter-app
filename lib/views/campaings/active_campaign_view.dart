import 'package:blood_donation_flutter_app/core/const/app_enums.dart';
import 'package:blood_donation_flutter_app/core/static/app_image_path.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:blood_donation_flutter_app/utils/widgets/toast_message.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/campaign/campaign_controller.dart';
import 'widgets/campaign_card.dart';

class ActiveCampaingView extends StatefulWidget {
  const ActiveCampaingView({super.key});

  @override
  State<ActiveCampaingView> createState() => _ActiveCampaingViewState();
}

class _ActiveCampaingViewState extends State<ActiveCampaingView> {
  @override
  void initState() {
    Get.find<CampaignController>().getCampaign();
    super.initState();
  }

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

  // void _askForCampaignParticipationConfirmation(
  //     {required CampaingController controller, required int index}) {
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text("Participation Confirmation"),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Get.back();
  //               controller.particupateInCampaign(
  //                 campaignId: controller.campaignResponse!.data[index].id!,
  //               );
  //             },
  //             style: const ButtonStyle(
  //               backgroundColor: WidgetStatePropertyAll(
  //                 Colors.green,
  //               ),
  //             ),
  //             child: const Text(
  //               "Yes",
  //               style: TextStyle(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Get.back();
  //             },
  //             style: const ButtonStyle(
  //               backgroundColor: WidgetStatePropertyAll(
  //                 Colors.red,
  //               ),
  //             ),
  //             child: const Text(
  //               "No",
  //               style: TextStyle(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           )
  //         ],
  //         content: const Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //                 "Are you sure you want to participate in this blood donation campaign? Once registered, you cannot unregister")
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: GetX<CampaignController>(
        builder: (controller) {
          switch (controller.appViewState) {
            case AppViewState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case AppViewState.sucess:
              return controller.campaignResponse.data.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            AppImagePath.emptyCartImage,
                            height: size.height * 0.35,
                            width: size.width * 0.6,
                          ),
                        ),
                        const Text("No active campaigns"),
                        TextButton(
                          onPressed: () {
                            controller.getCampaign();
                          },
                          child: const Text(
                            "Refresh",
                          ),
                        )
                      ],
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        controller.getCampaign();
                      },
                      child: ListView.builder(
                        itemCount: controller.campaignResponse.data.length,
                        itemBuilder: (context, index) {
                          return CampaignCard(
                            index: index,
                            campaignResponse: controller.campaignResponse,
                            campaignController: controller,
                          );
                        },
                      ),
                    );
            case AppViewState.error:
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      AppImagePath.errorIcon,
                      height: size.height * 0.35,
                      width: size.width * 0.6,
                    ),
                  ),
                  Text(controller.errorMessage ?? ""),
                  TextButton(
                    onPressed: () {
                      controller.getCampaign();
                    },
                    child: const Text(
                      "Retry",
                    ),
                  )
                ],
              );
            case AppViewState.idel:
              return const Center(
                child: Text("Idel State"),
              );
          }
        },
      ),
    );
  }
}
