// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  UserData? result;

  LoginResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"] == null ? null : UserData.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result?.toJson(),
  };
}

class UserData{
  String? id;
  String? password;
  String? authToken;
  String? name;
  bool? status;
  int? mobile;
  String? operatorId;
  String? emailId;
  String? storeReferralCode;
  String? uid;
  List<Address>? address;
  String? fcmToken;
  int? v;
  DateTime? updatedAt;

  UserData({
    this.id,
    this.password,
    this.authToken,
    this.name,
    this.status,
    this.mobile,
    this.operatorId,
    this.emailId,
    this.storeReferralCode,
    this.uid,
    this.address,
    this.fcmToken,
    this.v,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    password: json["password"],
    authToken: json["authToken"],
    name: json["name"],
    status: json["status"],
    mobile: json["mobile"],
    operatorId: json["operatorId"],
    emailId: json["emailId"],
    storeReferralCode: json["storeReferralCode"],
    uid: json["UID"],
    address: json["address"] == null ? [] : List<Address>.from(json["address"]!.map((x) => Address.fromJson(x))),
    fcmToken: json["fcmToken"],
    v: json["__v"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "password": password,
    "authToken": authToken,
    "name": name,
    "status": status,
    "mobile": mobile,
    "operatorId": operatorId,
    "emailId": emailId,
    "storeReferralCode": storeReferralCode,
    "UID": uid,
    "address": address == null ? [] : List<dynamic>.from(address!.map((x) => x.toJson())),
    "fcmToken": fcmToken,
    "__v": v,
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Address {
  String? type;
  String? address;
  String? zipCode;
  String? city;
  String? state;
  double? lat;
  double? lng;
  String? id;

  Address({
    this.type,
    this.address,
    this.zipCode,
    this.city,
    this.state,
    this.lat,
    this.lng,
    this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    type: json["type"],
    address: json["address"],
    zipCode: json["zipCode"],
    city: json["city"],
    state: json["state"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "address": address,
    "zipCode": zipCode,
    "city": city,
    "state": state,
    "lat": lat,
    "lng": lng,
    "_id": id,
  };
}
