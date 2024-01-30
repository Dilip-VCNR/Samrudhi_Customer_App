// To parse this JSON data, do
//
//     final deliverableAddressModel = deliverableAddressModelFromJson(jsonString);

import 'dart:convert';

DeliverableAddressModel deliverableAddressModelFromJson(String str) => DeliverableAddressModel.fromJson(json.decode(str));

String deliverableAddressModelToJson(DeliverableAddressModel data) => json.encode(data.toJson());

class DeliverableAddressModel {
  bool? status;
  int? statusCode;
  String? message;
  List<String>? result;

  DeliverableAddressModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory DeliverableAddressModel.fromJson(Map<String, dynamic> json) => DeliverableAddressModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"] == null ? [] : List<String>.from(json["result"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x)),
  };
}
