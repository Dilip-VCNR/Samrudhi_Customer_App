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
  List<PreviousOrder>? previousOrders;
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
    previousOrders: json["previousOrders"] == null ? [] : List<PreviousOrder>.from(json["previousOrders"]!.map((x) => PreviousOrder.fromJson(x))),
    nearStoresdata: json["nearStoresdata"] == null ? [] : List<NearStoresdatum>.from(json["nearStoresdata"]!.map((x) => NearStoresdatum.fromJson(x))),
    myStore: json["myStore"] == null ? [] : List<dynamic>.from(json["myStore"]!.map((x) => x)),
    productCategories: json["productCategories"] == null ? [] : List<ProductCategory>.from(json["productCategories"]!.map((x) => ProductCategory.fromJson(x))),
    banners: json["banners"] == null ? [] : List<dynamic>.from(json["banners"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "previousOrders": previousOrders == null ? [] : List<dynamic>.from(previousOrders!.map((x) => x.toJson())),
    "nearStoresdata": nearStoresdata == null ? [] : List<dynamic>.from(nearStoresdata!.map((x) => x.toJson())),
    "myStore": myStore == null ? [] : List<dynamic>.from(myStore!.map((x) => x)),
    "productCategories": productCategories == null ? [] : List<dynamic>.from(productCategories!.map((x) => x.toJson())),
    "banners": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x)),
  };
}

class NearStoresdatum {
  StoreAddress? address;
  String? id;
  String? createdAt;
  String? storeId;
  String? storeName;
  String? displayName;
  String? gstNo;
  double? mobile;
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
  double? offer;
  int? deliveryFee;
  int? v;
  String? updatedAt;

  NearStoresdatum({
    this.address,
    this.id,
    this.createdAt,
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
    this.updatedAt,
  });

  factory NearStoresdatum.fromJson(Map<String, dynamic> json) => NearStoresdatum(
    address: json["address"] == null ? null : StoreAddress.fromJson(json["address"]),
    id: json["_id"],
    createdAt: json["createdAt"],
    storeId: json["storeId"],
    storeName: json["storeName"],
    displayName: json["displayName"],
    gstNo: json["gstNo"],
    mobile: json["mobile"]?.toDouble(),
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
    offer: json["offer"]?.toDouble(),
    deliveryFee: json["deliveryFee"],
    v: json["__v"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "address": address?.toJson(),
    "_id": id,
    "createdAt": createdAt,
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
    "updatedAt": updatedAt,
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

class PreviousOrder {
  List<ProductDetail>? productDetails;
  String? storeId;

  PreviousOrder({
    this.productDetails,
    this.storeId,
  });

  factory PreviousOrder.fromJson(Map<String, dynamic> json) => PreviousOrder(
    productDetails: json["productDetails"] == null ? [] : List<ProductDetail>.from(json["productDetails"]!.map((x) => ProductDetail.fromJson(x))),
    storeId: json["storeId"],
  );

  Map<String, dynamic> toJson() => {
    "productDetails": productDetails == null ? [] : List<dynamic>.from(productDetails!.map((x) => x.toJson())),
    "storeId": storeId,
  };
}

class ProductDetail {
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
  Variants? variants;
  bool? availability;
  String? sku;
  String? uom;
  int? discount;
  int? offer;
  bool? status;
  String? productId;
  int? purchaseQuantity;

  ProductDetail({
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
    this.variants,
    this.availability,
    this.sku,
    this.uom,
    this.discount,
    this.offer,
    this.status,
    this.productId,
    this.purchaseQuantity,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
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
    variants: json["variants"] == null ? null : Variants.fromJson(json["variants"]),
    availability: json["availability"],
    sku: json["SKU"],
    uom: json["uom"],
    discount: json["discount"],
    offer: json["offer"],
    status: json["status"],
    productId: json["productId"],
    purchaseQuantity: json["purchaseQuantity"],
  );

  Map<String, dynamic> toJson() => {
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
    "variants": variants?.toJson(),
    "availability": availability,
    "SKU": sku,
    "uom": uom,
    "discount": discount,
    "offer": offer,
    "status": status,
    "productId": productId,
    "purchaseQuantity": purchaseQuantity,
  };
}

class Variants {
  String? quality;

  Variants({
    this.quality,
  });

  factory Variants.fromJson(Map<String, dynamic> json) => Variants(
    quality: json["quality"],
  );

  Map<String, dynamic> toJson() => {
    "quality": quality,
  };
}

class ProductCategory {
  String? id;
  String? productCategoryName;
  String? image;
  String? description;
  String? productCategoryId;
  bool? status;
  int? v;
  String? updatedAt;

  ProductCategory({
    this.id,
    this.productCategoryName,
    this.image,
    this.description,
    this.productCategoryId,
    this.status,
    this.v,
    this.updatedAt,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    id: json["_id"],
    productCategoryName: json["productCategoryName"],
    image: json["image"],
    description: json["description"],
    productCategoryId: json["productCategoryId"],
    status: json["status"],
    v: json["__v"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productCategoryName": productCategoryName,
    "image": image,
    "description": description,
    "productCategoryId": productCategoryId,
    "status": status,
    "__v": v,
    "updatedAt": updatedAt,
  };
}
