// To parse this JSON data, do
//
//     final notificationsResponseModel = notificationsResponseModelFromJson(jsonString);

import 'dart:convert';

NotificationsResponseModel notificationsResponseModelFromJson(String str) => NotificationsResponseModel.fromJson(json.decode(str));

String notificationsResponseModelToJson(NotificationsResponseModel data) => json.encode(data.toJson());

class NotificationsResponseModel {
  bool? status;
  int? statusCode;
  String? message;
  List<Result>? result;

  NotificationsResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.result,
  });

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) => NotificationsResponseModel(
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
  String? customerUuid;
  String? orderId;
  List<Notification>? notifications;
  String? notificationType;
  int? v;

  Result({
    this.id,
    this.customerUuid,
    this.orderId,
    this.notifications,
    this.notificationType,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    customerUuid: json["customerUuid"],
    orderId: json["orderId"],
    notifications: json["notifications"] == null ? [] : List<Notification>.from(json["notifications"]!.map((x) => Notification.fromJson(x))),
    notificationType: json["notificationType"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "customerUuid": customerUuid,
    "orderId": orderId,
    "notifications": notifications == null ? [] : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    "notificationType": notificationType,
    "__v": v,
  };
}

class Notification {
  String? notificationMessage;
  String? notificationDate;
  String? notificationTime;
  String? id;

  Notification({
    this.notificationMessage,
    this.notificationDate,
    this.notificationTime,
    this.id,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    notificationMessage: json["notificationMessage"],
    notificationDate: json["notificationDate"],
    notificationTime: json["notificationTime"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "notificationMessage": notificationMessage,
    "notificationDate": notificationDate,
    "notificationTime": notificationTime,
    "_id": id,
  };
}
