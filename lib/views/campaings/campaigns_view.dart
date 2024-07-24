import 'package:blood_donation_flutter_app/views/campaings/active_campaing_view.dart';
import 'package:blood_donation_flutter_app/views/campaings/campaing_nearme_view.dart';
import 'package:blood_donation_flutter_app/views/campaings/inactive_campaing_view.dart';
import 'package:flutter/material.dart';

class CampaingsView extends StatefulWidget {
  const CampaingsView({super.key});

  @override
  State<CampaingsView> createState() => CampaingsViewState();
}

class CampaingsViewState extends State<CampaingsView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Campaings"),
          bottom: const TabBar(
            labelPadding: EdgeInsets.only(
              bottom: 10,
            ),
            tabs: [
              Text("Currently Active"),
              Text("Near me"),
              Text("Inactive Campaings"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ActiveCampaingView(),
            CampaingNearMeView(),
            InactiveCampaingView(),
          ],
        ),
      ),
    );
  }
}
