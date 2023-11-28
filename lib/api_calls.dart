import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:samruddhi/auth/models/check_user_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:samruddhi/auth/models/register_user_response_model.dart';
import 'package:samruddhi/utils/url_constants.dart';

import 'database/app_pref.dart';
import 'database/models/pref_model.dart';

class ApiCalls{

  PrefModel prefModel = AppPref.getPref();

  String platform = Platform.isIOS ? "IOS" : "Android";

  Future<http.Response> hitApiPost(
      bool requiresAuth, String url, String body) async {
    return await http.post(
      Uri.parse(url),
      headers: getHeaders(requiresAuth),
      body: body,
    );
  }

  Future<http.Response> hitApiGet(
      bool requiresAuth, String url) async {
    return await http.get(
      Uri.parse(url),
      headers: getHeaders(requiresAuth),
    );
  }

  Map<String, String> getHeaders(bool isAuthEnabled) {
    var headers = <String, String>{};
    if (isAuthEnabled) {
      headers.addAll({
        "x-access-token": prefModel.userdata!.customerAuthToken!,
        "Content-Type": "application/json"
      });
    } else {
      headers.addAll({"Content-Type": "application/json"});
    }
    return headers;
  }

  Future<CheckUserResponseModel>checkForUser(User? user, String? fcmToken) async {
    http.Response response = await hitApiPost(false, UrlConstant.checkForUserApi, jsonEncode({
      "customerUuid":user!.uid,
      "customerFcmToken":fcmToken
    }));
    print(response.statusCode);
    print(response.body);
    return CheckUserResponseModel.fromJson(json.decode(response.body));
  }

  Future<RegisterUserResponseModel>registerNewCustomer(BuildContext context, Map<String, dynamic> reqData) async {
    var request = http.MultipartRequest('POST', Uri.parse(UrlConstant.registerUser));
    reqData.forEach((key, value) {
      request.fields[key] = value.toString();
    });
    print(request.fields);
    var response = await http.Response.fromStream(await request.send());
    print(response.statusCode);
    print(response.body);
    return RegisterUserResponseModel.fromJson(json.decode(response.body));
  }

}