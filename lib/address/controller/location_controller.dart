import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:samruddhi/network/api_calls.dart';

class LocationController {
  ApiCalls apiCalls = ApiCalls();
  Future<Map<String, dynamic>> getAddressFromLatLong(
      LatLng selectedLocation) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        selectedLocation.latitude, selectedLocation.longitude);
    Placemark place = placeMarks[0];
    return place.toJson();
  }

  addNewAddress(BuildContext context,Map<String, Object> arguments) {
    return apiCalls.addNewAddress(context, arguments);
  }
}
