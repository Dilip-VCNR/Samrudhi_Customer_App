import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:samruddhi/address/model/delete_address_response_model.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/dashboard/models/search_response_model.dart';
import 'package:samruddhi/dashboard/models/store_data_model.dart';
import 'package:samruddhi/dashboard/orders/models/order_response_model.dart';
import 'package:samruddhi/dashboard/orders/models/review_cart_response_model.dart';
import 'package:samruddhi/database/app_pref.dart';
import 'package:samruddhi/utils/app_widgets.dart';

import '../../address/controller/location_controller.dart';
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

  addUpdateProductToCart(ProductListProductDetail product, String operation, BuildContext context) async {
    double incrementQty = 1;
    var contain = prefModel.cartItems!.where((element) => element.productUuid == product.productUuid);
    int index = prefModel.cartItems!.indexWhere((element) => element.productUuid == product.productUuid);
    if(product.productUom=="KG"){
      incrementQty=0.5;
    }
    bool shouldClearCart = prefModel.cartItems!.isNotEmpty &&
        prefModel.cartItems![0].storeUuid != product.storeUuid;

    if (shouldClearCart) {
      await showWarningDialog(context,"You already have items in your card from other store,\nCart will be cleared if you wish to proceed !",onPressed:(){
        prefModel.cartItems!.clear();
      });
    }

    if (operation == 'add') {
      if (contain.isEmpty) {
        product.addedCartQuantity = incrementQty;
        prefModel.cartItems!.add(product);
      } else {
        prefModel.cartItems![index].addedCartQuantity = prefModel.cartItems![index].addedCartQuantity! + incrementQty;
      }
    } else if (operation == 'remove') {
      if (prefModel.cartItems![index].addedCartQuantity! > incrementQty) {
        prefModel.cartItems![index].addedCartQuantity =
            prefModel.cartItems![index].addedCartQuantity! - incrementQty;
      } else if (prefModel.cartItems![index].addedCartQuantity == incrementQty) {
        prefModel.cartItems!.removeAt(index);
      }
    }
    AppPref.setPref(prefModel);
    notifyListeners();
  }

  bool productExistInCart(ProductList product) {
    var contain = prefModel.cartItems!
        .where((element) => element.productUuid == product.productDetail!.productUuid);
    if (contain.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  getProductCountInCart(ProductList product) {
    var contain = prefModel.cartItems!
        .where((element) => element.productUuid == product.productDetail!.productUuid);
    if (contain.isEmpty) {
      return 0;
    } else {
      int index = prefModel.cartItems!
          .indexWhere((element) => element.productUuid == product.productDetail!.productUuid);
      return prefModel.cartItems![index].addedCartQuantity!;
    }
  }

  getTotal() {
    payable = 0.0;
    for (ProductListProductDetail cartItem in prefModel.cartItems!) {
      payable = payable + (cartItem.productDiscountedValue! * cartItem.addedCartQuantity!);
    }
    return payable.toString();
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
      searchResponse = await apiCalls.searchStore(searchType, searchKeyWord,prefModel.selectedAddress!.lat,prefModel.selectedAddress!.lng);
    }else{
      searchResponse = await apiCalls.searchStore(searchType, searchKeyWord,currentPosition!.latitude,currentPosition!.longitude);
    }
    if(searchResponse!.statusCode==200){
      notifyListeners();
    }else{
      showErrorToast(searchScreenContext!, searchResponse!.message!);
    }
    notifyListeners();
  }

  reviewMyCart() async {
    reviewCartResponse = await apiCalls.reviewCart();
    print("case1");
    walletData = await apiCalls.getWalletData();
    print("case2");
    if(reviewCartResponse!.statusCode==200){
      notifyListeners();
      print("case3");
    }else{
      print("case4");
      showErrorToast(reviewCartScreenContext!, reviewCartResponse!.message!);
      notifyListeners();
    }
  }

  // String getTaxes() {
  //   double totalTax = 0;
  //   for(ReviewProductDetail item in reviewCartResponse!.result!.productDetails!){
  //     totalTax = totalTax+item.productTax!;
  //   }
  //   return totalTax.toStringAsFixed(2).toString();
  // }

  // String getSubTotal() {
  //   double subTotal = 0;
  //   for(ReviewProductDetail item in reviewCartResponse!.result!.productDetails!){
  //     subTotal = subTotal+double.parse(item.subTotal!);
  //   }
  //   return subTotal.toStringAsFixed(2).toString();
  // }

  placeOrder(int selectedValue) async {
    showLoaderDialog(reviewCartScreenContext!);
    orderResponse = await apiCalls.placeOrder(reviewCartResponse!.result!,selectedValue);
    if(orderResponse!.statusCode==200){
      prefModel.cartItems!.clear();
      AppPref.setPref(prefModel);
      notifyListeners();
      Navigator.pop(reviewCartScreenContext!);
      showSuccessToast(reviewCartScreenContext!, orderResponse!.message!);
      Navigator.pushReplacementNamed(reviewCartScreenContext!, Routes.orderDetailsRoute,arguments: {'order':orderResponse!.result!.docs,'message':orderResponse!.result!.message});
    }else{
      Navigator.pop(reviewCartScreenContext!);
      showErrorToast(reviewCartScreenContext!, orderResponse!.message!);
    }
  }

  applyWalletPoints() {}
}
