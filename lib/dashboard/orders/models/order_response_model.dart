// To parse this JSON data, do
//
//     final orderResponseModel = orderResponseModelFromJson(jsonString);

import 'dart:convert';

OrderResponseModel orderResponseModelFromJson(String str) =>
    OrderResponseModel.fromJson(json.decode(str));

String orderResponseModelToJson(OrderResponseModel data) =>
    json.encode(data.toJson());

class OrderResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  Result? result;

  OrderResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) =>
      OrderResponseModel(
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
  Docs? docs;
  int? rewardpoint;
  String? message;

  Result({
    this.docs,
    this.rewardpoint,
    this.message,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        docs: json["docs"] == null ? null : Docs.fromJson(json["docs"]),
        rewardpoint: json["rewardpoint"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "docs": docs?.toJson(),
        "rewardpoint": rewardpoint,
        "message": message,
      };
}

class Docs {
  DeliveryAddress? deliveryAddress;
  PaymentDetailsArray? paymentDetailsArray;
  DeliveryDetailsArray? deliveryDetailsArray;
  String? id;
  String? orderNumber;
  String? orderId;
  String? orderStatus;
  String? storeUuid;
  DateTime? orderDate;
  String? orderTime;
  String? customerUuid;
  String? orderDeliveryType;
  int? orderPickupId;
  String? orderGrandTotal;
  List<OrderStatusTrackArray>? orderStatusTrackArray;
  dynamic hubUuid;
  dynamic operatorUuid;
  bool? isActive;
  List<ProductDetail>? productDetails;
  int? storeDeliverycharge;
  List<dynamic>? additionalChargesArray;
  int? v;

  Docs({
    this.deliveryAddress,
    this.paymentDetailsArray,
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
    this.orderGrandTotal,
    this.orderStatusTrackArray,
    this.hubUuid,
    this.operatorUuid,
    this.isActive,
    this.productDetails,
    this.storeDeliverycharge,
    this.additionalChargesArray,
    this.v,
  });

  factory Docs.fromJson(Map<String, dynamic> json) => Docs(
        deliveryAddress: json["deliveryAddress"] == null
            ? null
            : DeliveryAddress.fromJson(json["deliveryAddress"]),
        paymentDetailsArray: json["paymentDetailsArray"] == null
            ? null
            : PaymentDetailsArray.fromJson(json["paymentDetailsArray"]),
        deliveryDetailsArray: json["deliveryDetailsArray"] == null
            ? null
            : DeliveryDetailsArray.fromJson(json["deliveryDetailsArray"]),
        id: json["_id"],
        orderNumber: json["orderNumber"],
        orderId: json["orderId"],
        orderStatus: json["orderStatus"],
        storeUuid: json["storeUuid"],
        orderDate: json["orderDate"] == null
            ? null
            : DateTime.parse(json["orderDate"]),
        orderTime: json["orderTime"],
        customerUuid: json["customerUuid"],
        orderDeliveryType: json["orderDeliveryType"],
        orderPickupId: json["orderPickupId"],
        orderGrandTotal: json["orderGrandTotal"],
        orderStatusTrackArray: json["orderStatusTrackArray"] == null
            ? []
            : List<OrderStatusTrackArray>.from(json["orderStatusTrackArray"]!
                .map((x) => OrderStatusTrackArray.fromJson(x))),
        hubUuid: json["hubUuid"],
        operatorUuid: json["operatorUuid"],
        isActive: json["isActive"],
        productDetails: json["productDetails"] == null
            ? []
            : List<ProductDetail>.from(
                json["productDetails"]!.map((x) => ProductDetail.fromJson(x))),
        storeDeliverycharge: json["storeDeliverycharge"],
        additionalChargesArray: json["additionalChargesArray"] == null
            ? []
            : List<dynamic>.from(json["additionalChargesArray"]!.map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "deliveryAddress": deliveryAddress?.toJson(),
        "paymentDetailsArray": paymentDetailsArray?.toJson(),
        "deliveryDetailsArray": deliveryDetailsArray?.toJson(),
        "_id": id,
        "orderNumber": orderNumber,
        "orderId": orderId,
        "orderStatus": orderStatus,
        "storeUuid": storeUuid,
        "orderDate":
            "${orderDate!.year.toString().padLeft(4, '0')}-${orderDate!.month.toString().padLeft(2, '0')}-${orderDate!.day.toString().padLeft(2, '0')}",
        "orderTime": orderTime,
        "customerUuid": customerUuid,
        "orderDeliveryType": orderDeliveryType,
        "orderPickupId": orderPickupId,
        "orderGrandTotal": orderGrandTotal,
        "orderStatusTrackArray": orderStatusTrackArray == null
            ? []
            : List<dynamic>.from(orderStatusTrackArray!.map((x) => x.toJson())),
        "hubUuid": hubUuid,
        "operatorUuid": operatorUuid,
        "isActive": isActive,
        "productDetails": productDetails == null
            ? []
            : List<dynamic>.from(productDetails!.map((x) => x.toJson())),
        "storeDeliverycharge": storeDeliverycharge,
        "additionalChargesArray": additionalChargesArray == null
            ? []
            : List<dynamic>.from(additionalChargesArray!.map((x) => x)),
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

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(
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

  factory DeliveryDetailsArray.fromJson(Map<String, dynamic> json) =>
      DeliveryDetailsArray(
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

  factory OrderStatusTrackArray.fromJson(Map<String, dynamic> json) =>
      OrderStatusTrackArray(
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

class PaymentDetailsArray {
  String? modeOfPay;

  PaymentDetailsArray({
    this.modeOfPay,
  });

  factory PaymentDetailsArray.fromJson(Map<String, dynamic> json) =>
      PaymentDetailsArray(
        modeOfPay: json["modeOfPay"],
      );

  Map<String, dynamic> toJson() => {
        "modeOfPay": modeOfPay,
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
  double? productTax;
  double? productDiscount;
  double? productDiscountedValue;
  int? productQuantity;
  double? addedCartQuantity;
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
  double? productSubTotal;
  double? productGrandTotal;

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
        productCategory: json["productCategory"] == null
            ? null
            : ProductCategory.fromJson(json["productCategory"]),
        productSubCategory: json["productSubCategory"] == null
            ? null
            : ProductSubCategory.fromJson(json["productSubCategory"]),
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
        productTax: json["productTax"].toDouble(),
        productDiscount: json["productDiscount"].toDouble(),
        productDiscountedValue: json["productDiscountedValue"]?.toDouble(),
        productQuantity: json["productQuantity"],
        addedCartQuantity: json["addedCartQuantity"]?.toDouble(),
        isReturnable: json["isReturnable"],
        isPerishable: json["isPerishable"],
        productHsnCode: json["productHsnCode"],
        manufacturer: json["manufacturer"],
        productModel: json["productModel"],
        isDeleted: json["isDeleted"],
        productImgArray: json["productImgArray"] == null
            ? []
            : List<ProductImgArray>.from(json["productImgArray"]!
                .map((x) => ProductImgArray.fromJson(x))),
        v: json["__v"],
        taxableValue: json["taxableValue"],
        productTaxValue: json["productTaxValue"]?.toDouble(),
        productSubTotal: json["productSubTotal"]?.toDouble(),
        productGrandTotal: json["productGrandTotal"]?.toDouble(),
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
        "productTax": productTax!.toDouble(),
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
        "productImgArray": productImgArray == null
            ? []
            : List<dynamic>.from(productImgArray!.map((x) => x.toJson())),
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

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
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

  factory ProductImgArray.fromJson(Map<String, dynamic> json) =>
      ProductImgArray(
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

  factory ProductSubCategory.fromJson(Map<String, dynamic> json) =>
      ProductSubCategory(
        productSubCategoryId: json["productSubCategoryId"],
        productSubCategoryName: json["productSubCategoryName"],
      );

  Map<String, dynamic> toJson() => {
        "productSubCategoryId": productSubCategoryId,
        "productSubCategoryName": productSubCategoryName,
      };
}
