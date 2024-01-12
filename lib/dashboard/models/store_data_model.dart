// To parse this JSON data, do
//
//     final storeDataModel = storeDataModelFromJson(jsonString);

import 'dart:convert';

StoreDataModel storeDataModelFromJson(String str) => StoreDataModel.fromJson(json.decode(str));

String storeDataModelToJson(StoreDataModel data) => json.encode(data.toJson());

class StoreDataModel {
  bool? status;
  int? statusCode;
  String? message;
  Result? result;

  StoreDataModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory StoreDataModel.fromJson(Map<String, dynamic> json) => StoreDataModel(
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
  ProductCategory? productCategory;
  ProductSubCategory? productSubCategory;
  Variants? variants;
  String? id;
  String? createdAt;
  String? productUuid;
  String? productName;
  List<ProductImgArray>? productImgArray;
  String? storeUuid;
  String? storeName;
  String? description;
  bool? isMrp;
  double? sellingPrice;
  bool? isAvailable;
  String? productSku;
  String? productUom;
  double? productTax;
  double? productDiscount;
  int? productTaxValue;
  double? productOffer;
  int? productQuantity;
  int? addedCartQuantity;
  int? purchaseMinQuantity;
  int? productHsnCode;
  String? manufacturer;
  String? productModel;
  bool? isDeleted;
  int? productGrandTotal;
  int? v;

  ProductList({
    this.productCategory,
    this.productSubCategory,
    this.variants,
    this.id,
    this.createdAt,
    this.productUuid,
    this.productName,
    this.productImgArray,
    this.storeUuid,
    this.storeName,
    this.description,
    this.isMrp,
    this.sellingPrice,
    this.isAvailable,
    this.productSku,
    this.productUom,
    this.productTax,
    this.productDiscount,
    this.productTaxValue,
    this.productOffer,
    this.productQuantity,
    this.addedCartQuantity,
    this.purchaseMinQuantity,
    this.productHsnCode,
    this.manufacturer,
    this.productModel,
    this.isDeleted,
    this.productGrandTotal,
    this.v,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    productCategory: json["productCategory"] == null ? null : ProductCategory.fromJson(json["productCategory"]),
    productSubCategory: json["productSubCategory"] == null ? null : ProductSubCategory.fromJson(json["productSubCategory"]),
    variants: json["variants"] == null ? null : Variants.fromJson(json["variants"]),
    id: json["_id"],
    createdAt: json["createdAt"],
    productUuid: json["productUuid"],
    productName: json["productName"],
    productImgArray: json["productImgArray"] == null ? [] : List<ProductImgArray>.from(json["productImgArray"]!.map((x) => ProductImgArray.fromJson(x))),
    storeUuid: json["storeUuid"],
    storeName: json["storeName"],
    description: json["description"],
    isMrp: json["isMrp"],
    sellingPrice: json["sellingPrice"]?.toDouble(),
    isAvailable: json["isAvailable"],
    productSku: json["productSku"],
    productUom: json["productUom"],
    productTax: json["productTax"]?.toDouble(),
    productDiscount: json["productDiscount"]?.toDouble(),
    productTaxValue: json["productTaxValue"],
    productOffer: json["productOffer"]?.toDouble(),
    productQuantity: json["productQuantity"],
    addedCartQuantity: json["addedCartQuantity"],
    purchaseMinQuantity: json["purchaseMinQuantity"],
    productHsnCode: json["productHsnCode"],
    manufacturer: json["manufacturer"],
    productModel: json["productModel"],
    isDeleted: json["isDeleted"],
    productGrandTotal: json["productGrandTotal"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "productCategory": productCategory?.toJson(),
    "productSubCategory": productSubCategory?.toJson(),
    "variants": variants?.toJson(),
    "_id": id,
    "createdAt": createdAt,
    "productUuid": productUuid,
    "productName": productName,
    "productImgArray": productImgArray == null ? [] : List<dynamic>.from(productImgArray!.map((x) => x.toJson())),
    "storeUuid": storeUuid,
    "storeName": storeName,
    "description": description,
    "isMrp": isMrp,
    "sellingPrice": sellingPrice,
    "isAvailable": isAvailable,
    "productSku": productSku,
    "productUom": productUom,
    "productTax": productTax,
    "productDiscount": productDiscount,
    "productTaxValue": productTaxValue,
    "productOffer": productOffer,
    "productQuantity": productQuantity,
    "addedCartQuantity": addedCartQuantity,
    "purchaseMinQuantity": purchaseMinQuantity,
    "productHsnCode": productHsnCode,
    "manufacturer": manufacturer,
    "productModel": productModel,
    "isDeleted": isDeleted,
    "productGrandTotal": productGrandTotal,
    "__v": v,
  };
}

class ProductCategory {
  String? productCategoryId;
  String? productCategoryName;

  ProductCategory({
    this.productCategoryId,
    this.productCategoryName,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    productCategoryId: json["productCategoryId"],
    productCategoryName: json["productCategoryName"],
  );

  Map<String, dynamic> toJson() => {
    "productCategoryId": productCategoryId,
    "productCategoryName": productCategoryName,
  };
}

class ProductImgArray {
  String? imagePath;
  String? imageType;
  bool? isPrimary;
  String? imageDescription;
  String? id;

  ProductImgArray({
    this.imagePath,
    this.imageType,
    this.isPrimary,
    this.imageDescription,
    this.id,
  });

  factory ProductImgArray.fromJson(Map<String, dynamic> json) => ProductImgArray(
    imagePath: json["imagePath"],
    imageType: json["imageType"],
    isPrimary: json["isPrimary"],
    imageDescription: json["imageDescription"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "imagePath": imagePath,
    "imageType": imageType,
    "isPrimary": isPrimary,
    "imageDescription": imageDescription,
    "_id": id,
  };
}

class ProductSubCategory {
  String? productCategoryId;
  String? productSubCategoryId;
  String? productSubCategoryName;

  ProductSubCategory({
    this.productCategoryId,
    this.productSubCategoryId,
    this.productSubCategoryName,
  });

  factory ProductSubCategory.fromJson(Map<String, dynamic> json) => ProductSubCategory(
    productCategoryId: json["productCategoryId"],
    productSubCategoryId: json["productSubCategoryId"],
    productSubCategoryName: json["productSubCategoryName"],
  );

  Map<String, dynamic> toJson() => {
    "productCategoryId": productCategoryId,
    "productSubCategoryId": productSubCategoryId,
    "productSubCategoryName": productSubCategoryName,
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
  List<StoreAddressArray>? addressArray;
  List<StoreImgArray>? storeImgArray;
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
  List<dynamic>? documentImgArray;
  List<dynamic>? orderDeliveryDetails;
  int? v;

  StoreDetails({
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

  factory StoreDetails.fromJson(Map<String, dynamic> json) => StoreDetails(
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
    addressArray: json["addressArray"] == null ? [] : List<StoreAddressArray>.from(json["addressArray"]!.map((x) => StoreAddressArray.fromJson(x))),
    storeImgArray: json["storeImgArray"] == null ? [] : List<StoreImgArray>.from(json["storeImgArray"]!.map((x) => StoreImgArray.fromJson(x))),
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
    documentImgArray: json["documentImgArray"] == null ? [] : List<dynamic>.from(json["documentImgArray"]!.map((x) => x)),
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
    "documentImgArray": documentImgArray == null ? [] : List<dynamic>.from(documentImgArray!.map((x) => x)),
    "orderDeliveryDetails": orderDeliveryDetails == null ? [] : List<dynamic>.from(orderDeliveryDetails!.map((x) => x)),
    "__v": v,
  };
}

class StoreAddressArray {
  String? addressType;
  String? completeAddress;
  String? city;
  String? state;
  double? lat;
  double? lng;
  int? zipCode;
  bool? isDeleted;
  String? id;

  StoreAddressArray({
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

  factory StoreAddressArray.fromJson(Map<String, dynamic> json) => StoreAddressArray(
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

class StoreImgArray {
  String? imageType;
  String? imageDocName;
  String? imageUrl;
  bool? isDeleted;
  String? id;

  StoreImgArray({
    this.imageType,
    this.imageDocName,
    this.imageUrl,
    this.isDeleted,
    this.id,
  });

  factory StoreImgArray.fromJson(Map<String, dynamic> json) => StoreImgArray(
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
