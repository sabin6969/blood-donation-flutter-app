import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:blood_donation_flutter_app/constants/image_path.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:blood_donation_flutter_app/utils/widgets/custom_card_widget.dart';
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
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.05,
        ),
        SizedBox(
          height: size.height * 0.3,
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
                  Get.snackbar(
                      "Comming Soon", "This feature will be available soon");
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
                  Get.snackbar(
                      "Comming Soon", "This feature will be available soon");
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
        )
      ],
    );
  }
}
