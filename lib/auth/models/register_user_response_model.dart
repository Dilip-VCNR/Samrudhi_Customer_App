// To parse this JSON data, do
//
//     final registerUserResponseModel = registerUserResponseModelFromJson(jsonString);

import 'dart:convert';

import 'check_user_response_model.dart';

RegisterUserResponseModel registerUserResponseModelFromJson(String str) => RegisterUserResponseModel.fromJson(json.decode(str));

String registerUserResponseModelToJson(RegisterUserResponseModel data) => json.encode(data.toJson());

class RegisterUserResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  UserDataModel? result;

  RegisterUserResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory RegisterUserResponseModel.fromJson(Map<String, dynamic> json) => RegisterUserResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"] == null ? null : UserDataModel.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result?.toJson(),
  };
}