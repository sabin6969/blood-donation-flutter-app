import 'package:blood_donation_flutter_app/controllers/blood_request_controller.dart';
import 'package:blood_donation_flutter_app/views/blood_request_status/approved_request_status_view.dart';
import 'package:blood_donation_flutter_app/views/blood_request_status/pending_request_status_view.dart';
import 'package:blood_donation_flutter_app/views/blood_request_status/rejected_requested_status_view.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
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
              ),
            );
          },
        ),
        bottom: const TabBar(
          indicatorWeight: 5,
          tabs: [
            Text("Approved"),
            Text("Pending"),
            Text("Rejected"),
          ],
          ),
        ),
        body: const TabBarView(
          children: [
           ApprovedRequestStatusView(),
           PendingRequestStatusView(),
           RejectedRequestedStatusView(),
          ],
          ),
      ),
    );
  }
}
