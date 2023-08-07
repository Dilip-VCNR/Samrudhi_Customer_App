// To parse this JSON data, do
//
//     final storeResponseModel = storeResponseModelFromJson(jsonString);

import 'dart:convert';

StoreResponseModel storeResponseModelFromJson(String str) =>
    StoreResponseModel.fromJson(json.decode(str));

String storeResponseModelToJson(StoreResponseModel data) =>
    json.encode(data.toJson());

class StoreResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  List<StoreProducts>? result;

  StoreResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory StoreResponseModel.fromJson(Map<String, dynamic> json) =>
      StoreResponseModel(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<StoreProducts>.from(
                json["result"]!.map((x) => StoreProducts.fromJson(x))),
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

class StoreProducts {
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
  int? v;
  int? cartCount;

  StoreProducts({
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
    this.v,
    this.cartCount,
  });

  factory StoreProducts.fromJson(Map<String, dynamic> json) => StoreProducts(
        variants: json["variants"] == null
            ? null
            : Variants.fromJson(json["variants"]),
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
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
        v: json["__v"],
        cartCount: json["cartCount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "variants": variants?.toJson(),
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
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
        "__v": v,
        "cartCount": cartCount ?? 0,
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
