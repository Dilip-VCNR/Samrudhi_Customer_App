import 'package:flutter/cupertino.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/dashboard/orders/models/all_orders_model.dart';
import 'package:samruddhi/dashboard/orders/models/order_response_model.dart';
import 'package:samruddhi/utils/app_widgets.dart';

class OrdersProvider extends ChangeNotifier {
  ApiCalls apiCalls = ApiCalls();
  AllOrdersResponseModel? allOrdersResponse;
  BuildContext? ordersPageContext;
  List<OrderList> ongoingOrders = [];
  List<OrderList> finishedOrders = [];

  getAllOrders() async {
    ongoingOrders = [];
    finishedOrders = [];
    allOrdersResponse = null;
    allOrdersResponse = await apiCalls.getAllOrders();
    if (allOrdersResponse!.statusCode == 200) {
      for (int i = 0;
          i < allOrdersResponse!.result![0].orderList!.length;
          i++) {
        if (allOrdersResponse!.result![0].orderList![i].orderStatus !=
            'delivered') {
          ongoingOrders.add(allOrdersResponse!.result![0].orderList![i]);
        } else {
          finishedOrders.add(allOrdersResponse!.result![0].orderList![i]);
        }
      }
      notifyListeners();
    } else {
      showErrorToast(ordersPageContext!, allOrdersResponse!.message!);
    }
  }
}
