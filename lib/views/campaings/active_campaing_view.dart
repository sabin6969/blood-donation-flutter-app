import 'package:flutter/material.dart';

class ActiveCampaingView extends StatefulWidget {
  const ActiveCampaingView({super.key});

  @override
  State<ActiveCampaingView> createState() => _ActiveCampaingViewState();
}

class _ActiveCampaingViewState extends State<ActiveCampaingView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Active Campaings"),
      ),
    );
  }
}
