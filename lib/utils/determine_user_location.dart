import 'package:app_settings/app_settings.dart';
import 'package:blood_donation_flutter_app/exceptions/app_exceptions.dart';
import 'package:geolocator/geolocator.dart';

class DetermineLocaltion {
  static Future<Position> determineUserLocation() async {
    bool isServiceEnabled;
    LocationPermission permission;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      throw const AppException(errorMessage: "Location services are disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const AppException(
            errorMessage: "Location Permissions are denied");
      }
      if (permission == LocationPermission.deniedForever) {
        throw const AppException(
          errorMessage:
              "Location permissions are permanently denied, we cannot request permissions. Please enable it manually",
        );
      }
    }
    return await Geolocator.getCurrentPosition();
  }
}
