// To parse this JSON data, do
//
//     final registerUserRequestModel = registerUserRequestModelFromJson(jsonString);

import 'dart:convert';

RegisterUserRequestModel registerUserRequestModelFromJson(String str) => RegisterUserRequestModel.fromJson(json.decode(str));

String registerUserRequestModelToJson(RegisterUserRequestModel data) => json.encode(data.toJson());

class RegisterUserRequestModel {
  String? firstName;
  String? lastName;
  String? customerUuid;
  String? emailId;
  String? password;
  String? mobile;
  String? customerFcmToken;
  String? operatorUuid;
  String? operatorType;
  String? storeReferralCode;
  String? cableSubscriberUuid;
  String? addressType;
  String? completeAddress;
  String? city;
  String? state;
  String? lat;
  String? lng;
  String? zipCode;

  RegisterUserRequestModel({
    this.firstName,
    this.lastName,
    this.customerUuid,
    this.emailId,
    this.password,
    this.mobile,
    this.customerFcmToken,
    this.operatorUuid,
    this.operatorType,
    this.storeReferralCode,
    this.cableSubscriberUuid,
    this.addressType,
    this.completeAddress,
    this.city,
    this.state,
    this.lat,
    this.lng,
    this.zipCode,
  });

  factory RegisterUserRequestModel.fromJson(Map<String, dynamic> json) => RegisterUserRequestModel(
    firstName: json["firstName"],
    lastName: json["lastName"],
    customerUuid: json["customerUuid"],
    emailId: json["emailId"],
    password: json["password"],
    mobile: json["mobile"],
    customerFcmToken: json["customerFcmToken"],
    operatorUuid: json["operatorUuid"],
    operatorType: json["operatorType"],
    storeReferralCode: json["storeReferralCode"],
    cableSubscriberUuid: json["cableSubscriberUuid"],
    addressType: json["addressType"],
    completeAddress: json["completeAddress"],
    city: json["city"],
    state: json["state"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    zipCode: json["zipCode"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "customerUuid": customerUuid,
    "emailId": emailId,
    "password": password,
    "mobile": mobile,
    "customerFcmToken": customerFcmToken,
    "operatorUuid": operatorUuid,
    "operatorType": operatorType,
    "storeReferralCode": storeReferralCode,
    "cableSubscriberUuid": cableSubscriberUuid,
    "addressType": addressType,
    "completeAddress": completeAddress,
    "city": city,
    "state": state,
    "lat": lat,
    "lng": lng,
    "zipCode": zipCode,
  };
}
