// To parse this JSON data, do
//
//     final orderRequestModel = orderRequestModelFromJson(jsonString);

import 'dart:convert';

import '../../home/model/in_store_data_model.dart';

OrderRequestModel orderRequestModelFromJson(String str) => OrderRequestModel.fromJson(json.decode(str));

String orderRequestModelToJson(OrderRequestModel data) => json.encode(data.toJson());

class OrderRequestModel {
  String? uid;
  String? storeId;
  String? status;
  String? paymentStatus;
  String? paymentMethod;
  String? remarks;
  String? discountType;
  List<ProductList>? productList;
  List<PaymentDetail>? paymentDetails;
  double? subTotal;
  List<AdditionalCharge>? additionalCharges;
  double? grandTotal;
  int? redeemPoints;
  int? redeemPointsValue;
  int? maxWalletPoints;
  String? cableOperatorId;

  OrderRequestModel({
    this.uid,
    this.storeId,
    this.status,
    this.paymentStatus,
    this.paymentMethod,
    this.remarks,
    this.discountType,
    this.productList,
    this.paymentDetails,
    this.subTotal,
    this.additionalCharges,
    this.grandTotal,
    this.redeemPoints,
    this.redeemPointsValue,
    this.maxWalletPoints,
    this.cableOperatorId,
  });

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) => OrderRequestModel(
    uid: json["UID"],
    storeId: json["storeId"],
    status: json["status"],
    paymentStatus: json["paymentStatus"],
    paymentMethod: json["paymentMethod"],
    remarks: json["remarks"],
    discountType: json["discountType"],
    productList: json["productDetails"] == null ? [] : List<ProductList>.from(json["productDetails"]!.map((x) => ProductList.fromJson(x))),
    paymentDetails: json["paymentDetails"] == null ? [] : List<PaymentDetail>.from(json["paymentDetails"]!.map((x) => PaymentDetail.fromJson(x))),
    subTotal: json["subTotal"],
    additionalCharges: json["additionalCharges"] == null ? [] : List<AdditionalCharge>.from(json["additionalCharges"]!.map((x) => AdditionalCharge.fromJson(x))),
    grandTotal: json["grandTotal"],
    redeemPoints: json["redeemPoints"],
    redeemPointsValue: json["redeemPointsValue"],
    maxWalletPoints: json["MaxWalletPoints"],
    cableOperatorId: json["cableOperatorId"],
  );

  Map<String, dynamic> toJson() => {
    "UID": uid,
    "storeId": storeId,
    "status": status,
    "paymentStatus": paymentStatus,
    "paymentMethod": paymentMethod,
    "remarks": remarks,
    "discountType": discountType,
    "productDetails": productList == null ? [] : List<dynamic>.from(productList!.map((x) => x.toJson())),
    "paymentDetails": paymentDetails == null ? [] : List<dynamic>.from(paymentDetails!.map((x) => x.toJson())),
    "subTotal": subTotal,
    "additionalCharges": additionalCharges == null ? [] : List<dynamic>.from(additionalCharges!.map((x) => x.toJson())),
    "grandTotal": grandTotal,
    "redeemPoints": redeemPoints,
    "redeemPointsValue": redeemPointsValue,
    "MaxWalletPoints": maxWalletPoints,
    "cableOperatorId": cableOperatorId,
  };
}

class AdditionalCharge {
  String? name;
  int? price;

  AdditionalCharge({
    this.name,
    this.price,
  });

  factory AdditionalCharge.fromJson(Map<String, dynamic> json) => AdditionalCharge(
    name: json["name"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
  };
}

class PaymentDetail {
  String? modeOfPay;
  String? transactionId;
  String? gatewayTransactionId;
  String? gatewayStatus;
  String? gatewayName;

  PaymentDetail({
    this.modeOfPay,
    this.transactionId,
    this.gatewayTransactionId,
    this.gatewayStatus,
    this.gatewayName,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) => PaymentDetail(
    modeOfPay: json["modeOfPay"],
    transactionId: json["transactionId"],
    gatewayTransactionId: json["gatewayTransactionId"],
    gatewayStatus: json["gatewayStatus"],
    gatewayName: json["gatewayName"],
  );

  Map<String, dynamic> toJson() => {
    "modeOfPay": modeOfPay,
    "transactionId": transactionId,
    "gatewayTransactionId": gatewayTransactionId,
    "gatewayStatus": gatewayStatus,
    "gatewayName": gatewayName,
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
