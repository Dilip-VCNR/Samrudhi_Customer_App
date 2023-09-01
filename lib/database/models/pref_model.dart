import 'package:samruddhi/auth/model/login_response_model.dart';

import '../../dashboard/home/model/in_store_data_model.dart';

class PrefModel {
  UserData? userData;
  Address? selectedAddress;
  List<ProductList>? cartItems;
  double? cartPayable;
  String? cartItemsStoreId;

  PrefModel({
    this.userData,
    this.selectedAddress,
    this.cartItems,
    this.cartPayable,
    this.cartItemsStoreId,
  });

  factory PrefModel.fromJson(Map<String, dynamic> parsedJson) {
    return PrefModel(
      userData: parsedJson["userData"] == null
          ? null
          : UserData.fromJson(parsedJson["userData"]),
      selectedAddress: parsedJson["selectedAddress"] == null
          ? null
          : Address.fromJson(parsedJson["selectedAddress"]),
      cartItems: parsedJson["cartItems"] == null
          ? []
          : List<ProductList>.from(
              parsedJson["cartItems"].map((x) => ProductList.fromJson(x))),
      cartPayable: parsedJson["cartPayable"],
      cartItemsStoreId: parsedJson["cartItemsStoreId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userData": userData?.toJson(),
      "selectedAddress": selectedAddress?.toJson(),
      "cartItems": cartItems == null
          ? []
          : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
      "cartPayable": cartPayable,
      "cartItemsStoreId": cartItemsStoreId,
    };
  }
}
