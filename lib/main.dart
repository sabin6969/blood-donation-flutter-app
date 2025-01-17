import 'package:blood_donation_flutter_app/core/routes/app_named_route.dart';
import 'package:blood_donation_flutter_app/core/theme/app_theme.dart';
import 'package:blood_donation_flutter_app/firebase_options.dart';
import 'package:blood_donation_flutter_app/services/local_notification_service.dart';
import 'package:blood_donation_flutter_app/utils/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalNotificationService.initLocalNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((event) {
    FirebaseMessaging.instance.getToken();
    LocalNotificationService.trigerLocalNotification(
      title: event.notification!.title ?? "Title",
      body: event.notification!.body ?? "Body",
      data: event.data,
    );
  });
  await GetStorage.init();
  runApp(const MyApp());
}

// Global object to access height and width of a device
late Size size;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppNamedRoute.splashView,
      defaultTransition: Transition.downToUp,
      getPages: pages,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightModeTheme,
      darkTheme: AppTheme.darkModeTheme,
    );
  }
}

// listening to a background remote notifications
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Notification has been received");
}
