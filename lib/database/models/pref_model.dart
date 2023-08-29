
import 'package:samruddhi/auth/model/login_response_model.dart';


class PrefModel {
  UserData? userData;
  Address? selectedAddress;
  PrefModel({
    this.userData,
    this.selectedAddress,
  });

  factory PrefModel.fromJson(Map<String, dynamic> parsedJson) {
    return PrefModel(
      userData: parsedJson["userData"] == null ? null : UserData.fromJson(parsedJson["userData"]),
      selectedAddress: parsedJson["selectedAddress"] == null ? null : Address.fromJson(parsedJson["selectedAddress"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userData": userData?.toJson(),
      "selectedAddress": selectedAddress?.toJson(),
    };
  }
}
