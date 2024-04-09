import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    Docs order = arguments['order'];
    String? message = arguments['message'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        title: const Text(
          'Order Details',
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
              message != null
                  ? Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: AppColors.creditBg),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(message.toString()))
                  : const SizedBox.shrink(),
              if (order.overallDiscount != null && order.overallDiscount! > 0)
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: AppColors.creditBg),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Text(
                      "You saved ₹${order.overallDiscount} on this order",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ))
              else
                const SizedBox.shrink(),
              Text(
                'Order : #${order.orderNumber!}',
                style: const TextStyle(
                  color: AppColors.fontColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.60,
                ),
              ),
              const Divider(),
              order.deliveryAddress != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Delivery address : ',
                          style: TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            // fontWeight: FontWeight.w500,
                            letterSpacing: 0.60,
                          ),
                        ),
                        Text(
                          '${order.deliveryAddress!.completeAddress}\n${order.deliveryAddress!.state} ${order.deliveryAddress!.city} \n${order.deliveryAddress!.zipCode}',
                          style: const TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 14,
                            // fontWeight: FontWeight.bold,
                            // fontWeight: FontWeight.w500,
                            letterSpacing: 0.60,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              order.deliveryAddress != null
                  ? const Divider()
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment Mode',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      // fontWeight: FontWeight.w500,
                      letterSpacing: 0.60,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: AppColors.secondaryColor,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      order.paymentDetailsArray!.modeOfPay!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        // fontWeight: FontWeight.w500,
                        letterSpacing: 0.60,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      order.productDetails![0].storeName!,
                      style: const TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        // fontWeight: FontWeight.w500,
                        letterSpacing: 0.60,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: AppColors.primaryColor,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      capitalizeWords(order.orderDeliveryType!),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        // fontWeight: FontWeight.w500,
                        letterSpacing: 0.60,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              order.orderDeliveryType != 'homeDelivery'
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Your Pick up Code : ",
                          style: TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            // fontWeight: FontWeight.w500,
                            letterSpacing: 0.60,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: AppColors.primaryColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(
                            order.orderPickupId!.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              // fontWeight: FontWeight.w500,
                              letterSpacing: 0.60,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              order.orderDeliveryType != 'homeDelivery'
                  ? const SizedBox(
                      height: 10,
                    )
                  : const SizedBox.shrink(),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: const Text(
                      'Items',
                      style: TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .15,
                    child: const Text(
                      'Unit Price',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .15,
                    child: const Text(
                      'Total',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),

              // const SizedBox(
              //   height: 10,
              // ),
              for (int i = 0; i < order.productDetails!.length; i++)
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .5,
                          child: Text(
                            '${i + 1}.  ${order.productDetails![i].productName} X ${order.productDetails![i].addedCartQuantity} ${order.productDetails![i].productUom} ',
                            style: const TextStyle(fontSize: 15),
                          )),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .15,
                          child: Text(
                            '₹${order.productDetails![i].sellingPrice}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontSize: 15),
                          )), SizedBox(
                          width: MediaQuery.of(context).size.width * .15,
                          child:  Text(
                            '₹${order.productDetails![i].productGrandTotal}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontSize: 15),
                          ),)
                    ],
                  ),
                ),
              // Table(
              //   border: TableBorder.all(color: Colors.black),
              //   defaultColumnWidth: const FlexColumnWidth(2), // Set a default column width
              //
              //   // columnWidths: const {
              //   //   0: FlexColumnWidth(2),
              //   //   // Adjust the width of the first column
              //   //   1: FlexColumnWidth(2),
              //   //   // Adjust the width of the second column
              //   //   2: FlexColumnWidth(2),
              //   //   // Adjust the width of the third column
              //   //   3: FlexColumnWidth(2),
              //   //   // Adjust the width of the fourth column
              //   // },
              //   children: [
              //     const TableRow(
              //       decoration: BoxDecoration(color: AppColors.secondaryColor),
              //       // Optionally add background color for header
              //       children: [
              //         TableCell(
              //           child: Text(
              //             'SL NO',
              //             style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.white),
              //             textAlign: TextAlign.center,
              //           ),
              //         ),
              //         TableCell(
              //           child: Text(
              //             'Item',
              //             style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.white),
              //             textAlign: TextAlign.center,
              //           ),
              //         ),
              //         TableCell(
              //           child: Text(
              //             'Quantity',
              //             style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.white),
              //             textAlign: TextAlign.center,
              //           ),
              //         ),
              //         TableCell(
              //           child: Text(
              //             'UOM',
              //             style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.white),
              //             textAlign: TextAlign.center,
              //           ),
              //         ),
              //         TableCell(
              //           child: Text(
              //             'Total',
              //             style: TextStyle(
              //                 fontSize: 16,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.white),
              //             textAlign: TextAlign.center,
              //           ),
              //         ),
              //       ],
              //     ),
              //     ...List<TableRow>.generate(
              //       order.productDetails!.length,
              //       (index) {
              //         return TableRow(
              //           children: [
              //             TableCell(
              //               child: Text(
              //                 '${index+1}',
              //                 style: const TextStyle(fontSize: 16),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ),
              //             TableCell(
              //               child: Text(
              //                 '${order.productDetails![index].productName}',
              //                 style: const TextStyle(fontSize: 16),
              //                 textAlign: TextAlign.start,
              //               ),
              //             ),
              //             TableCell(
              //               child: Text(
              //                 '${order.productDetails![index].addedCartQuantity}',
              //                 style: const TextStyle(fontSize: 16),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ),
              //             TableCell(
              //               child: Text(
              //                 '${order.productDetails![index].productUom}',
              //                 style: const TextStyle(fontSize: 16),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ),
              //             TableCell(
              //               child: Text(
              //                 '₹${order.productDetails![index].productGrandTotal}',
              //                 style: const TextStyle(fontSize: 16),
              //                 textAlign: TextAlign.end,
              //               ),
              //             ),
              //           ],
              //         );
              //       },
              //     ),
              //   ],
              // ),
              order.storeDeliverycharge!>0?const Divider():SizedBox.shrink(),
              order.storeDeliverycharge!>0?Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Delivery charge",
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "₹${double.parse(order.storeDeliverycharge.toString()).toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ):SizedBox.shrink(),
              order.redeemPointValue!>0?const Divider():SizedBox.shrink(),
              order.redeemPointValue!>0?Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Redeem points value",
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "₹${order.redeemPointValue}",
                    style: const TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ):SizedBox.shrink(),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total payable",
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      // fontWeight: FontWeight.w500,
                      letterSpacing: 0.60,
                    ),
                  ),
                  Text(
                    "₹${double.parse(order.orderGrandTotal!).toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      // fontWeight: FontWeight.w500,
                      letterSpacing: 0.60,
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
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
                ],
              ),
              AnotherStepper(
                stepperList: [
                  for (int i = 0; i < order.orderStatusTrackArray!.length; i++)
                    StepperData(
                        title: StepperText(
                            '${capitalizeWords(order.orderStatusTrackArray![i].action!)}'),
                        subtitle: StepperText(
                            '${order.orderStatusTrackArray![i].remarks}\n${parseDate(order.orderStatusTrackArray![i].date!)}'),
                        iconWidget: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: const Icon(Icons.check, color: Colors.white),
                        )),
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

  String capitalizeWords(String input) {
    List<String> words = input.split(RegExp(r'(?=[A-Z])'));
    for (int i = 0; i < words.length; i++) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }
    return words.join(' ');
  }
  parseDate(String dateString){
    DateFormat inputFormat = DateFormat('yyyy-MM-dd::HH:mm:ss');
    DateTime dateTime = inputFormat.parse(dateString);
    DateFormat outputFormat = DateFormat('dd-MM-yyyy hh:mm aa');
    String formattedDate = outputFormat.format(dateTime);
    return formattedDate;
  }
}
