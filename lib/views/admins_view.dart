import 'package:blood_donation_flutter_app/controllers/admin_controller.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:blood_donation_flutter_app/utils/widgets/user_loading_skeletonizer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminsView extends StatefulWidget {
  const AdminsView({super.key});

  @override
  State<AdminsView> createState() => SearchPageState();
}

class SearchPageState extends State<AdminsView> {
  @override
  void initState() {
    Get.lazyPut(() => AdminController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return GetX<AdminController>(
      builder: (controller) {
        if (controller.isLoading.value) {
          return const UserLoadingSkeletonizer();
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              controller.fetchAdmins();
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
                                  errorWidget: (context, url, error) {
                                    return const Icon(Icons.error_outline);
                                  },
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller
                                              .response!.data[index].fullName ??
                                          "",
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Icon(
                                          Icons.shield,
                                        ),
                                        Text(
                                          controller
                                                  .response!.data[index].role ??
                                              "",
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  controller.response!.data[index].email ?? "",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  controller
                                          .response!.data[index].phoneNumber ??
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
                                  controller.response!.data[index].bloodGroup ??
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
    );
  }
}
