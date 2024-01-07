import 'package:flutter/cupertino.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/dashboard/orders/models/all_orders_model.dart';
import 'package:samruddhi/utils/app_widgets.dart';

class OrdersProvider extends ChangeNotifier{
  ApiCalls apiCalls = ApiCalls();
  AllOrdersResponseModel? allOrdersResponse;
  BuildContext? ordersPageContext;
  getAllOrders() async {
    allOrdersResponse = null;
    allOrdersResponse = await apiCalls.getAllOrders();
    if(allOrdersResponse!.statusCode==200){
      notifyListeners();
    }else{
      showErrorToast(ordersPageContext!, allOrdersResponse!.message!);
    }
  }
}