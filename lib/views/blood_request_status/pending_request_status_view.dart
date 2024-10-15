import 'package:flutter/material.dart';

class PendingRequestStatusView extends StatefulWidget {
  const PendingRequestStatusView({super.key});

  @override
  State<PendingRequestStatusView> createState() => _PendingRequestStatusViewState();
}

class _PendingRequestStatusViewState extends State<PendingRequestStatusView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Pending Request Status View"),
      ),
    );
  }
}