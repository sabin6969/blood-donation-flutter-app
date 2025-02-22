import 'package:blood_donation_flutter_app/core/static/app_lottie_animations_path.dart';
import 'package:blood_donation_flutter_app/controllers/blood_request_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../core/static/app_image_path.dart';
import '../../main.dart' show size;

class ApprovedRequestStatusView extends StatefulWidget {
  const ApprovedRequestStatusView({super.key});

  @override
  State<ApprovedRequestStatusView> createState() =>
      _ApprovedRequestStatusViewState();
}

class _ApprovedRequestStatusViewState extends State<ApprovedRequestStatusView> {
  @override
  void initState() {
    Get.find<BloodRequestController>().fetchApprovedBloodRequest();
    super.initState();
  }

  @override
  void dispose() {
    debugPrint("Approved Request Status View has Been disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<BloodRequestController>(
      builder: (controller) {
        if (controller.isApprovedBloodRequestLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.approvedBloodRequestModel != null) {
          return controller.approvedBloodRequestModel!.data.isEmpty
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
                    const Text(
                      "You don't have any approved blood requests yet",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          controller.fetchApprovedBloodRequest();
                        },
                        child: const Text("Refresh"))
                  ],
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.fetchApprovedBloodRequest();
                    },
                    child: ListView.separated(
                      itemCount:
                          controller.approvedBloodRequestModel!.data.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          title: Text(controller.approvedBloodRequestModel!
                                  .data[index].note ??
                              "Blood Request"),
                          leading: const Icon(
                            Icons.verified,
                            color: Colors.blue,
                          ),
                          children: [
                            ListTile(
                              title: const Text("Requested Blood Group"),
                              subtitle: Text(
                                controller.approvedBloodRequestModel!
                                        .data[index].requestedBloodGroup ??
                                    "",
                              ),
                              leading: const Icon(Icons.bloodtype),
                            ),
                            ListTile(
                              title: const Text("Requested City"),
                              subtitle: Text(
                                controller.approvedBloodRequestModel!
                                        .data[index].city ??
                                    "",
                              ),
                              leading: const Icon(Icons.location_city),
                            ),
                            ListTile(
                              title: const Text("Hospital"),
                              leading: const Icon(
                                Icons.local_hospital,
                              ),
                              subtitle: Text(controller
                                      .approvedBloodRequestModel!
                                      .data[index]
                                      .hospital ??
                                  ""),
                            ),
                            const Divider(),
                            ListTile(
                              title: const Text("Approved By"),
                              subtitle: Text(controller
                                      .approvedBloodRequestModel!
                                      .data[index]
                                      .approvedBy!
                                      .fullName ??
                                  ""),
                              leading: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  controller.approvedBloodRequestModel!
                                      .data[index].approvedBy!.imageUrl!,
                                ),
                              ),
                            ),
                            ListTile(
                              title: const Text("Email"),
                              leading: const Icon(Icons.email),
                              subtitle: Text(controller
                                      .approvedBloodRequestModel!
                                      .data[index]
                                      .approvedBy!
                                      .email ??
                                  ""),
                            ),
                            ListTile(
                              title: const Text("Contact Number"),
                              leading: const Icon(
                                Icons.phone,
                              ),
                              subtitle: Text(
                                controller.approvedBloodRequestModel!
                                        .data[index].approvedBy!.phoneNumber ??
                                    "",
                              ),
                            ),
                            ListTile(
                              title: const Text("Approved At"),
                              leading: const Icon(
                                Icons.date_range,
                              ),
                              subtitle: Text(
                                  "${DateTime.parse(controller.approvedBloodRequestModel!.data[index].updatedAt.toString()).year}-${DateTime.parse(controller.approvedBloodRequestModel!.data[index].updatedAt.toString()).month}-${DateTime.parse(controller.approvedBloodRequestModel!.data[index].updatedAt.toString()).day} / ${DateTime.parse(controller.approvedBloodRequestModel!.data[index].updatedAt.toString()).hour} : ${DateTime.parse(controller.approvedBloodRequestModel!.data[index].updatedAt.toString()).minute}"),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
