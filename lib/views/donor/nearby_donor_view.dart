import 'package:app_settings/app_settings.dart';
import 'package:blood_donation_flutter_app/constants/app_lottie_animations.dart';
import 'package:blood_donation_flutter_app/controllers/search_donor_controller.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:blood_donation_flutter_app/utils/determine_user_location.dart';
import 'package:blood_donation_flutter_app/utils/widgets/user_loading_skeletonizer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NearbyDonorView extends StatefulWidget {
  const NearbyDonorView({super.key});

  @override
  State<NearbyDonorView> createState() => _NearbyDonorViewState();
}

class _NearbyDonorViewState extends State<NearbyDonorView>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      try {
        await DetermineLocation.determineUserLocation();
        Get.find<SearchDonorController>().isLocationDisabled.value = false;
      } on LocationNotEnabledException {
        Get.find<SearchDonorController>().isLocationDisabled.value = true;
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Get.find<SearchDonorController>().fetchNearByDonors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _showFilterDialog(context: context),
            icon: const Icon(
              Icons.filter_list,
            ),
          )
        ],
        title: const Text(
          "Donors Near You"
        ),
      ),
      body: GetX<SearchDonorController>(
        builder: (controller) {
          if (controller.isNearByDonorLoading.value) {
            return const UserLoadingSkeletonizer();
          } else if (controller.isLocationDisabled.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Location Services Are disabled.Please enable it",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await AppSettings.openAppSettings(
                          type: AppSettingsType.location);
                    },
                    child: const Text(
                      "Enable Location",
                    ),
                  )
                ],
              ),
            );
          } else if (!controller.isNearByDonorLoading.value) {
            return RefreshIndicator(
              onRefresh: () async {
                controller.fetchNearByDonors();
              },
              child: controller.nearByDonorResponse!.data.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          AppLottieAnimations.errorLottieAnimationPath,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "No Donors Found",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: controller.nearByDonorResponse!.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.02,
                            vertical: size.height * 0.001,
                          ),
                          child: Card(
                            elevation: 5,
                            child: SizedBox(
                              height: size.height * 0.20,
                              width: size.width,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(200),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: CachedNetworkImage(
                                          imageUrl: controller
                                              .nearByDonorResponse!
                                              .data[index]
                                              .imageUrl!,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) {
                                            return const Icon(
                                                Icons.error_outline);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.nearByDonorResponse!
                                                  .data[index].fullName ??
                                              "",
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          controller.nearByDonorResponse!
                                                  .data[index].email ??
                                              "",
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          controller.nearByDonorResponse!
                                                  .data[index].phoneNumber ??
                                              "",
                                        ),
                                        Text(
                                          controller.nearByDonorResponse!.data
                                                  .first.isAvailableForDonation!
                                              ? "Available for donation"
                                              : "Not Available for donation",
                                          style: TextStyle(
                                            color: controller
                                                    .nearByDonorResponse!
                                                    .data[index]
                                                    .isAvailableForDonation!
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                        Text(
                                          "Donor is ${(controller.nearByDonorResponse!.data[index].distanceFromYou!) ~/ 1000} Km Away",
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller.nearByDonorResponse!
                                                  .data[index].bloodGroup ??
                                              "",
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _showFilterDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Apply Filter"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Select Distance (KM) "),
                Expanded(
                  child: GetX<SearchDonorController>(
                    builder: (controller) => Slider(
                      min: 0,
                      max: 150,
                      label: controller.distance.value.toStringAsFixed(0),
                      divisions: 100,
                      value: controller.distance.value,
                      onChanged: (value) {
                        controller.distance.value = value;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Actively Donating"),
                GetX<SearchDonorController>(
                  builder: (controller) => Switch(
                    value: controller.isActivelyDonating.value,
                    onChanged: (value) {
                      controller.isActivelyDonating.value = value;
                    },
                  ),
                )
              ],
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              "Cancel",
            ),
          ),
          TextButton(
            onPressed: () {
              Get.find<SearchDonorController>().fetchNearByDonors();
              Get.back();
            },
            child: const Text(
              "Apply",
            ),
          )
        ],
      ),
    );
  }
}
