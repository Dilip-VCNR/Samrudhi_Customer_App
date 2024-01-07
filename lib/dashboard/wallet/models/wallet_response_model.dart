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
  String? customerUuid;
  int? totalEarnedPoints;
  int? redeemPoints;
  int? totalAvailableRedeemPoints;
  List<PointsDetail>? earnedPointsDetails;
  List<PointsDetail>? redeemPointsDetails;
  int? v;
  int? totalAvailableRedeemPointsValue;

  Result({
    this.id,
    this.customerUuid,
    this.totalEarnedPoints,
    this.redeemPoints,
    this.totalAvailableRedeemPoints,
    this.earnedPointsDetails,
    this.redeemPointsDetails,
    this.v,
    this.totalAvailableRedeemPointsValue,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    customerUuid: json["customerUuid"],
    totalEarnedPoints: json["totalEarnedPoints"],
    redeemPoints: json["redeemPoints"],
    totalAvailableRedeemPoints: json["totalAvailableRedeemPoints"],
    earnedPointsDetails: json["EarnedPointsDetails"] == null ? [] : List<PointsDetail>.from(json["EarnedPointsDetails"]!.map((x) => PointsDetail.fromJson(x))),
    redeemPointsDetails: json["redeemPointsDetails"] == null ? [] : List<PointsDetail>.from(json["redeemPointsDetails"]!.map((x) => PointsDetail.fromJson(x))),
    v: json["__v"],
    totalAvailableRedeemPointsValue: json["totalAvailableRedeemPointsValue"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "customerUuid": customerUuid,
    "totalEarnedPoints": totalEarnedPoints,
    "redeemPoints": redeemPoints,
    "totalAvailableRedeemPoints": totalAvailableRedeemPoints,
    "EarnedPointsDetails": earnedPointsDetails == null ? [] : List<dynamic>.from(earnedPointsDetails!.map((x) => x.toJson())),
    "redeemPointsDetails": redeemPointsDetails == null ? [] : List<dynamic>.from(redeemPointsDetails!.map((x) => x.toJson())),
    "__v": v,
    "totalAvailableRedeemPointsValue": totalAvailableRedeemPointsValue,
  };
}

class PointsDetail {
  String? orderId;
  int? earnedpoint;
  DateTime? date;
  String? id;
  int? redeempoint;

  PointsDetail({
    this.orderId,
    this.earnedpoint,
    this.date,
    this.id,
    this.redeempoint,
  });

  factory PointsDetail.fromJson(Map<String, dynamic> json) => PointsDetail(
    orderId: json["orderId"],
    earnedpoint: json["earnedpoint"],
    date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
    id: json["_id"],
    redeempoint: json["redeempoint"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "earnedpoint": earnedpoint,
    "Date": date?.toIso8601String(),
    "_id": id,
    "redeempoint": redeempoint,
  };
}
