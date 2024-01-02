// To parse this JSON data, do
//
//     final deleteAddressResponseModel = deleteAddressResponseModelFromJson(jsonString);

import 'dart:convert';

DeleteAddressResponseModel deleteAddressResponseModelFromJson(String str) => DeleteAddressResponseModel.fromJson(json.decode(str));

String deleteAddressResponseModelToJson(DeleteAddressResponseModel data) => json.encode(data.toJson());

class DeleteAddressResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  dynamic result;

  DeleteAddressResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory DeleteAddressResponseModel.fromJson(Map<String, dynamic> json) => DeleteAddressResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result,
  };
}
