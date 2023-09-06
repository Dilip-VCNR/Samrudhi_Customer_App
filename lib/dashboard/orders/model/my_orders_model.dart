// To parse this JSON data, do
//
//     final myOrdersModel = myOrdersModelFromJson(jsonString);

import 'dart:convert';

MyOrdersModel myOrdersModelFromJson(String str) => MyOrdersModel.fromJson(json.decode(str));

String myOrdersModelToJson(MyOrdersModel data) => json.encode(data.toJson());

class MyOrdersModel {
  bool? status;
  int? statusCode;
  String? message;
  List<Result>? result;

  MyOrdersModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) => MyOrdersModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class Result {
  String? id;
  String? orderId;
  String? status;
  String? paymentStatus;
  String? storeId;
  DateTime? date;
  String? uid;
  String? paymentMethod;
  String? remarks;
  String? discountType;
  double? grandTotal;
  List<PaymentDetail>? paymentDetails;
  String? cableOperatorId;
  List<AdditionalCharge>? additionalCharges;
  List<ProductDetail>? productDetails;
  double? subTotal;
  int? maxWalletPoints;
  int? redeemPoints;
  double? redeemPointsValue;
  List<dynamic>? orderStatusTrack;
  int? v;

  Result({
    this.id,
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
    this.orderStatusTrack,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    orderId: json["orderId"],
    status: json["status"],
    paymentStatus: json["paymentStatus"],
    storeId: json["storeId"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    uid: json["UID"],
    paymentMethod: json["paymentMethod"],
    remarks: json["remarks"],
    discountType: json["discountType"],
    grandTotal: json["grandTotal"].toDouble(),
    paymentDetails: json["paymentDetails"] == null ? [] : List<PaymentDetail>.from(json["paymentDetails"]!.map((x) => PaymentDetail.fromJson(x))),
    cableOperatorId: json["cableOperatorId"],
    additionalCharges: json["additionalCharges"] == null ? [] : List<AdditionalCharge>.from(json["additionalCharges"]!.map((x) => AdditionalCharge.fromJson(x))),
    productDetails: json["productDetails"] == null ? [] : List<ProductDetail>.from(json["productDetails"]!.map((x) => ProductDetail.fromJson(x))),
    subTotal: json["subTotal"].toDouble(),
    maxWalletPoints: json["MaxWalletPoints"],
    redeemPoints: json["redeemPoints"],
    redeemPointsValue: json["redeemPointsValue"].toDouble(),
    orderStatusTrack: json["orderStatusTrack"] == null ? [] : List<dynamic>.from(json["orderStatusTrack"]!.map((x) => x)),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
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
    "orderStatusTrack": orderStatusTrack == null ? [] : List<dynamic>.from(orderStatusTrack!.map((x) => x)),
    "__v": v,
  };
}

class AdditionalCharge {
  String? name;
  int? price;
  String? id;

  AdditionalCharge({
    this.name,
    this.price,
    this.id,
  });

  factory AdditionalCharge.fromJson(Map<String, dynamic> json) => AdditionalCharge(
    name: json["name"],
    price: json["price"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "_id": id,
  };
}

class PaymentDetail {
  String? modeOfPay;
  String? transactionId;
  String? gatewayTransactionId;
  String? gatewayStatus;
  String? gatewayName;
  String? id;

  PaymentDetail({
    this.modeOfPay,
    this.transactionId,
    this.gatewayTransactionId,
    this.gatewayStatus,
    this.gatewayName,
    this.id,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) => PaymentDetail(
    modeOfPay: json["modeOfPay"],
    transactionId: json["transactionId"],
    gatewayTransactionId: json["gatewayTransactionId"],
    gatewayStatus: json["gatewayStatus"],
    gatewayName: json["gatewayName"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "modeOfPay": modeOfPay,
    "transactionId": transactionId,
    "gatewayTransactionId": gatewayTransactionId,
    "gatewayStatus": gatewayStatus,
    "gatewayName": gatewayName,
    "_id": id,
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
  int? cartCount;

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
    this.cartCount,
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
    cartCount: json["cartCount"],
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
