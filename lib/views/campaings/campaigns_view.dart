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
            Scaffold(
              body: Center(
                child: Text("Currently active"),
              ),
            ),
            Scaffold(
              body: Center(
                child: Text("Near me"),
              ),
            ),
            Scaffold(
              body: Center(
                child: Text("Inactive campains"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
