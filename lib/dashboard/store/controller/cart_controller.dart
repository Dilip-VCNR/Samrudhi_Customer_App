import 'dart:developer';

import 'package:samruddhi/dashboard/store/models/store_response_model.dart';

class CartController {
  List<StoreProducts> cartItems = [];
  double payable = 0.0;

  void manageCartItems(StoreProducts item, String type) {
    log(item.toString());
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
      payable +=
          double.parse(cartItem.sellingPrice.toString()) * cartItem.cartCount!;
    }
  }
}
