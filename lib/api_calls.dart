import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:samruddhi/address/model/delete_address_response_model.dart';
import 'package:samruddhi/auth/models/register_response_model.dart';
import 'package:samruddhi/dashboard/models/home_data_model.dart';
import 'package:samruddhi/dashboard/models/search_response_model.dart';
import 'package:samruddhi/dashboard/orders/models/all_orders_model.dart';
import 'package:samruddhi/dashboard/orders/models/order_response_model.dart';
import 'package:samruddhi/dashboard/orders/models/review_cart_response_model.dart';
import 'package:samruddhi/dashboard/wallet/models/wallet_response_model.dart';
import 'package:samruddhi/utils/url_constants.dart';

import 'auth/models/login_response_model.dart';
import 'dashboard/models/store_data_model.dart';
import 'database/app_pref.dart';
import 'database/models/pref_model.dart';

String platform = Platform.isIOS ? "IOS" : "Android";
PrefModel prefModel = AppPref.getPref();

class ApiCalls {
  Map<String, String> getHeaders(bool isAuthEnabled) {
    var headers = <String, String>{};
    if (isAuthEnabled) {
      headers.addAll({
        "x-access-token": "${prefModel.userData!.customerAuthToken}",
        "Content-Type": "application/json"
      });
    } else {
      headers.addAll({"Content-Type": "application/json"});
    }
    return headers;
  }

  Future<http.Response> hitApi(
      bool requiresAuth, String url, String body) async {
    return await http.post(
      Uri.parse(url),
      headers: getHeaders(requiresAuth),
      body: body,
    );
  }

  Future<LoginResponseModel> getUserDetails(String uid, String fcmToken) async {
    http.Response response = await hitApi(false, UrlConstant.userDetails,
        jsonEncode({"customerUuid": uid, "customerFcmToken": fcmToken}));
    return LoginResponseModel.fromJson(json.decode(response.body));
  }

  registerNewUser(
      String firstName,
      String lastName,
      String? latestUid,
      String email,
      String phone,
      String? fcmToken,
      String operatorCode,
      String operatorType,
      String storeReferralCode,
      String cableSubscriberId,
      String addressType,
      String completeAddress,
      String city,
      String state,
      double latitude,
      double longitude,
      String postalCode,
      File? selectedImage) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(UrlConstant.registerUser));
    // Add form fields
    request.fields['firstName'] = firstName;
    request.fields['lastName'] = lastName;
    request.fields['customerUuid'] = latestUid!;
    request.fields['emailId'] = email;
    request.fields['mobile'] = phone;
    request.fields['customerFcmToken'] = fcmToken!;
    request.fields['operatorUuid'] = operatorCode;
    request.fields['operatorType'] = operatorType;
    request.fields['storeReferralCode'] = storeReferralCode;
    request.fields['cableSubscriberUuid'] = cableSubscriberId;
    request.fields['addressType'] = addressType;
    request.fields['completeAddress'] = completeAddress;
    request.fields['city'] = city;
    request.fields['state'] = state;
    request.fields['lat'] = latitude.toString();
    request.fields['lng'] = longitude.toString();
    request.fields['zipCode'] = postalCode;

    if (selectedImage != null) {
      var picStream = http.ByteStream(selectedImage.openRead());
      var length = await selectedImage.length();
      var multipartFile = http.MultipartFile(
        'userImage',
        picStream,
        length,
        filename: selectedImage.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(multipartFile);
    }
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseJson = json.decode(utf8.decode(responseData));
    return RegisterResponseModel.fromJson(responseJson);
  }

  Future<HomeDataModel> fetchHomeData(double latitude, double longitude) async {
    http.Response response = await hitApi(
        true,
        UrlConstant.userHomePage,
        jsonEncode({
          "customerUuid": prefModel.userData!.customerUuid,
          "lat": latitude,
          "lng": longitude
        }));
    log(response.body);
    return HomeDataModel.fromJson(json.decode(response.body));
  }

  Future<StoreDataModel> getStoreData(MyStore nearStoresdatum) async {
    http.Response response = await hitApi(
        true,
        UrlConstant.getStoreData,
        jsonEncode({
          "storeUuid": nearStoresdatum.storeUuid,
        }));
    log(response.body);
    return StoreDataModel.fromJson(json.decode(response.body));
  }

  Future<LoginResponseModel>apiAddNewAddress(LatLng? selectedLocation, String selectedAddressType,
      String completeAddress, String city, String state, String postalCode) async {
    http.Response response = await hitApi(
        true,
        UrlConstant.addNewAddress,
        jsonEncode({
          "customerUuid": prefModel.userData!.customerUuid,
          "addressArray": [
            {
              "addressType": selectedAddressType,
              "completeAddress": completeAddress,
              "city": city,
              "state": state,
              "lat": selectedLocation!.latitude,
              "lng": selectedLocation.longitude,
              "zipCode": postalCode
            }]

        }));
    return LoginResponseModel.fromJson(json.decode(response.body));
  }

  Future<DeleteAddressResponseModel> deleteAddress(String? addressId) async {
    http.Response response = await hitApi(
        true,
        UrlConstant.deleteAddress,
        jsonEncode({
          "customerUuid": prefModel.userData!.customerUuid,
          "addressId": addressId
        }));
    return DeleteAddressResponseModel.fromJson(json.decode(response.body));
  }

  Future<SearchResponseModel> searchStore(String? searchType ,String? searchKeyword, double? lat, double? lng) async {
    http.Response response = await hitApi(
        true,
        UrlConstant.searchApiUrl,
        jsonEncode({
          "searchType":searchType,
          "searchKeyWord":searchKeyword,
          "lat":lat,
          "lng":lng
        }));
    return SearchResponseModel.fromJson(json.decode(response.body));
  }

  Future<ReviewCartResponseModel>reviewCart() async {
    http.Response response = await hitApi(
        true,
        UrlConstant.reviewCart,
        jsonEncode({
          "customerUuid":prefModel.userData!.customerUuid,
          "storeUuid":prefModel.cartItems![0].storeUuid,
          "productDetails":prefModel.cartItems,
        }));
    log(response.body);
    return ReviewCartResponseModel.fromJson(json.decode(response.body));
  }

  Future<OrderResponseModel>placeOrder(ReviewCartResult result, int selectedValue) async {
    Map req = result.toJson();
    req['storeUuid'] = result.productDetails![0].storeUuid;
    req['deliveryAddress'] = prefModel.selectedAddress!.toJson();
    req['orderDeliveryType'] = selectedValue==1?"homeDelivery":"selfPickUp";
    http.Response response = await hitApi(
        true,
        UrlConstant.placeOrder,
        jsonEncode(req));
    log(response.body);
    return OrderResponseModel.fromJson(json.decode(response.body));

  }

  Future<WalletResponseModel> getWalletData() async {
    http.Response response = await hitApi(
        true,
        UrlConstant.getWallet,
        jsonEncode({
          'customerUuid':prefModel.userData!.customerUuid
        }));
    log(response.body);
    return WalletResponseModel.fromJson(json.decode(response.body));

  }

  Future<AllOrdersResponseModel>getAllOrders() async {
    http.Response response = await hitApi(
        true,
        UrlConstant.getOrders,
        jsonEncode({
          'customerUuid':prefModel.userData!.customerUuid,
        }));
    log(response.body);
    return AllOrdersResponseModel.fromJson(json.decode(response.body));
  }
}
