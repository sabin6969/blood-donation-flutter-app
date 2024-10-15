import 'package:blood_donation_flutter_app/views/campaings/active_campaign_view.dart';
import 'package:blood_donation_flutter_app/views/campaings/campaigns_nearme_view.dart';
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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(
              milliseconds: 600,
            ),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: const Text(
                  "Campaigns",
                ),
              );
            },
          ),
          bottom: const TabBar(
            labelPadding: EdgeInsets.only(
              bottom: 10,
            ),
            labelColor: Colors.white,
            tabs: [
              Text(
                "Active",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                "Near me",
              style: TextStyle(
                color: Colors.white,
              ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ActiveCampaingView(),
            CampaignNearMe(),
          ],
        ),
      ),
    );
  }
}
