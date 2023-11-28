// To parse this JSON data, do
//
//     final registerUserResponseModel = registerUserResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterUserResponseModel registerUserResponseModelFromJson(String str) => RegisterUserResponseModel.fromJson(json.decode(str));

String registerUserResponseModelToJson(RegisterUserResponseModel data) => json.encode(data.toJson());

class RegisterUserResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  Result? result;

  RegisterUserResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory RegisterUserResponseModel.fromJson(Map<String, dynamic> json) => RegisterUserResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result?.toJson(),
  };
}

class Result {
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
  String? operatorUuid;
  String? operatorType;
  String? storeReferralCode;
  String? cableSubscriberUuid;
  List<ProfileImgArray>? profileImgArray;
  bool? isApproved;
  bool? isDeleted;
  String? id;
  int? v;

  Result({
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
    this.id,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
    id: json["_id"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
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
    "_id": id,
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
