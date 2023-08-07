import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController {
  Future<Map<String, dynamic>> getAddressFromLatLong(
      LatLng selectedLocation) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        selectedLocation.latitude, selectedLocation.longitude);
    Placemark place = placeMarks[0];
    return place.toJson();
  }
}
