// To parse this JSON data, do
//
//     final allOrdersResponseModel = allOrdersResponseModelFromJson(jsonString);

import 'dart:convert';

import 'order_response_model.dart';

AllOrdersResponseModel allOrdersResponseModelFromJson(String str) => AllOrdersResponseModel.fromJson(json.decode(str));

String allOrdersResponseModelToJson(AllOrdersResponseModel data) => json.encode(data.toJson());

class AllOrdersResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  List<Result>? result;

  AllOrdersResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory AllOrdersResponseModel.fromJson(Map<String, dynamic> json) => AllOrdersResponseModel(
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
  List<OrderList>? orderList;

  Result({
    this.orderList,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    orderList: json["orderList"] == null ? [] : List<OrderList>.from(json["orderList"]!.map((x) => OrderList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orderList": orderList == null ? [] : List<dynamic>.from(orderList!.map((x) => x.toJson())),
  };
}
