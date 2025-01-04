import 'package:blood_donation_flutter_app/core/routes/app_named_route.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotificationService {
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
    required Map data,
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
      payload: data["topic"],
    );
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  if (notificationResponse.payload == "Creation of new campaign") {
    // Navigating a user to campaign page if clicks on notification
    Get.toNamed(AppNamedRoute.campaignsView);
  }
  // TODO: navigate user to different pages as per payload details
}
