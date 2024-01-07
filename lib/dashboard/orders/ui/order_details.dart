import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../models/all_orders_model.dart';

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
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Delivered on',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.60,
                    ),
                  ),
                  Text(
                    '6:30 pm',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      height: 1.88,
                      letterSpacing: 0.98,
                    ),
                  )
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: AppColors.fontColor,
                    size: 32,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'August 27, 2023',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.28,
                    ),
                  )
                ],
              ),
              AnotherStepper(
                stepperList: [
                  StepperData(
                      title: StepperText(
                        "Order Placed",
                      ),
                      subtitle: StepperText("Your order has been placed"),
                      iconWidget: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: const Icon(Icons.check, color: Colors.white),
                      )),
                  StepperData(
                      title: StepperText("Packing"),
                      subtitle: StepperText("Your order is being Packed"),
                      iconWidget: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: const Icon(Icons.check, color: Colors.white),
                      )
                  ),
                  StepperData(
                      title: StepperText(
                          "Delivery hub allocated a delivery agent"),
                      subtitle: StepperText(
                          "Our delivery executive is on the way to deliver your item"),
                      iconWidget: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: const Icon(Icons.check, color: Colors.white),
                      )),
                  StepperData(
                    title: StepperText("Delivered",
                        textStyle: const TextStyle(
                          color: Colors.grey,
                        )),
                  ),
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
