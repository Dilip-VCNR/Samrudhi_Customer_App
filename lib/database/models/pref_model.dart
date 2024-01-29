
import '../../auth/models/login_response_model.dart';
import '../../dashboard/models/store_data_model.dart';

class PrefModel {
  UserDetailsModel? userData;
  AddressArray? selectedAddress;
  List<ProductListProductDetail>? cartItems;

  PrefModel({
    this.userData,
    this.selectedAddress,
    this.cartItems,
  });

  factory PrefModel.fromJson(Map<String, dynamic> parsedJson) {
    return PrefModel(
      userData: parsedJson["userData"] == null ? null : UserDetailsModel.fromJson(parsedJson["userData"]),
      selectedAddress: parsedJson["selectedAddress"] == null ? null : AddressArray.fromJson(parsedJson["selectedAddress"]),
      cartItems: parsedJson["cartItems"] == null ? [] : List<ProductListProductDetail>.from(parsedJson["cartItems"].map((x) => ProductListProductDetail.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userData": userData?.toJson(),
      "selectedAddress": selectedAddress?.toJson(),
      "cartItems": cartItems == null ? [] : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
    };
  }
}
