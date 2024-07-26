import 'package:blood_donation_flutter_app/views/campaings/active_campaign_view.dart';
import 'package:blood_donation_flutter_app/views/campaings/campaigns_nearme_view.dart';
import 'package:blood_donation_flutter_app/views/campaings/inactive_campaigns_view.dart';
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
          title: TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(
              seconds: 2,
            ),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: const Text(
                  "Campaigns",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          bottom: const TabBar(
            labelPadding: EdgeInsets.only(
              bottom: 10,
            ),
            tabs: [
              Text("Active"),
              Text("Near me"),
              Text("Inactive"),
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
