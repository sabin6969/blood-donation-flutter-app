import 'package:flutter/material.dart';

class InactiveCampaingView extends StatefulWidget {
  const InactiveCampaingView({super.key});

  @override
  State<InactiveCampaingView> createState() => _InactiveCampaingViewState();
}

class _InactiveCampaingViewState extends State<InactiveCampaingView> {
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
