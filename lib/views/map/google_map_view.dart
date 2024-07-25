import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => GoogleMapViewState();
}

class GoogleMapViewState extends State<GoogleMapView> {
  final LatLng _latLng = LatLng(Get.arguments["lat"], Get.arguments["lng"]);

  late final GoogleMapController _googleMapController;

  void _onMapCreated(GoogleMapController googleMapController) {
    _googleMapController = googleMapController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(seconds: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: const Text(
                "Map View",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _latLng,
          zoom: 11.0,
        ),
        markers: {
          Marker(
            markerId: const MarkerId(
              "markerId1",
            ),
            position: _latLng,
          )
        },
      ),
    );
  }
}
