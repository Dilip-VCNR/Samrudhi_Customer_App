import '../../../database/app_pref.dart';
import '../../../database/models/pref_model.dart';
import '../../home/model/in_store_data_model.dart';

class CartController {
  double payable = 0.0;

  Future<void> manageCartItems(
      ProductList item, String type, String storeId) async {
    PrefModel prefModel = AppPref.getPref();
    if (prefModel.cartItemsStoreId != storeId) {
      prefModel.cartPayable = 0.0;
      prefModel.cartItems = null;
      prefModel.cartItemsStoreId = null;
      payable = 0.0;
    }
    List<ProductList>? cartItems = prefModel.cartItems ?? [];
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
    prefModel.cartPayable = payable;
    prefModel.cartItems = cartItems;
    prefModel.cartItemsStoreId = storeId;
    await AppPref.setPref(prefModel);
  }
}
