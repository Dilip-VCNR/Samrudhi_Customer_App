import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:samruddhi/auth/model/register_request_model.dart';
import 'package:samruddhi/dashboard/home/model/home_data_model.dart';
import 'package:samruddhi/dashboard/home/model/in_store_data_model.dart';
import 'package:samruddhi/dashboard/home/model/stores_on_category_model.dart';
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
        "x-access-token": "${prefModel.userData!.authToken}",
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
        'UID': uid!,
        'fcmToken': fcmToken!,
      }),
    );
    return LoginResponseModel.fromJson(json.decode(response.body));
  }

  Future<LoginResponseModel> registerUser(
      RegisterRequestModel userDetails) async {
    var response = await http.post(
      Uri.parse(UrlConstant.registerCustomer),
      headers: getHeaders(false),
      body: jsonEncode(userDetails),
    );
    return LoginResponseModel.fromJson(json.decode(response.body));
  }

  Future<HomeDataModel> fetchHomeData(double? lat, double? lng) async {
    var response = await http.post(
      Uri.parse(UrlConstant.userHomePage),
      headers: getHeaders(true),
      body: jsonEncode({
        "lat":lat,
        "lng":lng,
        "UID":prefModel.userData!.uid
      }),
    );
    return HomeDataModel.fromJson(json.decode(response.body));
  }

  Future<StoresOnSearchModel> fetchStoresOnCategory(BuildContext context,Map arguments) async {
    var response = await http.post(
      Uri.parse(UrlConstant.searchApi),
      headers: getHeaders(true),
      body: jsonEncode(arguments),
    );
    print(arguments);
    print(response.body);
    if(response.statusCode==200){
      return StoresOnSearchModel.fromJson(json.decode(response.body));
    }else{
      if(context.mounted){
        showErrorToast(context, "Failed to fetch stores");
      }
      throw("Failed to fetch stores");
    }
  }

  Future<InStoreDataModel> fetchInStoreData(BuildContext context, String? storeId) async {
    var response = await http.post(
      Uri.parse(UrlConstant.inStore),
      headers: getHeaders(true),
      body: jsonEncode({
        "storeId":storeId,
      }),
    );
    if(response.statusCode==200){
      return InStoreDataModel.fromJson(json.decode(response.body));
    }else{
      if(context.mounted){
        showErrorToast(context, "Failed to fetch stores");
      }
      throw("Failed to fetch stores");
    }
  }
}
