import 'package:app_settings/app_settings.dart';
import 'package:blood_donation_flutter_app/utils/widgets/toast_message.dart';
import 'package:permission_handler/permission_handler.dart';

void askForNotification() async {
  PermissionStatus status = await Permission.notification.request();
  if (status.isPermanentlyDenied) {
    showToastMessage(
        message:
            "Notifications are permanently disabled\nEnable it to get notified");
  } else if (status.isDenied) {
    showToastMessage(message: "Please enable notifications to get updated");
    AppSettings.openAppSettings(type: AppSettingsType.notification);
  } else if (status.isRestricted) {
    AppSettings.openAppSettings(type: AppSettingsType.notification);
    showToastMessage(message: "Please enable notifications to get updated");
  }
}
