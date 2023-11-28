// To parse this JSON data, do
//
//     final checkUserResponseModel = checkUserResponseModelFromJson(jsonString);

import 'dart:convert';

CheckUserResponseModel checkUserResponseModelFromJson(String str) => CheckUserResponseModel.fromJson(json.decode(str));

String checkUserResponseModelToJson(CheckUserResponseModel data) => json.encode(data.toJson());

class CheckUserResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  UserDataModel? result;

  CheckUserResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory CheckUserResponseModel.fromJson(Map<String, dynamic> json) => CheckUserResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"] == null ? null : UserDataModel.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result?.toJson(),
  };
}

class UserDataModel {
  String? id;
  String? createdAt;
  String? customerUid;
  String? customerUuid;
  String? firstName;
  String? lastName;
  String? emailId;
  String? password;
  int? mobile;
  String? customerAuthToken;
  String? customerFcmToken;
  String? operatorUuid;
  String? operatorType;
  String? storeReferralCode;
  String? cableSubscriberUuid;
  bool? isApproved;
  bool? isDeleted;
  List<AddressArray>? addressArray;
  List<dynamic>? profileImgArray;
  int? v;
  String? updatedAt;

  UserDataModel({
    this.id,
    this.createdAt,
    this.customerUid,
    this.customerUuid,
    this.firstName,
    this.lastName,
    this.emailId,
    this.password,
    this.mobile,
    this.customerAuthToken,
    this.customerFcmToken,
    this.operatorUuid,
    this.operatorType,
    this.storeReferralCode,
    this.cableSubscriberUuid,
    this.isApproved,
    this.isDeleted,
    this.addressArray,
    this.profileImgArray,
    this.v,
    this.updatedAt,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    id: json["_id"],
    createdAt: json["createdAt"],
    customerUid: json["customerUID"],
    customerUuid: json["customerUuid"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    emailId: json["emailId"],
    password: json["password"],
    mobile: json["mobile"],
    customerAuthToken: json["customerAuthToken"],
    customerFcmToken: json["customerFcmToken"],
    operatorUuid: json["operatorUuid"],
    operatorType: json["operatorType"],
    storeReferralCode: json["storeReferralCode"],
    cableSubscriberUuid: json["cableSubscriberUuid"],
    isApproved: json["isApproved"],
    isDeleted: json["isDeleted"],
    addressArray: json["addressArray"] == null ? [] : List<AddressArray>.from(json["addressArray"]!.map((x) => AddressArray.fromJson(x))),
    profileImgArray: json["profileImgArray"] == null ? [] : List<dynamic>.from(json["profileImgArray"]!.map((x) => x)),
    v: json["__v"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdAt": createdAt,
    "customerUID": customerUid,
    "customerUuid": customerUuid,
    "firstName": firstName,
    "lastName": lastName,
    "emailId": emailId,
    "password": password,
    "mobile": mobile,
    "customerAuthToken": customerAuthToken,
    "customerFcmToken": customerFcmToken,
    "operatorUuid": operatorUuid,
    "operatorType": operatorType,
    "storeReferralCode": storeReferralCode,
    "cableSubscriberUuid": cableSubscriberUuid,
    "isApproved": isApproved,
    "isDeleted": isDeleted,
    "addressArray": addressArray == null ? [] : List<dynamic>.from(addressArray!.map((x) => x.toJson())),
    "profileImgArray": profileImgArray == null ? [] : List<dynamic>.from(profileImgArray!.map((x) => x)),
    "__v": v,
    "updatedAt": updatedAt,
  };
}

class AddressArray {
  String? addressType;
  String? completeAddress;
  String? city;
  String? state;
  double? lat;
  double? lng;
  int? zipCode;
  bool? isDeleted;
  String? id;

  AddressArray({
    this.addressType,
    this.completeAddress,
    this.city,
    this.state,
    this.lat,
    this.lng,
    this.zipCode,
    this.isDeleted,
    this.id,
  });

  factory AddressArray.fromJson(Map<String, dynamic> json) => AddressArray(
    addressType: json["addressType"],
    completeAddress: json["completeAddress"],
    city: json["city"],
    state: json["state"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    zipCode: json["zipCode"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "addressType": addressType,
    "completeAddress": completeAddress,
    "city": city,
    "state": state,
    "lat": lat,
    "lng": lng,
    "zipCode": zipCode,
    "isDeleted": isDeleted,
    "_id": id,
  };
}
