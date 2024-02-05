import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:samruddhi/address/model/delete_address_response_model.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/dashboard/models/search_response_model.dart';
import 'package:samruddhi/dashboard/models/store_data_model.dart';
import 'package:samruddhi/dashboard/orders/models/deliverable_address_model.dart';
import 'package:samruddhi/dashboard/orders/models/order_response_model.dart';
import 'package:samruddhi/dashboard/orders/models/review_cart_response_model.dart';
import 'package:samruddhi/database/app_pref.dart';
import 'package:samruddhi/utils/app_widgets.dart';

import '../../address/controller/location_controller.dart';
import '../../auth/models/login_response_model.dart';
import '../../utils/routes.dart';
import '../models/home_data_model.dart';
import '../wallet/models/wallet_response_model.dart';

class DashboardProvider extends ChangeNotifier {
  TextEditingController addressSearchController = TextEditingController();
  BuildContext? homePageContext;
  BuildContext? selectAddressPageContext;
  ApiCalls apiCalls = ApiCalls();
  HomeDataModel? homeData;
  Position? currentPosition;
  LocationController locationController = LocationController();
  String? address;

  bool? serviceEnabled;
  LocationPermission? permission;
  StoreDataModel? storeData;

  // search screen declarations
  BuildContext? searchScreenContext;
  String? searchType;
  String? searchKeyWord;
  SearchResponseModel? searchResponse;
  TextEditingController searchController = TextEditingController();

  //reviewCart screen declarations
  ReviewCartResponseModel? reviewCartResponse;
  BuildContext? reviewCartScreenContext;
  WalletResponseModel? walletData;

  OrderResponseModel? orderResponse;

  //place order declarations
  UserAddressArray? deliveryAddress;


  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Ask the user to enable location services
      bool enableService = await askUserToEnableLocationService();
      if (!enableService) {
        // Return last known location if the user chooses not to enable location services
        return getLastKnownLocation();
      }
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Return last known location if permission is denied
        return getLastKnownLocation();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Return last known location if permission is permanently denied
      return getLastKnownLocation();
    }

    // Get current position
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position;
    } catch (e) {
      // Handle any errors while getting current position
      print('Error getting current position: $e');
      // Return last known location if there is an error
      return getLastKnownLocation();
    }
  }

  Future<Position> getLastKnownLocation() async {
    try {
      Position? position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        print('Using last known location');
        return position;
      } else {
        throw Exception('No last known location available');
      }
    } catch (e) {
      print('Error getting last known location: $e');
      throw Exception('Error getting last known location');
    }
  }
  Future<bool> askUserToEnableLocationService() async {
    // You can use your preferred method to prompt the user to enable location services
    // For example, show a dialog or navigate to the device settings
    // Return true if the user enables location services, false otherwise

    // Example using a simple dialog (this is just for illustration purposes):
    // You should implement a proper UI for your application
    bool userEnabledService = await showDialog(
      context: homePageContext!,
      // Implement your dialog here
      builder: (context) => AlertDialog(
        title: const Text("Enable Location Services"),
        content: const Text("Please enable location services for better experience."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false); // User chose not to enable
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true); // User chose to enable
            },
            child: const Text("Enable"),
          ),
        ],
      ),
    );

    return userEnabledService;
  }


  getHomeData() async {
    homeData = null;
    if (prefModel.selectedAddress != null) {
      homeData = await apiCalls.fetchHomeData(
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
      homeData = await apiCalls.fetchHomeData(
          currentPosition!.latitude, currentPosition!.longitude);
    }
    notifyListeners();
  }

  Future<void> getIntoStore(MyStore nearStoresdatum) async {
    showLoaderDialog(homePageContext!);
    storeData = await apiCalls.getStoreData(nearStoresdatum);
    if (storeData!.statusCode == 200) {
      Navigator.pop(homePageContext!);
      Navigator.pushNamed(homePageContext!, Routes.storeInRoute);
    } else {
      Navigator.pop(homePageContext!);
      showErrorToast(homePageContext!, storeData!.message!);
    }
  }

  double payable = 0.0;

  addUpdateProductToCart(ProductListProductDetail product, String operation,
      BuildContext context) async {
    double incrementQty = 1;
    var contain = prefModel.cartItems!
        .where((element) => element.productUuid == product.productUuid);
    int index = prefModel.cartItems!
        .indexWhere((element) => element.productUuid == product.productUuid);
    if (product.productUom == "KG") {
      incrementQty = 0.5;
    }
    bool shouldClearCart = prefModel.cartItems!.isNotEmpty &&
        prefModel.cartItems![0].storeUuid != product.storeUuid;

    if (shouldClearCart) {
      bool? confirmed = await showWarningDialog(context,
          "You already have items in your cart from other store,\nCart will be cleared if you wish to proceed !");
      if (!confirmed!) {
        // User didn't confirm, exit the function
        return;
      }

      prefModel.cartItems!.clear();
    }

    if (operation == 'add') {
      if (contain.isEmpty) {
        product.addedCartQuantity = incrementQty;
        prefModel.cartItems!.add(product);
      } else {
        prefModel.cartItems![index].addedCartQuantity =
            prefModel.cartItems![index].addedCartQuantity! + incrementQty;
      }
    } else if (operation == 'remove') {
      if (prefModel.cartItems![index].addedCartQuantity! > incrementQty) {
        prefModel.cartItems![index].addedCartQuantity =
            prefModel.cartItems![index].addedCartQuantity! - incrementQty;
      } else if (prefModel.cartItems![index].addedCartQuantity ==
          incrementQty) {
        prefModel.cartItems!.removeAt(index);
      }
    }
    prefModel.cartStore = storeData!.result!.storeDetails!;
    AppPref.setPref(prefModel);
    notifyListeners();
  }

  bool productExistInCart(ProductList product) {
    var contain = prefModel.cartItems!.where(
        (element) => element.productUuid == product.productDetail!.productUuid);
    if (contain.isEmpty) {
      return false;
    } else {
      return true;
    }
  }


  getProductCountInCart(ProductList product) {
    var contain = prefModel.cartItems!.where(
        (element) => element.productUuid == product.productDetail!.productUuid);
    if (contain.isEmpty) {
      return 0;
    } else {
      int index = prefModel.cartItems!.indexWhere((element) =>
          element.productUuid == product.productDetail!.productUuid);
      return prefModel.cartItems![index].addedCartQuantity!;
    }
  }

  getTotal() {
    payable = 0.0;
    for (ProductListProductDetail cartItem in prefModel.cartItems!) {
      payable = payable +
          (cartItem.productDiscountedValue! * cartItem.addedCartQuantity!);
    }
    return payable.toStringAsFixed(2);
  }

  deleteUserAddress(String? addressId, int index) async {
    showLoaderDialog(selectAddressPageContext!);
    DeleteAddressResponseModel deleteAddressResponse =
        await apiCalls.deleteAddress(addressId);
    if (deleteAddressResponse.statusCode == 200) {
      prefModel.userData!.addressArray!.removeAt(index);
      AppPref.setPref(prefModel);
      Navigator.pop(selectAddressPageContext!);
      notifyListeners();
    } else {
      Navigator.pop(selectAddressPageContext!);
      showErrorToast(selectAddressPageContext!, deleteAddressResponse.message!);
    }
  }

  getSearchResults() async {
    if (prefModel.selectedAddress != null) {
      searchResponse = await apiCalls.searchStore(searchType, searchKeyWord,
          prefModel.selectedAddress!.lat, prefModel.selectedAddress!.lng);
    } else {
      searchResponse = await apiCalls.searchStore(searchType, searchKeyWord,
          currentPosition!.latitude, currentPosition!.longitude);
    }
    if (searchResponse!.statusCode == 200) {
      notifyListeners();
    } else {
      showErrorToast(searchScreenContext!, searchResponse!.message!);
    }
    notifyListeners();
  }

  reviewMyCart() async {
    reviewCartResponse = await apiCalls.reviewCart();
    walletData = await apiCalls.getWalletData();
    if (reviewCartResponse!.statusCode == 200) {
      notifyListeners();
    } else {
      showErrorToast(reviewCartScreenContext!, reviewCartResponse!.message!);
      notifyListeners();
    }
  }


  placeOrder(int selectedValue) async {
    showLoaderDialog(reviewCartScreenContext!);
    orderResponse =
        await apiCalls.placeOrder(reviewCartResponse!.result!, selectedValue,deliveryAddress);
    if (orderResponse!.statusCode == 200) {
      prefModel.cartItems!.clear();
      deliveryAddress = null;
      AppPref.setPref(prefModel);
      notifyListeners();
      Navigator.pop(reviewCartScreenContext!);
      showSuccessToast(reviewCartScreenContext!, orderResponse!.message!);
      Navigator.pushReplacementNamed(
          reviewCartScreenContext!, Routes.orderDetailsRoute, arguments: {
        'order': orderResponse!.result!.docs,
        'message': orderResponse!.result!.message
      });
    } else {
      Navigator.pop(reviewCartScreenContext!);
      showErrorToast(reviewCartScreenContext!, orderResponse!.message!);
    }
  }

  applyWalletPoints() async {
    reviewCartResponse!.result!.calculation!.add(Calculation(
        name: 'redeemPoints',
        value: walletData!.result!.totalAvailableRedeemPoints.toString()));
    reviewCartResponse!.result!.calculation!.add(Calculation(
        name: 'redeemPointValue',
        value: walletData!.result!.totalAvailableRedeemPointsValue.toString()));
    var orderGrandTotalElement = reviewCartResponse!.result!.calculation!
        .firstWhere((element) => element.name == 'orderGrandTotal');
    orderGrandTotalElement
        .value = (double.parse(orderGrandTotalElement.value!) -
            double.parse(
                walletData!.result!.totalAvailableRedeemPointsValue.toString()))
        .toString();
    notifyListeners();
  }

  getDeliverableAddress() async {
    showLoaderDialog(reviewCartScreenContext!);
    DeliverableAddressModel deliverableAddressResponse = await apiCalls
        .getDeliverableAddress(storeData!.result!.storeDetails!.storeUuid);
    Navigator.pop(reviewCartScreenContext!);
    Navigator.pushNamed(reviewCartScreenContext!, Routes.selectAddressRoute,
        arguments: {'deliverableAddress': deliverableAddressResponse});
  }

  void setDeliveryAddress(UserAddressArray userAddressArray) {
    deliveryAddress = userAddressArray;
    showSuccessToast(
        selectAddressPageContext!, "Delivery address selected successfully");
    Navigator.pop(selectAddressPageContext!);
    notifyListeners();
  }

  String capitalizeWords(String input) {
    List<String> words = input.split(RegExp(r'(?=[A-Z])'));
    for (int i = 0; i < words.length; i++) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }
    return words.join(' ');
  }

}
