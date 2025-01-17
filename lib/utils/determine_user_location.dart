import 'package:blood_donation_flutter_app/utils/widgets/toast_message.dart';
import 'package:geolocator/geolocator.dart';

import '../data/exceptions/app_exceptions.dart';

class DetermineLocation {
  static Future<Position> determineUserLocation() async {
    bool isServiceEnabled;
    LocationPermission permission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      throw LocationNotEnabledException(
          errorMessage: "Location services are disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showToastMessage(
          message: "Location permissions are denied please enable it",
        );
        throw LocationNotEnabledException(
          errorMessage: "Location Permissions are denied",
        );
      } else if (permission == LocationPermission.deniedForever) {
        showToastMessage(
          message:
              "Location permissions are permanently denied, we cannot request permissions. Please enable it manually",
        );
        throw LocationNotEnabledException(
          errorMessage:
              "Location permissions are permanently denied. Please enable it manually",
        );
      }
    }
    return await Geolocator.getCurrentPosition();
  }
}
