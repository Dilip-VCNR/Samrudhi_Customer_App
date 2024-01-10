import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../models/order_response_model.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int activeStep = 1;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    OrderList order = arguments['order'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        title: const Text(
          'Delivery Details',
          style: TextStyle(
            color: AppColors.fontColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text('Order : #${order.orderNumber!}',
                style: TextStyle(
                  color: AppColors.fontColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  // fontWeight: FontWeight.w500,
                  letterSpacing: 0.60,
                ),),
              Text(order.productDetails![0].storeName!,
                style: TextStyle(
                  color: AppColors.fontColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  // fontWeight: FontWeight.w500,
                  letterSpacing: 0.60,
                ),),
              const Text(
                'Items',
                style: TextStyle(
                  color: AppColors.fontColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  // fontWeight: FontWeight.w500,
                  letterSpacing: 0.60,
                ),
              ),
              const SizedBox(height: 10,),
              ListView.separated(
                shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: order.productDetails!.length,
                  itemBuilder: (BuildContext context,int index){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${order.productDetails![index].productName}',style: const TextStyle(fontSize: 16),),
                    Text('X ${order.productDetails![index].addedCartQuantity}',style: const TextStyle(fontSize: 16),)
                  ],
                );
              }, separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 5,);
              },),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      // fontWeight: FontWeight.w500,
                      letterSpacing: 0.60,
                    ),),
                  Text(order.orderGrandTotal!.toStringAsFixed(2),
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      // fontWeight: FontWeight.w500,
                      letterSpacing: 0.60,
                    ),),

                ],
              ),
              const SizedBox(height: 10,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Order status',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      // fontWeight: FontWeight.w500,
                      letterSpacing: 0.60,
                    ),
                  ),
                  // Text(
                  //   '6:30 pm',
                  //   textAlign: TextAlign.right,
                  //   style: TextStyle(
                  //     color: AppColors.primaryColor,
                  //     fontSize: 17,
                  //     fontWeight: FontWeight.w500,
                  //     height: 1.88,
                  //     letterSpacing: 0.98,
                  //   ),
                  // )
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Icon(
              //       Icons.calendar_month,
              //       color: AppColors.fontColor,
              //       size: 32,
              //     ),
              //     // SizedBox(
              //     //   width: 20,
              //     // ),
              //     // Text(
              //     //   'August 27, 2023',
              //     //   style: TextStyle(
              //     //     color: AppColors.fontColor,
              //     //     fontSize: 32,
              //     //     fontWeight: FontWeight.w400,
              //     //     letterSpacing: 1.28,
              //     //   ),
              //     // )
              //   ],
              // ),
              AnotherStepper(
                stepperList: [
                  for(int i=0;i<order.orderStatusTrackArray!.length;i++)
                    StepperData(
                      title: StepperText(
                       '${order.orderStatusTrackArray![i].action}'
                      ),
                      subtitle: StepperText('${order.orderStatusTrackArray![i].remarks}\n${order.orderStatusTrackArray![i].date}'),
                      iconWidget: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: const Icon(Icons.check, color: Colors.white),
                      )),
                  // StepperData(
                  //   title: StepperText(
                  //       "Delivered",
                  //       textStyle: TextStyle(
                  //         color: order.orderStatusTrackArray![i].action!='delivered'?Colors.grey:Colors.green,
                  //       )),
                  // ),
                ],
                stepperDirection: Axis.vertical,
                iconWidth: 40,
                // Height that will be applied to all the stepper icons
                iconHeight:
                    40, // Width that will be applied to all the stepper icons
              )
            ],
          ),
        ),
      ),
    );
  }
}
