import 'package:blood_donation_flutter_app/controllers/blood_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BloodRequestStatusView extends StatefulWidget {
  const BloodRequestStatusView({super.key});

  @override
  State<BloodRequestStatusView> createState() => _BloodRequestStatusViewState();
}

class _BloodRequestStatusViewState extends State<BloodRequestStatusView> {
  @override
  void initState() {
    Get.find<BloodRequestController>().fetchBloodRequestStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(
            milliseconds: 600,
          ),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: const Text(
                "Blood Request Status",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
