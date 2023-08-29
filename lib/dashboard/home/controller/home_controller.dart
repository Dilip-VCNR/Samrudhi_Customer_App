import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:samruddhi/address/controller/location_controller.dart';
import 'package:samruddhi/auth/controller/auth_controller.dart';
import 'package:samruddhi/auth/model/login_response_model.dart';
import 'package:samruddhi/dashboard/home/model/home_data_model.dart';
import 'package:samruddhi/dashboard/home/model/in_store_data_model.dart';
import 'package:samruddhi/dashboard/home/model/stores_on_category_model.dart';
import 'package:samruddhi/network/api_calls.dart';

import '../../../database/app_pref.dart';
import '../../../database/models/pref_model.dart';

class HomeController {

  ApiCalls apiCalls  = ApiCalls();
  AuthController authController = AuthController();
  LocationController locationController = LocationController();
  Future<Map> getHomeData() async {
    PrefModel prefModel = AppPref.getPref();
    if (prefModel.selectedAddress != null) {
      HomeDataModel homeData = await apiCalls.fetchHomeData(prefModel.selectedAddress!.lat, prefModel.selectedAddress!.lng);
      return {
        "Address":prefModel.selectedAddress!,
        "HomeData":homeData
      };
    } else {
      Position currentPosition;
      try {
        currentPosition = await authController.getCurrentLocation();
      } catch (e) {
        currentPosition = const Position(
          latitude: 10.1632,
          longitude: 76.6413,
          timestamp: null,
          accuracy: 100,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
        );
      }
      Map address = await locationController.getAddressFromLatLong(LatLng(currentPosition.latitude, currentPosition.longitude));
      HomeDataModel homeData = await apiCalls.fetchHomeData(currentPosition.latitude, currentPosition.longitude);
      return {
        "Address":Address(address: address['name'] + " " + address['subLocality'] + " " + address['subAdministrativeArea'],lat: currentPosition.latitude,lng: currentPosition.longitude),
        "HomeData":homeData
      };
    }
  }

  Future<StoresOnSearchModel> getStoresOnSearch(BuildContext context,Map arguments) {
    return apiCalls.fetchStoresOnCategory(context,arguments);
  }

  Future<InStoreDataModel> getInStoreData(String? storeId, BuildContext context) {
    return apiCalls.fetchInStoreData(context,storeId);
  }
}
