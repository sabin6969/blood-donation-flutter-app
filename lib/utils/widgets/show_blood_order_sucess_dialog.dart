import 'package:blood_donation_flutter_app/core/static/app_image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showBloodOrderSucessDialog() {
  Get.dialog(
    AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppImagePath.bloodRequestSucess),
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Blood order is successfully requested.",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            "Ok",
          ),
        )
      ],
    ),
  );
}
