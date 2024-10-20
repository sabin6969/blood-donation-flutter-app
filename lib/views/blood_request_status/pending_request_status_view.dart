import 'package:blood_donation_flutter_app/controllers/blood_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingRequestStatusView extends StatefulWidget {
  const PendingRequestStatusView({super.key});

  @override
  State<PendingRequestStatusView> createState() =>
      _PendingRequestStatusViewState();
}

class _PendingRequestStatusViewState extends State<PendingRequestStatusView> {
  @override
  void initState() {
    Get.find<BloodRequestController>().fetchPendingBloodRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<BloodRequestController>(builder: (controller) {
        if (controller.isPendingBloodRequestLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.pendingBloodRequestModel != null) {
          return controller.pendingBloodRequestModel!.data.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("No pending Blood Requests"),
                    TextButton(
                      onPressed: () {
                        controller.fetchPendingBloodRequest();
                      },
                      child: const Text("Refresh"),
                    ),
                  ],
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    controller.fetchPendingBloodRequest();
                  },
                  child: ListView.builder(
                    itemCount: controller.pendingBloodRequestModel!.data.length,
                    itemBuilder: (context, index) {
                      DateTime localDateTime = controller
                          .pendingBloodRequestModel!.data[index].createdAt!
                          .toLocal();
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: ExpansionTile(
                          title: Text(
                            controller.pendingBloodRequestModel!.data[index]
                                    .note ??
                                "Blood Request",
                          ),
                          subtitle: const Row(
                            children: [
                              Icon(Icons.hourglass_bottom),
                              Text("Waiting for approval from admin")
                            ],
                          ),
                          children: [
                            ListTile(
                              title: const Text("Requested City"),
                              leading: const Icon(Icons.location_city),
                              subtitle: Text(
                                controller.pendingBloodRequestModel!.data[index]
                                        .city ??
                                    "N/A",
                              ),
                            ),
                            ListTile(
                              title: const Text("Requested Blood Group"),
                              leading: const Icon(Icons.bloodtype),
                              subtitle: Text(
                                controller.pendingBloodRequestModel!.data[index]
                                        .requestedBloodGroup ??
                                    "N/A",
                              ),
                            ),
                            ListTile(
                              title: const Text("Requested at"),
                              leading: const Icon(Icons.date_range),
                              subtitle: Text(
                                  "${localDateTime.year}-${localDateTime.month}-${localDateTime.day} ${localDateTime.hour}:${localDateTime.minute}"),
                            ),
                            ListTile(
                              onTap: () {},
                              title: const Text("Edit this request"),
                              leading: const Icon(Icons.edit),
                            ),
                            ListTile(
                              onTap: () {},
                              title: const Text("Delete this request"),
                              leading: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
