import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getFcmToken() async {
  return await FirebaseMessaging.instance.getToken();
}
