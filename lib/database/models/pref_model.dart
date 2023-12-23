import 'package:samruddhi/auth/models/check_user_response_model.dart';

class PrefModel {
  UserDataModel? userdata;
  String? email;
  String? phone;
  String? name;
  String? fcmToken;
  String? authToken;

  PrefModel({
    this.userdata,
    this.email,
    this.phone,
    this.name,
    this.fcmToken,
    this.authToken,
  });

  factory PrefModel.fromJson(Map<String, dynamic> parsedJson) {
    return PrefModel(
        userdata: parsedJson['userData'],
        email: parsedJson['email'] ?? "",
        phone: parsedJson['phone'] ?? "",
        name: parsedJson['name'] ?? "",
        fcmToken: parsedJson['fcmToken'] ?? "",
        authToken: parsedJson['authToken'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": userdata,
      "email": email,
      "phone": phone,
      "name": name,
      "fcmToken": fcmToken,
      "authToken": authToken,
    };
  }
}
