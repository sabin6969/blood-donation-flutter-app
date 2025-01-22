import 'dart:developer';

import 'package:blood_donation_flutter_app/controllers/campaign/campaign_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_named_route.dart';
import '../../../main.dart';
import '../../../models/campaign/campaign_response_model.dart';

class CampaignCard extends StatelessWidget {
  final CampaignResponse campaignResponse;
  final int index;
  final CampaignController campaignController;
  const CampaignCard({
    super.key,
    required this.campaignResponse,
    required this.index,
    required this.campaignController,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime =
        DateTime.parse(campaignResponse.data[index].timeStamp.toString());
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
                    campaignResponse.data[index].campaignName ?? "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.info,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.date_range),
                Text(
                  "${dateTime.year}-${dateTime.month}-${dateTime.day}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.schedule),
                Text(
                  "${dateTime.hour}:${dateTime.minute}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.group,
                ),
                Text(
                  campaignResponse.data[index].participants.isEmpty
                      ? "Be first to Participate"
                      : "${campaignResponse.data[index].participants.length} Participants",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<CampaignController>(
                  id: campaignResponse.data[index].id,
                  builder: (controller) {
                    log("The button has rebuilt");
                    log(campaignController
                        .isLoadingMap[campaignResponse.data[index].id]
                        .toString());
                    return TextButton(
                      onPressed:
                          campaignResponse.data[index].isAlreadyParticipated ??
                                  false
                              ? null
                              : () {
                                  campaignController.participateInCampaign(
                                    campaignId:
                                        campaignResponse.data[index].id ?? "",
                                  );
                                },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          campaignResponse.data[index].isAlreadyParticipated ??
                                  false
                              ? Colors.grey[500]
                              : Colors.blue,
                        ),
                      ),
                      child: campaignController.isLoadingMap[
                                  campaignResponse.data[index].id] ??
                              false
                          ? const CircularProgressIndicator()
                          : const Text(
                              "Participate",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(
                      AppNamedRoute.googleMapView,
                      arguments: {
                        "lat": campaignResponse
                            .data[index].location!.coordinates.first
                            .toDouble(),
                        "lng": campaignResponse
                            .data[index].location!.coordinates[1]
                            .toDouble(),
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
  }
}
