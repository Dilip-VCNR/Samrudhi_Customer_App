// To parse this JSON data, do
//
//     final walletResponseModel = walletResponseModelFromJson(jsonString);

import 'dart:convert';

WalletResponseModel walletResponseModelFromJson(String str) => WalletResponseModel.fromJson(json.decode(str));

String walletResponseModelToJson(WalletResponseModel data) => json.encode(data.toJson());

class WalletResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  Result? result;

  WalletResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory WalletResponseModel.fromJson(Map<String, dynamic> json) => WalletResponseModel(
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
  String? id;
  String? uid;
  int? totalEarnedPoints;
  int? redeemPoints;
  int? availablePoints;
  int? v;
  int? availablePointsValue;

  Result({
    this.id,
    this.uid,
    this.totalEarnedPoints,
    this.redeemPoints,
    this.availablePoints,
    this.v,
    this.availablePointsValue,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    uid: json["UID"],
    totalEarnedPoints: json["totalEarnedPoints"],
    redeemPoints: json["redeemPoints"],
    availablePoints: json["availablePoints"],
    v: json["__v"],
    availablePointsValue: json["availablePointsValue"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "UID": uid,
    "totalEarnedPoints": totalEarnedPoints,
    "redeemPoints": redeemPoints,
    "availablePoints": availablePoints,
    "__v": v,
    "availablePointsValue": availablePointsValue,
  };
}
