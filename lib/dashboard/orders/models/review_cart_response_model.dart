// To parse this JSON data, do
//
//     final reviewCartResponseModel = reviewCartResponseModelFromJson(jsonString);

import 'dart:convert';

ReviewCartResponseModel reviewCartResponseModelFromJson(String str) => ReviewCartResponseModel.fromJson(json.decode(str));

String reviewCartResponseModelToJson(ReviewCartResponseModel data) => json.encode(data.toJson());

class ReviewCartResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  ReviewCartResult? result;

  ReviewCartResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory ReviewCartResponseModel.fromJson(Map<String, dynamic> json) => ReviewCartResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"] == null ? null : ReviewCartResult.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result?.toJson(),
  };
}

class ReviewCartResult {
  List<ReviewProductDetail>? productDetails;
  String? customerUuid;
  String? orderGrandTotal;

  ReviewCartResult({
    this.productDetails,
    this.customerUuid,
    this.orderGrandTotal,
  });

  factory ReviewCartResult.fromJson(Map<String, dynamic> json) => ReviewCartResult(
    productDetails: json["productDetails"] == null ? [] : List<ReviewProductDetail>.from(json["productDetails"]!.map((x) => ReviewProductDetail.fromJson(x))),
    customerUuid: json["customerUuid"],
    orderGrandTotal: json["orderGrandTotal"],
  );

  Map<String, dynamic> toJson() => {
    "productDetails": productDetails == null ? [] : List<dynamic>.from(productDetails!.map((x) => x.toJson())),
    "customerUuid": customerUuid,
    "orderGrandTotal": orderGrandTotal,
  };
}

class ReviewProductDetail {
  ProductCategory? productCategory;
  ProductSubCategory? productSubCategory;
  Variants? variants;
  String? id;
  String? createdAt;
  String? productUuid;
  String? productName;
  String? storeUuid;
  String? storeName;
  String? description;
  bool? isMrp;
  int? sellingPrice;
  bool? isAvailable;
  String? productSku;
  String? productUom;
  int? productTax;
  int? productDiscount;
  int? productOffer;
  int? productQuantity;
  int? addedCartQuantity;
  int? purchaseMinQuantity;
  int? productHsnCode;
  String? manufacturer;
  String? productModel;
  bool? isDeleted;
  double? productGrandTotal;
  List<dynamic>? productImgArray;
  int? v;
  double? subTotal;
  double? taxAdded;

  ReviewProductDetail({
    this.productCategory,
    this.productSubCategory,
    this.variants,
    this.id,
    this.createdAt,
    this.productUuid,
    this.productName,
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
    this.productOffer,
    this.productQuantity,
    this.addedCartQuantity,
    this.purchaseMinQuantity,
    this.productHsnCode,
    this.manufacturer,
    this.productModel,
    this.isDeleted,
    this.productGrandTotal,
    this.productImgArray,
    this.v,
    this.subTotal,
    this.taxAdded,
  });

  factory ReviewProductDetail.fromJson(Map<String, dynamic> json) => ReviewProductDetail(
    productCategory: json["productCategory"] == null ? null : ProductCategory.fromJson(json["productCategory"]),
    productSubCategory: json["productSubCategory"] == null ? null : ProductSubCategory.fromJson(json["productSubCategory"]),
    variants: json["variants"] == null ? null : Variants.fromJson(json["variants"]),
    id: json["_id"],
    createdAt: json["createdAt"],
    productUuid: json["productUuid"],
    productName: json["productName"],
    storeUuid: json["storeUuid"],
    storeName: json["storeName"],
    description: json["description"],
    isMrp: json["isMrp"],
    sellingPrice: json["sellingPrice"],
    isAvailable: json["isAvailable"],
    productSku: json["productSku"],
    productUom: json["productUom"],
    productTax: json["productTax"],
    productDiscount: json["productDiscount"],
    productOffer: json["productOffer"],
    productQuantity: json["productQuantity"],
    addedCartQuantity: json["addedCartQuantity"],
    purchaseMinQuantity: json["purchaseMinQuantity"],
    productHsnCode: json["productHsnCode"],
    manufacturer: json["manufacturer"],
    productModel: json["productModel"],
    isDeleted: json["isDeleted"],
    productGrandTotal: json["productGrandTotal"]?.toDouble(),
    productImgArray: json["productImgArray"] == null ? [] : List<dynamic>.from(json["productImgArray"]!.map((x) => x)),
    v: json["__v"],
    subTotal: json["subTotal"]==null?0.0:json["subTotal"].toDouble(),
    taxAdded: json["taxAdded"]==null?0.0:json["taxAdded"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "productCategory": productCategory?.toJson(),
    "productSubCategory": productSubCategory?.toJson(),
    "variants": variants?.toJson(),
    "_id": id,
    "createdAt": createdAt,
    "productUuid": productUuid,
    "productName": productName,
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
    "productOffer": productOffer,
    "productQuantity": productQuantity,
    "addedCartQuantity": addedCartQuantity,
    "purchaseMinQuantity": purchaseMinQuantity,
    "productHsnCode": productHsnCode,
    "manufacturer": manufacturer,
    "productModel": productModel,
    "isDeleted": isDeleted,
    "productGrandTotal": productGrandTotal,
    "productImgArray": productImgArray == null ? [] : List<dynamic>.from(productImgArray!.map((x) => x)),
    "__v": v,
    "subTotal": subTotal,
    "taxAdded": taxAdded,
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
