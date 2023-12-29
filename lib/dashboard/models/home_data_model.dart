// To parse this JSON data, do
//
//     final homeDataModel = homeDataModelFromJson(jsonString);

import 'dart:convert';

HomeDataModel homeDataModelFromJson(String str) => HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
  bool? status;
  int? statusCode;
  String? message;
  Result? result;

  HomeDataModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
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
  List<dynamic>? previousOrders;
  List<NearStoresdatum>? nearStoresdata;
  List<dynamic>? myStore;
  List<ProductCategory>? productCategories;
  List<dynamic>? banners;

  Result({
    this.previousOrders,
    this.nearStoresdata,
    this.myStore,
    this.productCategories,
    this.banners,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    previousOrders: json["previousOrders"] == null ? [] : List<dynamic>.from(json["previousOrders"]!.map((x) => x)),
    nearStoresdata: json["nearStoresdata"] == null ? [] : List<NearStoresdatum>.from(json["nearStoresdata"]!.map((x) => NearStoresdatum.fromJson(x))),
    myStore: json["myStore"] == null ? [] : List<dynamic>.from(json["myStore"]!.map((x) => x)),
    productCategories: json["productCategories"] == null ? [] : List<ProductCategory>.from(json["productCategories"]!.map((x) => ProductCategory.fromJson(x))),
    banners: json["banners"] == null ? [] : List<dynamic>.from(json["banners"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "previousOrders": previousOrders == null ? [] : List<dynamic>.from(previousOrders!.map((x) => x)),
    "nearStoresdata": nearStoresdata == null ? [] : List<dynamic>.from(nearStoresdata!.map((x) => x.toJson())),
    "myStore": myStore == null ? [] : List<dynamic>.from(myStore!.map((x) => x)),
    "productCategories": productCategories == null ? [] : List<dynamic>.from(productCategories!.map((x) => x.toJson())),
    "banners": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x)),
  };
}

class NearStoresdatum {
  String? id;
  String? createdAt;
  bool? isHeadquarters;
  String? storeUid;
  String? storeUuid;
  String? storeName;
  String? displayName;
  String? gstNo;
  String? referralcode;
  int? mobile;
  String? emailId;
  String? password;
  List<AddressArray>? addressArray;
  List<ImgArray>? storeImgArray;
  String? storeFcmToken;
  String? storeAuthToken;
  String? storeCategoryId;
  String? storeCategoryName;
  String? zone;
  String? deliveryType;
  int? deliveryFee;
  String? hubUuid;
  int? storeOffer;
  bool? isApproved;
  bool? isDeleted;
  bool? isHomeDelivery;
  dynamic operatorUuid;
  List<ImgArray>? documentImgArray;
  List<dynamic>? orderDeliveryDetails;
  int? v;

  NearStoresdatum({
    this.id,
    this.createdAt,
    this.isHeadquarters,
    this.storeUid,
    this.storeUuid,
    this.storeName,
    this.displayName,
    this.gstNo,
    this.referralcode,
    this.mobile,
    this.emailId,
    this.password,
    this.addressArray,
    this.storeImgArray,
    this.storeFcmToken,
    this.storeAuthToken,
    this.storeCategoryId,
    this.storeCategoryName,
    this.zone,
    this.deliveryType,
    this.deliveryFee,
    this.hubUuid,
    this.storeOffer,
    this.isApproved,
    this.isDeleted,
    this.isHomeDelivery,
    this.operatorUuid,
    this.documentImgArray,
    this.orderDeliveryDetails,
    this.v,
  });

  factory NearStoresdatum.fromJson(Map<String, dynamic> json) => NearStoresdatum(
    id: json["_id"],
    createdAt: json["createdAt"],
    isHeadquarters: json["isHeadquarters"],
    storeUid: json["storeUID"],
    storeUuid: json["storeUuid"],
    storeName: json["storeName"],
    displayName: json["displayName"],
    gstNo: json["gstNo"],
    referralcode: json["referralcode"],
    mobile: json["mobile"],
    emailId: json["emailId"],
    password: json["password"],
    addressArray: json["addressArray"] == null ? [] : List<AddressArray>.from(json["addressArray"]!.map((x) => AddressArray.fromJson(x))),
    storeImgArray: json["storeImgArray"] == null ? [] : List<ImgArray>.from(json["storeImgArray"]!.map((x) => ImgArray.fromJson(x))),
    storeFcmToken: json["storeFcmToken"],
    storeAuthToken: json["storeAuthToken"],
    storeCategoryId: json["storeCategoryId"],
    storeCategoryName: json["storeCategoryName"],
    zone: json["zone"],
    deliveryType: json["deliveryType"],
    deliveryFee: json["deliveryFee"],
    hubUuid: json["hubUuid"],
    storeOffer: json["storeOffer"],
    isApproved: json["isApproved"],
    isDeleted: json["isDeleted"],
    isHomeDelivery: json["isHomeDelivery"],
    operatorUuid: json["operatorUuid"],
    documentImgArray: json["documentImgArray"] == null ? [] : List<ImgArray>.from(json["documentImgArray"]!.map((x) => ImgArray.fromJson(x))),
    orderDeliveryDetails: json["orderDeliveryDetails"] == null ? [] : List<dynamic>.from(json["orderDeliveryDetails"]!.map((x) => x)),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "createdAt": createdAt,
    "isHeadquarters": isHeadquarters,
    "storeUID": storeUid,
    "storeUuid": storeUuid,
    "storeName": storeName,
    "displayName": displayName,
    "gstNo": gstNo,
    "referralcode": referralcode,
    "mobile": mobile,
    "emailId": emailId,
    "password": password,
    "addressArray": addressArray == null ? [] : List<dynamic>.from(addressArray!.map((x) => x.toJson())),
    "storeImgArray": storeImgArray == null ? [] : List<dynamic>.from(storeImgArray!.map((x) => x.toJson())),
    "storeFcmToken": storeFcmToken,
    "storeAuthToken": storeAuthToken,
    "storeCategoryId": storeCategoryId,
    "storeCategoryName": storeCategoryName,
    "zone": zone,
    "deliveryType": deliveryType,
    "deliveryFee": deliveryFee,
    "hubUuid": hubUuid,
    "storeOffer": storeOffer,
    "isApproved": isApproved,
    "isDeleted": isDeleted,
    "isHomeDelivery": isHomeDelivery,
    "operatorUuid": operatorUuid,
    "documentImgArray": documentImgArray == null ? [] : List<dynamic>.from(documentImgArray!.map((x) => x.toJson())),
    "orderDeliveryDetails": orderDeliveryDetails == null ? [] : List<dynamic>.from(orderDeliveryDetails!.map((x) => x)),
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

class ImgArray {
  String? imageType;
  String? imageDocName;
  String? imageUrl;
  String? id;
  bool? isDeleted;

  ImgArray({
    this.imageType,
    this.imageDocName,
    this.imageUrl,
    this.id,
    this.isDeleted,
  });

  factory ImgArray.fromJson(Map<String, dynamic> json) => ImgArray(
    imageType: json["imageType"],
    imageDocName: json["imageDocName"],
    imageUrl: json["imageURL"],
    id: json["_id"],
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "imageType": imageType,
    "imageDocName": imageDocName,
    "imageURL": imageUrl,
    "_id": id,
    "isDeleted": isDeleted,
  };
}

class ProductCategory {
  String? id;
  String? productCategoryId;
  String? productCategoryName;
  List<ProductCategoryImgArray>? productCategoryImgArray;
  String? description;
  bool? isDeleted;
  int? v;

  ProductCategory({
    this.id,
    this.productCategoryId,
    this.productCategoryName,
    this.productCategoryImgArray,
    this.description,
    this.isDeleted,
    this.v,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    id: json["_id"],
    productCategoryId: json["productCategoryId"],
    productCategoryName: json["productCategoryName"],
    productCategoryImgArray: json["productCategoryImgArray"] == null ? [] : List<ProductCategoryImgArray>.from(json["productCategoryImgArray"]!.map((x) => ProductCategoryImgArray.fromJson(x))),
    description: json["description"],
    isDeleted: json["isDeleted"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productCategoryId": productCategoryId,
    "productCategoryName": productCategoryName,
    "productCategoryImgArray": productCategoryImgArray == null ? [] : List<dynamic>.from(productCategoryImgArray!.map((x) => x.toJson())),
    "description": description,
    "isDeleted": isDeleted,
    "__v": v,
  };
}

class ProductCategoryImgArray {
  String? imagePath;
  String? imageType;
  String? id;

  ProductCategoryImgArray({
    this.imagePath,
    this.imageType,
    this.id,
  });

  factory ProductCategoryImgArray.fromJson(Map<String, dynamic> json) => ProductCategoryImgArray(
    imagePath: json["imagePath"],
    imageType: json["imageType"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "imagePath": imagePath,
    "imageType": imageType,
    "_id": id,
  };
}
