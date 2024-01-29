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
  int? overAlldiscountAmount;
  String? orderGrandTotal;
  String? customerUuid;

  ReviewCartResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
    this.overAlldiscountAmount,
    this.orderGrandTotal,
    this.customerUuid,
  });

  factory ReviewCartResponseModel.fromJson(Map<String, dynamic> json) => ReviewCartResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"] == null ? null : ReviewCartResult.fromJson(json["result"]),
    overAlldiscountAmount: json["OverAlldiscountAmount"],
    orderGrandTotal: json["orderGrandTotal"],
    customerUuid: json["customerUuid"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result?.toJson(),
    "OverAlldiscountAmount": overAlldiscountAmount,
    "orderGrandTotal": orderGrandTotal,
    "customerUuid": customerUuid,
  };
}

class ReviewCartResult {
  List<ProductDetail>? productDetails;
  List<Calculation>? calculation;

  ReviewCartResult({
    this.productDetails,
    this.calculation,
  });

  factory ReviewCartResult.fromJson(Map<String, dynamic> json) => ReviewCartResult(
    productDetails: json["productDetails"] == null ? [] : List<ProductDetail>.from(json["productDetails"]!.map((x) => ProductDetail.fromJson(x))),
    calculation: json["calculation"] == null ? [] : List<Calculation>.from(json["calculation"]!.map((x) => Calculation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "productDetails": productDetails == null ? [] : List<dynamic>.from(productDetails!.map((x) => x.toJson())),
    "calculation": calculation == null ? [] : List<dynamic>.from(calculation!.map((x) => x.toJson())),
  };
}

class Calculation {
  String? name;
  String? value;
  String? message;

  Calculation({
    this.name,
    this.value,
    this.message,
  });

  factory Calculation.fromJson(Map<String, dynamic> json) => Calculation(
    name: json["name"],
    value: json["value"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
    "message": message,
  };
}

class ProductDetail {
  ProductCategory? productCategory;
  ProductSubCategory? productSubCategory;
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
  int? productDiscountedValue;
  int? productQuantity;
  int? addedCartQuantity;
  bool? isReturnable;
  bool? isPerishable;
  int? productHsnCode;
  String? manufacturer;
  String? productModel;
  bool? isDeleted;
  List<ProductImgArray>? productImgArray;
  int? v;
  int? taxableValue;
  double? productTaxValue;
  int? productSubTotal;
  int? productGrandTotal;

  ProductDetail({
    this.productCategory,
    this.productSubCategory,
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
    this.productDiscountedValue,
    this.productQuantity,
    this.addedCartQuantity,
    this.isReturnable,
    this.isPerishable,
    this.productHsnCode,
    this.manufacturer,
    this.productModel,
    this.isDeleted,
    this.productImgArray,
    this.v,
    this.taxableValue,
    this.productTaxValue,
    this.productSubTotal,
    this.productGrandTotal,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    productCategory: json["productCategory"] == null ? null : ProductCategory.fromJson(json["productCategory"]),
    productSubCategory: json["productSubCategory"] == null ? null : ProductSubCategory.fromJson(json["productSubCategory"]),
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
    productDiscountedValue: json["productDiscountedValue"],
    productQuantity: json["productQuantity"],
    addedCartQuantity: json["addedCartQuantity"],
    isReturnable: json["isReturnable"],
    isPerishable: json["isPerishable"],
    productHsnCode: json["productHsnCode"],
    manufacturer: json["manufacturer"],
    productModel: json["productModel"],
    isDeleted: json["isDeleted"],
    productImgArray: json["productImgArray"] == null ? [] : List<ProductImgArray>.from(json["productImgArray"]!.map((x) => ProductImgArray.fromJson(x))),
    v: json["__v"],
    taxableValue: json["taxableValue"],
    productTaxValue: json["productTaxValue"]?.toDouble(),
    productSubTotal: json["productSubTotal"],
    productGrandTotal: json["productGrandTotal"],
  );

  Map<String, dynamic> toJson() => {
    "productCategory": productCategory?.toJson(),
    "productSubCategory": productSubCategory?.toJson(),
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
    "productDiscountedValue": productDiscountedValue,
    "productQuantity": productQuantity,
    "addedCartQuantity": addedCartQuantity,
    "isReturnable": isReturnable,
    "isPerishable": isPerishable,
    "productHsnCode": productHsnCode,
    "manufacturer": manufacturer,
    "productModel": productModel,
    "isDeleted": isDeleted,
    "productImgArray": productImgArray == null ? [] : List<dynamic>.from(productImgArray!.map((x) => x.toJson())),
    "__v": v,
    "taxableValue": taxableValue,
    "productTaxValue": productTaxValue,
    "productSubTotal": productSubTotal,
    "productGrandTotal": productGrandTotal,
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
  String? productSubCategoryId;
  String? productSubCategoryName;

  ProductSubCategory({
    this.productSubCategoryId,
    this.productSubCategoryName,
  });

  factory ProductSubCategory.fromJson(Map<String, dynamic> json) => ProductSubCategory(
    productSubCategoryId: json["productSubCategoryId"],
    productSubCategoryName: json["productSubCategoryName"],
  );

  Map<String, dynamic> toJson() => {
    "productSubCategoryId": productSubCategoryId,
    "productSubCategoryName": productSubCategoryName,
  };
}
