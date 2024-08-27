import 'package:flutter/material.dart';

class InactiveCampaign extends StatefulWidget {
  const InactiveCampaign({super.key});

  @override
  State<InactiveCampaign> createState() => _InactiveCampaignViewState();
}

class _InactiveCampaignViewState extends State<InactiveCampaign> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Comming Soon",
        ),
      ),
    );
  }
}
