// To parse this JSON data, do
//
//     final inStoreDataModel = inStoreDataModelFromJson(jsonString);

import 'dart:convert';

InStoreDataModel inStoreDataModelFromJson(String str) => InStoreDataModel.fromJson(json.decode(str));

String inStoreDataModelToJson(InStoreDataModel data) => json.encode(data.toJson());

class InStoreDataModel {
  bool? status;
  int? statusCode;
  String? message;
  Result? result;

  InStoreDataModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory InStoreDataModel.fromJson(Map<String, dynamic> json) => InStoreDataModel(
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
  StoreDetails? storeDetails;
  List<ProductDetail>? productDetails;

  Result({
    this.storeDetails,
    this.productDetails,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    storeDetails: json["storeDetails"] == null ? null : StoreDetails.fromJson(json["storeDetails"]),
    productDetails: json["productDetails"] == null ? [] : List<ProductDetail>.from(json["productDetails"]!.map((x) => ProductDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "storeDetails": storeDetails?.toJson(),
    "productDetails": productDetails == null ? [] : List<dynamic>.from(productDetails!.map((x) => x.toJson())),
  };
}

class ProductDetail {
  String? productCategories;
  List<ProductList>? productList;

  ProductDetail({
    this.productCategories,
    this.productList,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    productCategories: json["productCategories"],
    productList: json["productList"] == null ? [] : List<ProductList>.from(json["productList"]!.map((x) => ProductList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "productCategories": productCategories,
    "productList": productList == null ? [] : List<dynamic>.from(productList!.map((x) => x.toJson())),
  };
}

class ProductList {
  Variants? variants;
  String? id;
  DateTime? createdAt;
  String? productName;
  String? image;
  String? storeId;
  String? storeName;
  String? productCategory;
  String? subCategory;
  String? description;
  int? mrp;
  int? tax;
  int? sellingPrice;
  bool? availability;
  String? sku;
  String? uom;
  int? discount;
  int? offer;
  bool? status;
  String? productId;
  int? purchaseQuantity;
  int? v;
  int? cartCount;

  ProductList({
    this.variants,
    this.id,
    this.createdAt,
    this.productName,
    this.image,
    this.storeId,
    this.storeName,
    this.productCategory,
    this.subCategory,
    this.description,
    this.mrp,
    this.tax,
    this.sellingPrice,
    this.availability,
    this.sku,
    this.uom,
    this.discount,
    this.offer,
    this.status,
    this.productId,
    this.purchaseQuantity,
    this.v,
    this.cartCount,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    variants: json["variants"] == null ? null : Variants.fromJson(json["variants"]),
    id: json["_id"],
    productName: json["productName"],
    image: json["image"],
    storeId: json["storeId"],
    storeName: json["storeName"],
    productCategory: json["productCategory"],
    subCategory: json["subCategory"],
    description: json["description"],
    mrp: json["mrp"],
    tax: json["tax"],
    sellingPrice: json["sellingPrice"],
    availability: json["availability"],
    sku: json["SKU"],
    uom: json["uom"],
    discount: json["discount"],
    offer: json["offer"],
    status: json["status"],
    productId: json["productId"],
    purchaseQuantity: json["purchaseQuantity"],
    v: json["__v"],
    cartCount: json["cartCount"] ?? 0,
  );


  Map<String, dynamic> toJson() => {
    "variants": variants?.toJson(),
    "_id": id,
    "productName": productName,
    "image": image,
    "storeId": storeId,
    "storeName": storeName,
    "productCategory": productCategory,
    "subCategory": subCategory,
    "description": description,
    "mrp": mrp,
    "tax": tax,
    "sellingPrice": sellingPrice,
    "availability": availability,
    "SKU": sku,
    "uom": uom,
    "discount": discount,
    "offer": offer,
    "status": status,
    "productId": productId,
    "purchaseQuantity": purchaseQuantity,
    "__v": v,
    "cartCount": cartCount,
  };
}

class Variants {
  String? color;
  String? size;
  String? quality;

  Variants({
    this.color,
    this.size,
    this.quality,
  });

  factory Variants.fromJson(Map<String, dynamic> json) => Variants(
    color: json["color"],
    size: json["size"],
    quality: json["quality"],
  );

  Map<String, dynamic> toJson() => {
    "color": color,
    "size": size,
    "quality": quality,
  };
}

class StoreDetails {
  StoreAddress? address;
  String? id;
  DateTime? createdAt;
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

  StoreDetails({
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

  factory StoreDetails.fromJson(Map<String, dynamic> json) => StoreDetails(
    address: json["address"] == null ? null : StoreAddress.fromJson(json["address"]),
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
