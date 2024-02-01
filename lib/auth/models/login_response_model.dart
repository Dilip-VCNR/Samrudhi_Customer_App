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
  UserDetailsModel? result;

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
    result: json["result"] == null ? null : UserDetailsModel.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result?.toJson(),
  };
}

class UserDetailsModel {
  String? id;
  String? createdAt;
  String? customerUid;
  String? customerUuid;
  String? firstName;
  String? lastName;
  String? emailId;
  String? password;
  int? mobile;
  List<AddressArray>? addressArray;
  String? customerAuthToken;
  String? customerFcmToken;
  dynamic operatorUuid;
  dynamic operatorType;
  dynamic storeReferralCode;
  dynamic cableSubscriberUuid;
  List<ProfileImgArray>? profileImgArray;
  bool? isApproved;
  bool? isDeleted;
  int? v;

  UserDetailsModel({
    this.id,
    this.createdAt,
    this.customerUid,
    this.customerUuid,
    this.firstName,
    this.lastName,
    this.emailId,
    this.password,
    this.mobile,
    this.addressArray,
    this.customerAuthToken,
    this.customerFcmToken,
    this.operatorUuid,
    this.operatorType,
    this.storeReferralCode,
    this.cableSubscriberUuid,
    this.profileImgArray,
    this.isApproved,
    this.isDeleted,
    this.v,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
    id: json["_id"],
    createdAt: json["createdAt"],
    customerUid: json["customerUID"],
    customerUuid: json["customerUuid"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    emailId: json["emailId"],
    password: json["password"],
    mobile: json["mobile"],
    addressArray: json["addressArray"] == null ? [] : List<AddressArray>.from(json["addressArray"]!.map((x) => AddressArray.fromJson(x))),
    customerAuthToken: json["customerAuthToken"],
    customerFcmToken: json["customerFcmToken"],
    operatorUuid: json["operatorUuid"],
    operatorType: json["operatorType"],
    storeReferralCode: json["storeReferralCode"],
    cableSubscriberUuid: json["cableSubscriberUuid"],
    profileImgArray: json["profileImgArray"] == null ? [] : List<ProfileImgArray>.from(json["profileImgArray"]!.map((x) => ProfileImgArray.fromJson(x))),
    isApproved: json["isApproved"],
    isDeleted: json["isDeleted"],
    v: json["__v"],
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
    "addressArray": addressArray == null ? [] : List<dynamic>.from(addressArray!.map((x) => x.toJson())),
    "customerAuthToken": customerAuthToken,
    "customerFcmToken": customerFcmToken,
    "operatorUuid": operatorUuid,
    "operatorType": operatorType,
    "storeReferralCode": storeReferralCode,
    "cableSubscriberUuid": cableSubscriberUuid,
    "profileImgArray": profileImgArray == null ? [] : List<dynamic>.from(profileImgArray!.map((x) => x.toJson())),
    "isApproved": isApproved,
    "isDeleted": isDeleted,
    "__v": v,
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

class ProfileImgArray {
  String? imageType;
  String? imageDocName;
  String? imageUrl;
  bool? isDeleted;
  String? id;

  ProfileImgArray({
    this.imageType,
    this.imageDocName,
    this.imageUrl,
    this.isDeleted,
    this.id,
  });

  factory ProfileImgArray.fromJson(Map<String, dynamic> json) => ProfileImgArray(
    imageType: json["imageType"],
    imageDocName: json["imageDocName"],
    imageUrl: json["imageURL"],
    isDeleted: json["isDeleted"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "imageType": imageType,
    "imageDocName": imageDocName,
    "imageURL": imageUrl,
    "isDeleted": isDeleted,
    "_id": id,
  };
}
