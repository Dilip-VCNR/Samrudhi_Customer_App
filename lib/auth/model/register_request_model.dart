// To parse this JSON data, do
//
//     final registerRequestModel = registerRequestModelFromJson(jsonString);

import 'dart:convert';

RegisterRequestModel registerRequestModelFromJson(String str) =>
    RegisterRequestModel.fromJson(json.decode(str));

String registerRequestModelToJson(RegisterRequestModel data) =>
    json.encode(data.toJson());

class RegisterRequestModel {
  String? uid;
  String? fcmToken;
  int? mobile;
  String? name;
  String? emailId;
  String? password;
  String? type;
  String? address;
  String? city;
  String? state;
  String? zipCode;
  double? lat;
  double? lng;
  String? storeReferralCode;
  String? operatorId;
  String? subscriberId;

  RegisterRequestModel({
    this.uid,
    this.fcmToken,
    this.mobile,
    this.name,
    this.emailId,
    this.password,
    this.type,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.lat,
    this.lng,
    this.storeReferralCode,
    this.operatorId,
    this.subscriberId,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      RegisterRequestModel(
        uid: json["UID"],
        fcmToken: json["fcmToken"],
        mobile: json["mobile"],
        name: json["name"],
        emailId: json["emailId"],
        password: json["password"],
        type: json["type"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zipCode"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        storeReferralCode: json["storeReferralCode"],
        operatorId: json["operatorId"],
        subscriberId: json["subscriberId"],
      );

  Map<String, dynamic> toJson() => {
        "UID": uid,
        "fcmToken": fcmToken,
        "mobile": mobile,
        "name": name,
        "emailId": emailId,
        "password": password,
        "type": type,
        "address": address,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "lat": lat,
        "lng": lng,
        "storeReferralCode": storeReferralCode,
        "operatorId": operatorId,
        "subscriberId": subscriberId,
      };
}
