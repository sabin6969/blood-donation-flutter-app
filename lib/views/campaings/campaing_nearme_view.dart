import 'package:flutter/material.dart';

class CampaingNearMeView extends StatefulWidget {
  const CampaingNearMeView({super.key});

  @override
  State<CampaingNearMeView> createState() => CampaingNearMeViewState();
}

class CampaingNearMeViewState extends State<CampaingNearMeView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Campaing Near Me"),
      ),
    );
  }
}
