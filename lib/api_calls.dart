import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:samruddhi/auth/models/register_response_model.dart';
import 'package:samruddhi/dashboard/models/home_data_model.dart';
import 'package:samruddhi/utils/url_constants.dart';

import 'auth/models/login_response_model.dart';
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
    print(request.fields);
    print(request.files);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseJson = json.decode(utf8.decode(responseData));
    return RegisterResponseModel.fromJson(responseJson);
  }

  Future<HomeDataModel>fetchHomeData(double latitude, double longitude) async {
    http.Response response = await hitApi(
        true,
        UrlConstant.userHomePage,
        jsonEncode({
          "customerUuid": prefModel.userData!.customerUuid,
          "lat": latitude,
          "lng": longitude
        }));
    print(response.body);
    if(response.statusCode==201){
      return HomeDataModel.fromJson(json.decode(response.body));
    }else{
      throw "err loading";
    }
  }
}
