import 'package:flutter/src/widgets/framework.dart';
import 'package:samruddhi/dashboard/orders/model/orderRequestModel.dart';
import 'package:samruddhi/dashboard/orders/model/orderResponseModel.dart';
import 'package:samruddhi/network/api_calls.dart';

class OrderController{
  ApiCalls apiCalls = ApiCalls();
  Future<OrderReqsponseModel> createOrder(BuildContext context, OrderRequestModel orderRequest) {
    return apiCalls.createOrder(context,orderRequest);
  }

}