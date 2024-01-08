// To parse this JSON data, do
//
//     final searchResponseModel = searchResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:samruddhi/dashboard/models/home_data_model.dart';

SearchResponseModel searchResponseModelFromJson(String str) => SearchResponseModel.fromJson(json.decode(str));

String searchResponseModelToJson(SearchResponseModel data) => json.encode(data.toJson());

class SearchResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  List<MyStore>? result;

  SearchResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) => SearchResponseModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    result: json["result"] == null ? [] : List<MyStore>.from(json["result"]!.map((x) => MyStore.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}


