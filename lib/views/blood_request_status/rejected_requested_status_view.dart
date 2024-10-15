import 'package:flutter/material.dart';

class RejectedRequestedStatusView extends StatefulWidget {
  const RejectedRequestedStatusView({super.key});

  @override
  State<RejectedRequestedStatusView> createState() => _RejectedRequestedStatusViewState();
}

class _RejectedRequestedStatusViewState extends State<RejectedRequestedStatusView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Rejected Blood Request Status"),
      ),
    );
  }
}