import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/constants/image_path.dart';
import 'package:blood_donation_flutter_app/controllers/home_controller.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:blood_donation_flutter_app/utils/widgets/custom_card_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomePageState();
}

class _HomePageState extends State<HomeView> {
  List<String> carouselImagePath = [
    ImagePath.bloodDonationImageOne,
    ImagePath.bloodDonationImageTwo,
    ImagePath.bloodDonationImageThree,
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.25,
              child: CarouselView(
                itemExtent: size.width * 0.8,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                children: carouselImagePath
                    .map(
                      (image) => SizedBox(
                        height: size.height * 0.3,
                        width: size.width * 0.9,
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: GridView.count(
                childAspectRatio: 2 / 1.5,
                crossAxisSpacing: size.width * 0.02,
                mainAxisSpacing: size.height * 0.02,
                crossAxisCount: 3,
                children: [
                  CustomCard(
                    title: "Find Donors",
                    imageIconPath: ImagePath.searchBloodIcon,
                    onTap: () {
                      Get.toNamed(AppRoutes.donorsView);
                    },
                  ),
                  CustomCard(
                    title: "Donates",
                    imageIconPath: ImagePath.donatesIcon,
                    onTap: () {
                      Get.snackbar("Comming Soon",
                          "This feature will be available soon");
                    },
                  ),
                  CustomCard(
                    title: "Order Blood",
                    imageIconPath: ImagePath.orderBloodIcon,
                    onTap: () {
                      Get.toNamed(AppRoutes.bloodRequestView);
                    },
                  ),
                  CustomCard(
                    title: "Assistance",
                    imageIconPath: ImagePath.assistanceIcon,
                    onTap: () {
                      Get.snackbar("Comming Soon",
                          "This feature will be available soon");
                    },
                  ),
                  CustomCard(
                    title: "Status",
                    imageIconPath: ImagePath.reportIcon,
                    onTap: () {
                      Get.toNamed(AppRoutes.bloodRequestStatusView);
                    },
                  ),
                  CustomCard(
                    title: "Campaigns",
                    imageIconPath: ImagePath.campaignIcon,
                    onTap: () {
                      Get.toNamed(AppRoutes.campaignsView);
                    },
                  ),
                ],
              ),
            ),
            TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelPadding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              indicator: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              tabs: const [
                Text(
                  "Top Blood Requestor",
                ),
                Text(
                  "Top Blood Donor",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  GetX<HomeController>(
                    builder: (controller) {
                      return controller.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : controller.topBloodRequestor.data.isEmpty
                              ? const Center(
                                  child: Text("No Data Found"),
                                )
                              : SingleChildScrollView(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: ExpansionTile(
                                      title: ListTile(
                                        title: Text(
                                          controller.topBloodRequestor.data
                                                  .first.fullName ??
                                              "N/A",
                                        ),
                                        leading: CircleAvatar(
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                            controller.topBloodRequestor.data
                                                    .first.imageUrl ??
                                                "N/A",
                                          ),
                                        ),
                                      ),
                                      children: [
                                        ListTile(
                                          title: const Text("Email"),
                                          leading: const Icon(Icons.email),
                                          subtitle: Text(
                                            controller.topBloodRequestor.data
                                                    .first.email ??
                                                "N/A",
                                          ),
                                        ),
                                        ListTile(
                                          title: const Text("Phone Number"),
                                          leading: const Icon(
                                            Icons.phone,
                                          ),
                                          subtitle: Text(
                                            controller.topBloodRequestor.data
                                                    .first.phoneNumber ??
                                                "N/A",
                                          ),
                                        ),
                                        ListTile(
                                          leading: const Icon(
                                            Icons.bloodtype,
                                          ),
                                          title: const Text("Blood Group"),
                                          subtitle: Text(
                                            controller.topBloodRequestor.data
                                                    .first.bloodGroup ??
                                                "N/A",
                                          ),
                                        ),
                                        ListTile(
                                          title:
                                              const Text("Requested for Blood"),
                                          leading: const Icon(
                                            Icons.volunteer_activism,
                                          ),
                                          subtitle: Text(
                                              "${controller.topBloodRequestor.data.first.noOfTimesRequestedForBlood} Times"),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                    },
                  ),
                  const Center(
                    child: Text("Comming Soon.."),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
