import 'package:flutter/material.dart';

class CampaingsView extends StatefulWidget {
  const CampaingsView({super.key});

  @override
  State<CampaingsView> createState() => CampaingsViewState();
}

class CampaingsViewState extends State<CampaingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Campaigns"),
      ),
    );
  }
}
