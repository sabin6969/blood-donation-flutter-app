import 'package:blood_donation_flutter_app/controllers/blood_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/static/app_image_path.dart';
import '../../main.dart';

class RejectedRequestedStatusView extends StatefulWidget {
  const RejectedRequestedStatusView({super.key});

  @override
  State<RejectedRequestedStatusView> createState() =>
      _RejectedRequestedStatusViewState();
}

class _RejectedRequestedStatusViewState
    extends State<RejectedRequestedStatusView> {
  @override
  void initState() {
    Get.find<BloodRequestController>().fetchRejectedBloodRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<BloodRequestController>(
        builder: (controller) {
          if (controller.isRejectedBloodRequestLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.rejectedBloodRequestModel != null) {
            return controller.rejectedBloodRequestModel!.data.isEmpty
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
                      const Text("No any rejected blood requests yet"),
                      TextButton(
                        onPressed: () {},
                        child: const Text("Refresh"),
                      )
                    ],
                  )
                : ListView.builder(
                    itemCount:
                        controller.rejectedBloodRequestModel!.data.length,
                    itemBuilder: (context, index) {
                      DateTime requestedDateTime = controller
                          .rejectedBloodRequestModel!.data[index].createdAt!
                          .toLocal();
                      DateTime rejectedDateTime = controller
                          .rejectedBloodRequestModel!.data[index].updatedAt!
                          .toLocal();
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: ExpansionTile(
                          title: Text(controller.rejectedBloodRequestModel!
                                  .data[index].note ??
                              "Blood Request"),
                          subtitle: const Row(
                            children: [
                              Icon(Icons.sentiment_dissatisfied),
                              SizedBox(width: 5),
                              Text("Rejected"),
                            ],
                          ),
                          children: [
                            ListTile(
                              title: const Text("Requested Hospital"),
                              subtitle: Text(
                                controller.rejectedBloodRequestModel!
                                        .data[index].hospital ??
                                    "N/A",
                              ),
                              leading: const Icon(Icons.local_hospital),
                            ),
                            ListTile(
                              title: const Text("Requested Blood Group"),
                              subtitle: Text(
                                controller.rejectedBloodRequestModel!
                                        .data[index].requestedBloodGroup ??
                                    "N/A",
                              ),
                              leading: const Icon(Icons.bloodtype),
                            ),
                            ListTile(
                              title: const Text("Requested City"),
                              leading: const Icon(
                                Icons.location_city,
                              ),
                              subtitle: Text(
                                controller.rejectedBloodRequestModel!
                                        .data[index].city ??
                                    "N/A",
                              ),
                            ),
                            ListTile(
                              title: const Text("Requested At"),
                              leading: const Icon(Icons.date_range),
                              subtitle: Text(
                                "${requestedDateTime.year}-${requestedDateTime.month}-${requestedDateTime.day} ${requestedDateTime.hour}:${requestedDateTime.minute}",
                              ),
                            ),
                            ListTile(
                              title: const Text("Rejected At"),
                              leading: const Icon(Icons.date_range),
                              subtitle: Text(
                                "${rejectedDateTime.year}-${rejectedDateTime.month}-${rejectedDateTime.day} ${rejectedDateTime.hour}:${rejectedDateTime.minute}",
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
