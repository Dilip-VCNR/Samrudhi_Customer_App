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
  List<dynamic>? nearStoresdata;
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
    nearStoresdata: json["nearStoresdata"] == null ? [] : List<dynamic>.from(json["nearStoresdata"]!.map((x) => x)),
    myStore: json["myStore"] == null ? [] : List<dynamic>.from(json["myStore"]!.map((x) => x)),
    productCategories: json["productCategories"] == null ? [] : List<ProductCategory>.from(json["productCategories"]!.map((x) => ProductCategory.fromJson(x))),
    banners: json["banners"] == null ? [] : List<dynamic>.from(json["banners"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "previousOrders": previousOrders == null ? [] : List<dynamic>.from(previousOrders!.map((x) => x)),
    "nearStoresdata": nearStoresdata == null ? [] : List<dynamic>.from(nearStoresdata!.map((x) => x)),
    "myStore": myStore == null ? [] : List<dynamic>.from(myStore!.map((x) => x)),
    "productCategories": productCategories == null ? [] : List<dynamic>.from(productCategories!.map((x) => x.toJson())),
    "banners": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x)),
  };
}

class ProductCategory {
  String? id;
  String? productCategoryId;
  String? productCategoryName;
  bool? isDeleted;
  List<ProductCategoryImgArray>? productCategoryImgArray;
  int? v;
  String? description;

  ProductCategory({
    this.id,
    this.productCategoryId,
    this.productCategoryName,
    this.isDeleted,
    this.productCategoryImgArray,
    this.v,
    this.description,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    id: json["_id"],
    productCategoryId: json["productCategoryId"],
    productCategoryName: json["productCategoryName"],
    isDeleted: json["isDeleted"],
    productCategoryImgArray: json["productCategoryImgArray"] == null ? [] : List<ProductCategoryImgArray>.from(json["productCategoryImgArray"]!.map((x) => ProductCategoryImgArray.fromJson(x))),
    v: json["__v"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productCategoryId": productCategoryId,
    "productCategoryName": productCategoryName,
    "isDeleted": isDeleted,
    "productCategoryImgArray": productCategoryImgArray == null ? [] : List<dynamic>.from(productCategoryImgArray!.map((x) => x.toJson())),
    "__v": v,
    "description": description,
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
