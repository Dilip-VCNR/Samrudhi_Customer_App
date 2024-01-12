// To parse this JSON data, do
//
//     final orderResponseModel = orderResponseModelFromJson(jsonString);

import 'dart:convert';

OrderResponseModel orderResponseModelFromJson(String str) => OrderResponseModel.fromJson(json.decode(str));

String orderResponseModelToJson(OrderResponseModel data) => json.encode(data.toJson());

class OrderResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  OrderList? result;

  OrderResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) => OrderResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"] == null ? null : OrderList.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result?.toJson(),
  };
}

class OrderList {
  DeliveryAddress? deliveryAddress;
  DeliveryDetailsArray? deliveryDetailsArray;
  String? id;
  String? orderNumber;
  String? orderId;
  String? orderStatus;
  String? storeUuid;
  String? orderDate;
  String? orderTime;
  String? customerUuid;
  String? orderDeliveryType;
  int? orderPickupId;
  bool? isVerified;
  dynamic discountType;
  String? orderGrandTotal;
  List<OrderStatusTrackArray>? orderStatusTrackArray;
  dynamic hubUuid;
  dynamic operatorUuid;
  bool? isActive;
  List<ProductDetail>? productDetails;
  int? redeemPoints;
  int? storeDeliverycharge;
  List<dynamic>? paymentDetailsArray;
  List<dynamic>? additionalChargesArray;
  int? v;

  OrderList({
    this.deliveryAddress,
    this.deliveryDetailsArray,
    this.id,
    this.orderNumber,
    this.orderId,
    this.orderStatus,
    this.storeUuid,
    this.orderDate,
    this.orderTime,
    this.customerUuid,
    this.orderDeliveryType,
    this.orderPickupId,
    this.isVerified,
    this.discountType,
    this.orderGrandTotal,
    this.orderStatusTrackArray,
    this.hubUuid,
    this.operatorUuid,
    this.isActive,
    this.productDetails,
    this.redeemPoints,
    this.storeDeliverycharge,
    this.paymentDetailsArray,
    this.additionalChargesArray,
    this.v,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
    deliveryAddress: json["deliveryAddress"] == null ? null : DeliveryAddress.fromJson(json["deliveryAddress"]),
    deliveryDetailsArray: json["deliveryDetailsArray"] == null ? null : DeliveryDetailsArray.fromJson(json["deliveryDetailsArray"]),
    id: json["_id"],
    orderNumber: json["orderNumber"],
    orderId: json["orderId"],
    orderStatus: json["orderStatus"],
    storeUuid: json["storeUuid"],
    orderDate: json["orderDate"],
    orderTime: json["orderTime"],
    customerUuid: json["customerUuid"],
    orderDeliveryType: json["orderDeliveryType"],
    orderPickupId: json["orderPickupId"],
    isVerified: json["isVerified"],
    discountType: json["discountType"],
    orderGrandTotal: json["orderGrandTotal"],
    orderStatusTrackArray: json["orderStatusTrackArray"] == null ? [] : List<OrderStatusTrackArray>.from(json["orderStatusTrackArray"]!.map((x) => OrderStatusTrackArray.fromJson(x))),
    hubUuid: json["hubUuid"],
    operatorUuid: json["operatorUuid"],
    isActive: json["isActive"],
    productDetails: json["productDetails"] == null ? [] : List<ProductDetail>.from(json["productDetails"]!.map((x) => ProductDetail.fromJson(x))),
    redeemPoints: json["redeemPoints"],
    storeDeliverycharge: json["storeDeliverycharge"],
    paymentDetailsArray: json["paymentDetailsArray"] == null ? [] : List<dynamic>.from(json["paymentDetailsArray"]!.map((x) => x)),
    additionalChargesArray: json["additionalChargesArray"] == null ? [] : List<dynamic>.from(json["additionalChargesArray"]!.map((x) => x)),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "deliveryAddress": deliveryAddress?.toJson(),
    "deliveryDetailsArray": deliveryDetailsArray?.toJson(),
    "_id": id,
    "orderNumber": orderNumber,
    "orderId": orderId,
    "orderStatus": orderStatus,
    "storeUuid": storeUuid,
    "orderDate": orderDate,
    "orderTime": orderTime,
    "customerUuid": customerUuid,
    "orderDeliveryType": orderDeliveryType,
    "orderPickupId": orderPickupId,
    "isVerified": isVerified,
    "discountType": discountType,
    "orderGrandTotal": orderGrandTotal,
    "orderStatusTrackArray": orderStatusTrackArray == null ? [] : List<dynamic>.from(orderStatusTrackArray!.map((x) => x.toJson())),
    "hubUuid": hubUuid,
    "operatorUuid": operatorUuid,
    "isActive": isActive,
    "productDetails": productDetails == null ? [] : List<dynamic>.from(productDetails!.map((x) => x.toJson())),
    "redeemPoints": redeemPoints,
    "storeDeliverycharge": storeDeliverycharge,
    "paymentDetailsArray": paymentDetailsArray == null ? [] : List<dynamic>.from(paymentDetailsArray!.map((x) => x)),
    "additionalChargesArray": additionalChargesArray == null ? [] : List<dynamic>.from(additionalChargesArray!.map((x) => x)),
    "__v": v,
  };
}

class DeliveryAddress {
  String? addressType;
  String? completeAddress;
  String? city;
  String? state;
  double? lat;
  double? lng;
  int? zipCode;

  DeliveryAddress({
    this.addressType,
    this.completeAddress,
    this.city,
    this.state,
    this.lat,
    this.lng,
    this.zipCode,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) => DeliveryAddress(
    addressType: json["addressType"],
    completeAddress: json["completeAddress"],
    city: json["city"],
    state: json["state"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    zipCode: json["zipCode"],
  );

  Map<String, dynamic> toJson() => {
    "addressType": addressType,
    "completeAddress": completeAddress,
    "city": city,
    "state": state,
    "lat": lat,
    "lng": lng,
    "zipCode": zipCode,
  };
}

class DeliveryDetailsArray {
  bool? isDeleted;

  DeliveryDetailsArray({
    this.isDeleted,
  });

  factory DeliveryDetailsArray.fromJson(Map<String, dynamic> json) => DeliveryDetailsArray(
    isDeleted: json["isDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "isDeleted": isDeleted,
  };
}

class OrderStatusTrackArray {
  String? action;
  String? date;
  String? remarks;
  bool? isDelete;
  String? id;

  OrderStatusTrackArray({
    this.action,
    this.date,
    this.remarks,
    this.isDelete,
    this.id,
  });

  factory OrderStatusTrackArray.fromJson(Map<String, dynamic> json) => OrderStatusTrackArray(
    action: json["action"],
    date: json["date"],
    remarks: json["remarks"],
    isDelete: json["isDelete"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "action": action,
    "date": date,
    "remarks": remarks,
    "isDelete": isDelete,
    "_id": id,
  };
}

class ProductDetail {
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
  String? productTaxValue;
  double? productOffer;
  int? productQuantity;
  int? addedCartQuantity;
  int? purchaseMinQuantity;
  int? productHsnCode;
  String? manufacturer;
  String? productModel;
  bool? isDeleted;
  String? productGrandTotal;
  int? v;
  String? taxableValue;
  String? subTotal;

  ProductDetail({
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
    this.taxableValue,
    this.subTotal,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
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
    taxableValue: json["taxableValue"],
    subTotal: json["subTotal"],
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
    "taxableValue": taxableValue,
    "subTotal": subTotal,
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
