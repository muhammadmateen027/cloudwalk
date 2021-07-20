part of 'current_location.dart';

abstract class LocationInterface {

  Future<Position?> getLastKnownLocation();

  Future<Position?> getCurrentPosition();
  Future<bool> locationStatus();
  Marker getMarker(LatLng latLng);
}