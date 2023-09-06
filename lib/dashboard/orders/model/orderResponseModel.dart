// To parse this JSON data, do
//
//     final orderReqsponseModel = orderReqsponseModelFromJson(jsonString);

import 'dart:convert';

import 'orderRequestModel.dart';

OrderReqsponseModel orderReqsponseModelFromJson(String str) => OrderReqsponseModel.fromJson(json.decode(str));

String orderReqsponseModelToJson(OrderReqsponseModel data) => json.encode(data.toJson());

class OrderReqsponseModel {
  bool? status;
  int? statusCode;
  String? message;
  Result? result;

  OrderReqsponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory OrderReqsponseModel.fromJson(Map<String, dynamic> json) => OrderReqsponseModel(
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
  String? orderId;
  String? status;
  String? paymentStatus;
  String? storeId;
  DateTime? date;
  String? uid;
  String? paymentMethod;
  String? remarks;
  String? discountType;
  int? grandTotal;
  List<PaymentDetail>? paymentDetails;
  String? cableOperatorId;
  List<AdditionalCharge>? additionalCharges;
  List<ProductDetail>? productDetails;
  int? subTotal;
  int? maxWalletPoints;
  int? redeemPoints;
  int? redeemPointsValue;
  String? id;
  List<dynamic>? orderStatusTrack;
  int? v;

  Result({
    this.orderId,
    this.status,
    this.paymentStatus,
    this.storeId,
    this.date,
    this.uid,
    this.paymentMethod,
    this.remarks,
    this.discountType,
    this.grandTotal,
    this.paymentDetails,
    this.cableOperatorId,
    this.additionalCharges,
    this.productDetails,
    this.subTotal,
    this.maxWalletPoints,
    this.redeemPoints,
    this.redeemPointsValue,
    this.id,
    this.orderStatusTrack,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    orderId: json["orderId"],
    status: json["status"],
    paymentStatus: json["paymentStatus"],
    storeId: json["storeId"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    uid: json["UID"],
    paymentMethod: json["paymentMethod"],
    remarks: json["remarks"],
    discountType: json["discountType"],
    grandTotal: json["grandTotal"],
    paymentDetails: json["paymentDetails"] == null ? [] : List<PaymentDetail>.from(json["paymentDetails"]!.map((x) => PaymentDetail.fromJson(x))),
    cableOperatorId: json["cableOperatorId"],
    additionalCharges: json["additionalCharges"] == null ? [] : List<AdditionalCharge>.from(json["additionalCharges"]!.map((x) => AdditionalCharge.fromJson(x))),
    productDetails: json["productDetails"] == null ? [] : List<ProductDetail>.from(json["productDetails"]!.map((x) => ProductDetail.fromJson(x))),
    subTotal: json["subTotal"],
    maxWalletPoints: json["MaxWalletPoints"],
    redeemPoints: json["redeemPoints"],
    redeemPointsValue: json["redeemPointsValue"],
    id: json["_id"],
    orderStatusTrack: json["orderStatusTrack"] == null ? [] : List<dynamic>.from(json["orderStatusTrack"]!.map((x) => x)),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "status": status,
    "paymentStatus": paymentStatus,
    "storeId": storeId,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "UID": uid,
    "paymentMethod": paymentMethod,
    "remarks": remarks,
    "discountType": discountType,
    "grandTotal": grandTotal,
    "paymentDetails": paymentDetails == null ? [] : List<dynamic>.from(paymentDetails!.map((x) => x.toJson())),
    "cableOperatorId": cableOperatorId,
    "additionalCharges": additionalCharges == null ? [] : List<dynamic>.from(additionalCharges!.map((x) => x.toJson())),
    "productDetails": productDetails == null ? [] : List<dynamic>.from(productDetails!.map((x) => x.toJson())),
    "subTotal": subTotal,
    "MaxWalletPoints": maxWalletPoints,
    "redeemPoints": redeemPoints,
    "redeemPointsValue": redeemPointsValue,
    "_id": id,
    "orderStatusTrack": orderStatusTrack == null ? [] : List<dynamic>.from(orderStatusTrack!.map((x) => x)),
    "__v": v,
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
