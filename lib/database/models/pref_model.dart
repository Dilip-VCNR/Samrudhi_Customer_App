class PrefModel {
  String? uid;
  String? email;
  String? phone;
  String? name;
  String? fcmToken;
  String? authToken;

  PrefModel({
    this.uid,
    this.email,
    this.phone,
    this.name,
    this.fcmToken,
    this.authToken,
  });

  factory PrefModel.fromJson(Map<String, dynamic> parsedJson) {
    return PrefModel(
        uid: parsedJson['uid'] ?? "",
        email: parsedJson['email'] ?? "",
        phone: parsedJson['phone'] ?? "",
        name: parsedJson['name'] ?? "",
        fcmToken: parsedJson['fcmToken'] ?? "",
        authToken: parsedJson['authToken'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "phone": phone,
      "name": name,
      "fcmToken": fcmToken,
      "authToken": authToken,
    };
  }
}
