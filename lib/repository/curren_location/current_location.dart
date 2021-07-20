import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

part 'location_interface.dart';

class CurrentLocation implements LocationInterface {

  @override
  Future<Position?> getLastKnownLocation() async {
    return await Geolocator.getLastKnownPosition();
  }

  @override
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await locationStatus();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      // var position = await getLastKnownLocation();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<bool> locationStatus() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Marker getMarker(LatLng latLng) {
    var markerIdVal = '${latLng.latitude}';
    var markerId = MarkerId(markerIdVal);

    var marker = Marker(
      markerId: markerId,
      position: latLng,
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
    );

    return marker;
  }
}
