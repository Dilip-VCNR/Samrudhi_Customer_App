

import '../../../database/app_pref.dart';
import '../../../database/models/pref_model.dart';
import '../../home/model/in_store_data_model.dart';

class CartController {
  List<ProductList> cartItems = [];
  double payable = 0.0;

  Future<void> manageCartItems(ProductList item, String type) async {
    PrefModel prefModel = AppPref.getPref();
    switch (type) {
      case "ADD":
        cartItems.add(item);
        break;
      case "UPDATE":
        for (var cartItem in cartItems) {
          if (cartItem.id == item.id) {
            cartItem.cartCount = item.cartCount;
          }
        }
        break;
      case "REMOVE":
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
        break;
    }

    payable = 0;
    for (var cartItem in cartItems) {
      payable += double.parse(cartItem.sellingPrice.toString()) * cartItem.cartCount!;
    }
    await AppPref.setPref(prefModel);
  }
}
