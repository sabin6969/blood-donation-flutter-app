import 'package:flutter/material.dart';

class ApprovedRequestStatusView extends StatefulWidget {
  const ApprovedRequestStatusView({super.key});

  @override
  State<ApprovedRequestStatusView> createState() => _ApprovedRequestStatusViewState();
}

class _ApprovedRequestStatusViewState extends State<ApprovedRequestStatusView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Approved Blood Request"),
      ),
    );
  }
}