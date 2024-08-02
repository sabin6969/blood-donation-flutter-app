import 'package:blood_donation_flutter_app/constants/app_routes.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotification {
  static Future<void> initLocalNotifications() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings(
      "@mipmap/launcher_icon",
    );
    await FlutterLocalNotificationsPlugin().initialize(
      InitializationSettings(
        android: androidInitializationSettings,
      ),
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: notificationTapBackground,
    );
  }

  static void trigerLocalNotification({
    required String title,
    required String body,
  }) {
    FlutterLocalNotificationsPlugin().show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "channelId",
          "channelName",
          priority: Priority.high,
          importance: Importance.high,
        ),
      ),
    );
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // Navigating a user to campaign page if clicks on notification
  Get.toNamed(AppRoutes.campaignsView);
}
