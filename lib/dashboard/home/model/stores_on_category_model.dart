// To parse this JSON data, do
//
//     final storesOnSearchModel = storesOnSearchModelFromJson(jsonString);

import 'dart:convert';

StoresOnSearchModel storesOnSearchModelFromJson(String str) =>
    StoresOnSearchModel.fromJson(json.decode(str));

String storesOnSearchModelToJson(StoresOnSearchModel data) =>
    json.encode(data.toJson());

class StoresOnSearchModel {
  bool? status;
  int? statusCode;
  String? message;
  List<Result>? result;

  StoresOnSearchModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory StoresOnSearchModel.fromJson(Map<String, dynamic> json) =>
      StoresOnSearchModel(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  StoreAddress? address;
  String? id;
  String? storeId;
  String? storeName;
  String? displayName;
  String? gstNo;
  int? mobile;
  String? emailId;
  String? password;
  String? image;
  String? storeFcmToken;
  String? storeAuthToken;
  String? storeUid;
  String? storeCategory;
  bool? isApproved;
  bool? status;
  String? zone;
  String? deliveryType;
  bool? homeDelivery;
  String? hubId;
  int? offer;
  int? deliveryFee;
  int? v;

  Result({
    this.address,
    this.id,
    this.storeId,
    this.storeName,
    this.displayName,
    this.gstNo,
    this.mobile,
    this.emailId,
    this.password,
    this.image,
    this.storeFcmToken,
    this.storeAuthToken,
    this.storeUid,
    this.storeCategory,
    this.isApproved,
    this.status,
    this.zone,
    this.deliveryType,
    this.homeDelivery,
    this.hubId,
    this.offer,
    this.deliveryFee,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        address: json["address"] == null
            ? null
            : StoreAddress.fromJson(json["address"]),
        id: json["_id"],
        storeId: json["storeId"],
        storeName: json["storeName"],
        displayName: json["displayName"],
        gstNo: json["gstNo"],
        mobile: json["mobile"],
        emailId: json["emailId"],
        password: json["password"],
        image: json["image"],
        storeFcmToken: json["storeFcmToken"],
        storeAuthToken: json["storeAuthToken"],
        storeUid: json["storeUID"],
        storeCategory: json["storeCategory"],
        isApproved: json["isApproved"],
        status: json["status"],
        zone: json["zone"],
        deliveryType: json["deliveryType"],
        homeDelivery: json["homeDelivery"],
        hubId: json["hubId"],
        offer: json["offer"],
        deliveryFee: json["deliveryFee"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "_id": id,
        "storeId": storeId,
        "storeName": storeName,
        "displayName": displayName,
        "gstNo": gstNo,
        "mobile": mobile,
        "emailId": emailId,
        "password": password,
        "image": image,
        "storeFcmToken": storeFcmToken,
        "storeAuthToken": storeAuthToken,
        "storeUID": storeUid,
        "storeCategory": storeCategory,
        "isApproved": isApproved,
        "status": status,
        "zone": zone,
        "deliveryType": deliveryType,
        "homeDelivery": homeDelivery,
        "hubId": hubId,
        "offer": offer,
        "deliveryFee": deliveryFee,
        "__v": v,
      };
}

class StoreAddress {
  String? address;
  int? zipCode;
  String? city;
  String? state;
  double? lat;
  double? lng;

  StoreAddress({
    this.address,
    this.zipCode,
    this.city,
    this.state,
    this.lat,
    this.lng,
  });

  factory StoreAddress.fromJson(Map<String, dynamic> json) => StoreAddress(
        address: json["address"],
        zipCode: json["zipCode"],
        city: json["city"],
        state: json["state"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "zipCode": zipCode,
        "city": city,
        "state": state,
        "lat": lat,
        "lng": lng,
      };
}
