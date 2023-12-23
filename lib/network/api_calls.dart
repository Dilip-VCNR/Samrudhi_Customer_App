import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:samruddhi/auth/model/register_request_model.dart';
import 'package:samruddhi/dashboard/home/model/home_data_model.dart';
import 'package:samruddhi/dashboard/home/model/in_store_data_model.dart';
import 'package:samruddhi/dashboard/home/model/stores_on_category_model.dart';
import 'package:samruddhi/dashboard/orders/model/my_orders_model.dart';
import 'package:samruddhi/dashboard/orders/model/orderRequestModel.dart';
import 'package:samruddhi/dashboard/orders/model/orderResponseModel.dart';
import 'package:samruddhi/dashboard/wallet/model/wallet_response_model.dart';
import 'package:samruddhi/utils/app_widgets.dart';

import '../auth/model/login_response_model.dart';
import '../database/app_pref.dart';
import '../database/models/pref_model.dart';
import '../utils/url_constants.dart';

class ApiCalls {
  PrefModel prefModel = AppPref.getPref();

  String platform = Platform.isIOS ? "IOS" : "Android";

  Future<http.Response> hitApi(
      bool requiresAuth, String url, String body) async {
    return await http.post(
      Uri.parse(url),
      headers: getHeaders(requiresAuth),
      body: body,
    );
  }

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

  Future<LoginResponseModel> getUserDetails(
      String? uid, String? fcmToken) async {
    var response = await http.post(
      Uri.parse(UrlConstant.getUser),
      headers: getHeaders(false),
      body: jsonEncode(<String, String>{
        'customerUuid': uid!,
        'customerFcmToken': fcmToken!,
      }),
    );
    return LoginResponseModel.fromJson(json.decode(response.body));
  }

  Future<LoginResponseModel> registerUser(
      RegisterRequestModel userDetails) async {
    Map reqData = userDetails.toJson();
    var request =
        http.MultipartRequest('POST', Uri.parse(UrlConstant.registerCustomer));
    // var response = await http.post(
    //   Uri.parse(UrlConstant.registerCustomer),
    //   headers: getHeaders(false),
    //   body: jsonEncode(userDetails),
    // );
    reqData.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    var response = await http.Response.fromStream(await request.send());
    return LoginResponseModel.fromJson(json.decode(response.body));
  }

  Future<HomeDataModel> fetchHomeData(double? lat, double? lng) async {
    var response = await http.post(
      Uri.parse(UrlConstant.userHomePage),
      headers: getHeaders(true),
      body: jsonEncode({
        "lat": lat,
        "lng": lng,
        "customerUuid": prefModel.userData!.customerUuid
      }),
    );
    return HomeDataModel.fromJson(json.decode(response.body));
  }

  Future<StoresOnSearchModel> fetchStoresOnCategory(
      BuildContext context, Map arguments) async {
    var response = await http.post(
      Uri.parse(UrlConstant.searchApi),
      headers: getHeaders(true),
      body: jsonEncode(arguments),
    );
    if (response.statusCode == 200) {
      return StoresOnSearchModel.fromJson(json.decode(response.body));
    } else {
      if (context.mounted) {
        showErrorToast(context, "Failed to fetch stores");
      }
      throw ("Failed to fetch stores");
    }
  }

  Future<InStoreDataModel> fetchInStoreData(
      BuildContext context, String? storeId) async {
    var response = await http.post(
      Uri.parse(UrlConstant.inStore),
      headers: getHeaders(true),
      body: jsonEncode({
        "storeId": storeId,
      }),
    );
    log(response.body);
    if (response.statusCode == 200) {
      return InStoreDataModel.fromJson(json.decode(response.body));
    } else {
      if (context.mounted) {
        showErrorToast(context, "Failed to fetch stores");
      }
      throw ("Failed to fetch stores");
    }
  }

  addNewAddress(BuildContext context, Map<String, Object> arguments) async {
    arguments['customerUuid'] = prefModel.userData!.customerUuid!;
    var response = await http.post(
      Uri.parse(UrlConstant.addNewAddress),
      headers: getHeaders(true),
      body: jsonEncode(arguments),
    );
    Navigator.pop(context);
    if (LoginResponseModel.fromJson(json.decode(response.body)).statusCode ==
        200) {
      prefModel.userData =
          LoginResponseModel.fromJson(json.decode(response.body)).result;
      await AppPref.setPref(prefModel);
      showSuccessToast(context,
          LoginResponseModel.fromJson(json.decode(response.body)).message!);
      await getUserDetails(prefModel.userData!.customerUuid,
          prefModel.userData!.customerFcmToken);
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      showErrorToast(context,
          LoginResponseModel.fromJson(json.decode(response.body)).message!);
    }
  }

  Future<MyOrdersModel> getOrderHistory(BuildContext context) async {
    var response = await http.post(
      Uri.parse(UrlConstant.orderHistory),
      headers: getHeaders(true),
      body: jsonEncode({
        "UID": prefModel.userData!.customerUuid!,
        "fromdate": "2023-07-28",
        "todate": "2023-09-22",
      }),
    );
    log(response.body);
    if (response.statusCode == 201) {
      return MyOrdersModel.fromJson(json.decode(response.body));
    } else {
      if (context.mounted) {
        showErrorToast(context, "Failed to get orders");
      }
      throw ("Failed to get orders");
    }
  }

  Future<WalletResponseModel> getCustomerPoints(BuildContext context) async {
    var response = await http.post(
      Uri.parse(UrlConstant.getCustomerPoints),
      headers: getHeaders(true),
      body: jsonEncode({
        "UID": prefModel.userData!.customerUuid!,
      }),
    );
    if (response.statusCode == 201) {
      if (context.mounted) {
        Navigator.pop(context);
      }
      return WalletResponseModel.fromJson(json.decode(response.body));
    } else {
      if (context.mounted) {
        Navigator.pop(context);
        showErrorToast(context, "Failed to fetch wallet points");
      }
      throw ("Failed to fetch wallet points");
    }
  }

  Future<WalletResponseModel> placeOrder(BuildContext context) async {
    var response = await http.post(
      Uri.parse(UrlConstant.getCustomerPoints),
      headers: getHeaders(true),
      body: jsonEncode({
        "UID": prefModel.userData!.customerUuid!,
      }),
    );
    if (response.statusCode == 201) {
      if (context.mounted) {
        Navigator.pop(context);
      }
      return WalletResponseModel.fromJson(json.decode(response.body));
    } else {
      if (context.mounted) {
        Navigator.pop(context);
        showErrorToast(context, "Failed to fetch wallet points");
      }
      throw ("Failed to fetch wallet points");
    }
  }

  Future<OrderReqsponseModel> createOrder(
      BuildContext context, OrderRequestModel orderRequest) async {
    orderRequest.uid = prefModel.userData!.customerUuid;
    var response = await http.post(
      Uri.parse(UrlConstant.placeOrder),
      headers: getHeaders(true),
      body: jsonEncode(orderRequest),
    );
    if (response.statusCode == 201) {
      if (context.mounted) {
        prefModel.cartPayable = 0;
        prefModel.cartItemsStoreId = null;
        prefModel.cartItems = [];
        AppPref.setPref(prefModel);
        Navigator.pop(context);
      }
      return OrderReqsponseModel.fromJson(json.decode(response.body));
    } else {
      if (context.mounted) {
        Navigator.pop(context);
        showErrorToast(context, "Failed to create order");
      }
      throw ("Failed to create order");
    }
  }

  deleteCustomerAddress(BuildContext context, String? addressId) async {
    var response = await http.post(
      Uri.parse(UrlConstant.deleteCustomerAddress),
      headers: getHeaders(true),
      body: jsonEncode({
        "customerUuid": prefModel.userData!.customerUuid,
        "addressId": addressId
      }),
    );
    LoginResponseModel userData = await getUserDetails(
        prefModel.userData!.customerUuid, prefModel.userData!.customerFcmToken);

    prefModel.userData = userData.result;
    await AppPref.setPref(prefModel);

    Navigator.pop(context);
    if (json.decode(response.body)['statusCode'] == 200) {
      showSuccessToast(context, json.decode(response.body)['message']);
    } else {
      showErrorToast(context, json.decode(response.body)['message']);
    }
  }
}
