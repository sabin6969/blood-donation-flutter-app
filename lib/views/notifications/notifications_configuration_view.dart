import 'package:app_settings/app_settings.dart';
import 'package:blood_donation_flutter_app/constants/image_path.dart';
import 'package:blood_donation_flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationsConfigurationView extends StatefulWidget {
  const NotificationsConfigurationView({super.key});

  @override
  State<NotificationsConfigurationView> createState() =>
      _NotificationsConfigurationViewState();
}

class _NotificationsConfigurationViewState
    extends State<NotificationsConfigurationView> {
  late PermissionStatus status;

  @override
  void initState() {
    status = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage Notifications",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              child: Image.asset(
                ImagePath.pushNotifications,
                height: size.height * 0.4,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // TODO: Complete This
            SwitchListTile(
              value: status == PermissionStatus.granted ? true : false,
              onChanged: status == PermissionStatus.granted
                  ? (value) {
                      AppSettings.openAppSettings(
                          type: AppSettingsType.notification);
                    }
                  : (value) {},
              title: const Text("Allow Notifications"),
            ),
            const SizedBox(
              height: 20,
            ),
            SwitchListTile(
              value: true,
              onChanged: (value) {},
              title: const Text("Subscribe to Blood Donation Campaings"),
            ),
            const SizedBox(
              height: 20,
            ),
            SwitchListTile(
              value: false,
              onChanged: (value) {},
              title: const Text(
                "Subscribe to Blood Request Updates",
              ),
            )
          ],
        ),
      ),
    );
  }
}
