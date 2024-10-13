import 'package:blood_donation_flutter_app/constants/image_path.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:flutter/material.dart';

class NotificationsConfigurationView extends StatefulWidget {
  const NotificationsConfigurationView({super.key});

  @override
  State<NotificationsConfigurationView> createState() =>
      _NotificationsConfigurationViewState();
}

class _NotificationsConfigurationViewState
    extends State<NotificationsConfigurationView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Manage Notifications",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: size.width,
            child: Image.asset(
              ImagePath.pushNotifications,
              height: size.height * 0.4,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
