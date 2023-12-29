
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/dashboard/models/store_data_model.dart';
import 'package:samruddhi/utils/app_widgets.dart';

import '../../address/controller/location_controller.dart';
import '../../utils/routes.dart';
import '../models/home_data_model.dart';

class DashboardProvider extends ChangeNotifier {
  TextEditingController addressSearchController = TextEditingController();
  BuildContext? homePageContext;
  BuildContext? selectAddressPageContext;
  ApiCalls apiCalls = ApiCalls();
  Future<HomeDataModel>? homeData;
  Position? currentPosition;
  LocationController locationController = LocationController();
  String? address;

  bool? serviceEnabled;
  LocationPermission? permission;
  StoreDataModel? storeData;

  Future<Position> getCurrentLocation() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  getHomeData() async {
    homeData = null;
    if (prefModel.selectedAddress != null) {
      homeData = apiCalls.fetchHomeData(
          prefModel.selectedAddress!.lat!, prefModel.selectedAddress!.lng!);
      address = prefModel.selectedAddress!.completeAddress;
    } else {
      try {
        currentPosition = await getCurrentLocation();
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
      Map defaultAddressJson = await locationController.getAddressFromLatLong(
          LatLng(currentPosition!.latitude, currentPosition!.longitude));
      address = defaultAddressJson['name'] +
          " " +
          defaultAddressJson['subAdministrativeArea'] +
          " " +
          defaultAddressJson['administrativeArea'];
      homeData = apiCalls.fetchHomeData(
          currentPosition!.latitude, currentPosition!.longitude);
    }
    notifyListeners();
  }

  Future<void> getIntoStore(NearStoresdatum nearStoresdatum) async {
    showLoaderDialog(homePageContext!);
    storeData = await apiCalls.getStoreData(nearStoresdatum);
    if(storeData!.statusCode==200){
      Navigator.pop(homePageContext!);
      Navigator.pushNamed(homePageContext!, Routes.storeInRoute);
    }else{
      Navigator.pop(homePageContext!);
      showErrorToast(homePageContext!,storeData!.message!);
    }
  }

  addProductToCart(ProductList productList) {
    prefModel.cartItems!.add(productList);
  }
}
