import 'package:blood_donation_flutter_app/controllers/search_donor_controller.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DonorsView extends StatefulWidget {
  const DonorsView({super.key});

  @override
  State<DonorsView> createState() => _DonorsViewState();
}

class _DonorsViewState extends State<DonorsView> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Donors"),
        centerTitle: true,
      ),
      body: GetX<SearchDonorController>(
        builder: (controller) {
          if (controller.isLoading.value) {
            return Skeletonizer(
              enabled: true,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                      vertical: size.height * 0.001,
                    ),
                    child: Card(
                      child: SizedBox(
                        height: size.height * 0.2,
                        width: size.width,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.05),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.grey.shade200,
                                    height: size.height * 0.02,
                                  ),
                                  Container(
                                    color: Colors.grey.shade200,
                                    height: size.height * 0.02,
                                  ),
                                  Container(
                                    color: Colors.grey.shade200,
                                    height: size.height * 0.02,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey.shade200,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                controller.fetchAllDonors();
              },
              child: ListView.builder(
                itemCount: controller.response?.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.02,
                      vertical: size.height * 0.001,
                    ),
                    child: Card(
                      child: SizedBox(
                        height: size.height * 0.20,
                        width: size.width,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(size.width * 0.05),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: CachedNetworkImage(
                                    imageUrl: controller
                                        .response!.data[index].imageUrl!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.05,
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.response!.data[index].fullName ??
                                        "",
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    controller.response!.data[index].email ??
                                        "",
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    controller.response!.data[index]
                                            .phoneNumber ??
                                        "",
                                  ),
                                  Text(
                                    controller.response!.data[index]
                                            .isAvailableForDonation!
                                        ? "Available for donation"
                                        : "Not Available for donation",
                                    style: TextStyle(
                                      color: controller.response!.data[index]
                                              .isAvailableForDonation!
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller
                                            .response!.data[index].bloodGroup ??
                                        "",
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
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
