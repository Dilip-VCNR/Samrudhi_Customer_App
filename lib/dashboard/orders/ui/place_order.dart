import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/dashboard/providers/dashboard_provider.dart';
import 'package:samruddhi/utils/url_constants.dart';

import '../../../utils/app_colors.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({Key? key}) : super(key: key);

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  bool firstTimeLoading = false;
  bool delivery = true;

  int _selectedValue = 1;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Consumer(
      builder: (BuildContext context, DashboardProvider dashboardProvider,
          Widget? child) {
        dashboardProvider.reviewCartScreenContext = context;
        if (firstTimeLoading != true) {
          dashboardProvider.reviewCartResponse = null;
          dashboardProvider.reviewMyCart();
          firstTimeLoading = true;
        }
        if (dashboardProvider.reviewCartResponse != null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.scaffoldBackground,
              title: const Text(
                'My Bag',
                style: TextStyle(
                  color: AppColors.fontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // bottomNavigationBar: Container(
            //     width: screenSize.width,
            //     padding: const EdgeInsets.all(20),
            //     decoration: const BoxDecoration(
            //         color: AppColors.storeBackground,
            //         borderRadius: BorderRadius.only(
            //             topRight: Radius.circular(20),
            //             topLeft: Radius.circular(20))),
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         const Text(
            //           'Delivery Type',
            //           style: TextStyle(
            //             color: AppColors.fontColor,
            //             fontSize: 16,
            //             fontWeight: FontWeight.w500,
            //             letterSpacing: 0.60,
            //           ),
            //         ),
            //         delivery?RadioListTile(
            //           title: const Text('Delivery'), // Display the title for option 1
            //           subtitle: const Text(
            //               'Order will be delivered to selected address'), // Display a subtitle for option 1
            //           value: 1, // Assign a value of 1 to this option
            //           groupValue: _selectedValue, // Use _selectedValue to track the selected option
            //           onChanged: (value) {
            //             setState(() {
            //               _selectedValue =
            //               value!; // Update _selectedValue when option 1 is selected
            //             });
            //           },
            //         ):const SizedBox.shrink(),
            //         RadioListTile(
            //           title: const Text('Self Pickup'), // Display the title for option 1
            //           subtitle: const Text(
            //               'You can pick up your order by visiting the store'), // Display a subtitle for option 1
            //           value: 2, // Assign a value of 1 to this option
            //           groupValue: _selectedValue, // Use _selectedValue to track the selected option
            //           onChanged: (value) {
            //             setState(() {
            //               _selectedValue =
            //                   value!; // Update _selectedValue when option 1 is selected
            //             });
            //           },
            //         ),
            //         _selectedValue==1?Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             const Text(
            //               'Delivery Location',
            //               style: TextStyle(
            //                 color: AppColors.fontColor,
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.w500,
            //                 letterSpacing: 0.60,
            //               ),
            //             ),
            //             GestureDetector(
            //               onTap: () {
            //                 Navigator.pushNamed(
            //                     context, Routes.selectAddressRoute);
            //               },
            //               child: prefModel.selectedAddress != null
            //                   ? const Text(
            //                       'Change',
            //                       textAlign: TextAlign.right,
            //                       style: TextStyle(
            //                           color: AppColors.walletFont,
            //                           fontSize: 16,
            //                           fontWeight: FontWeight.w500,
            //                           letterSpacing: 0.60,
            //                           decoration: TextDecoration.underline),
            //                     )
            //                   : const Text(
            //                       'Choose',
            //                       textAlign: TextAlign.right,
            //                       style: TextStyle(
            //                           color: AppColors.walletFont,
            //                           fontSize: 16,
            //                           fontWeight: FontWeight.w500,
            //                           letterSpacing: 0.60,
            //                           decoration: TextDecoration.underline),
            //                     ),
            //             )
            //           ],
            //         ):const SizedBox.shrink(),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         _selectedValue==1?Row(
            //           children: [
            //             const CircleAvatar(
            //               backgroundColor: AppColors.primaryColor,
            //               child: Icon(
            //                 Icons.location_on_outlined,
            //                 color: Colors.white,
            //               ),
            //             ),
            //             const SizedBox(
            //               width: 20,
            //             ),
            //             prefModel.selectedAddress != null
            //                 ? SizedBox(
            //                     width: screenSize.width - 100,
            //                     child: Text(
            //                       prefModel.selectedAddress!.completeAddress!,
            //                       style: const TextStyle(
            //                         color: AppColors.fontColor,
            //                         fontSize: 14,
            //                         fontWeight: FontWeight.w400,
            //                       ),
            //                     ),
            //                   )
            //                 : const Text(
            //                     "Please select the delivery address",
            //                     style: TextStyle(
            //                       color: AppColors.fontColor,
            //                       fontSize: 14,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                   )
            //           ],
            //         ):const SizedBox.shrink(),
            //         const SizedBox(
            //           height: 20,
            //         ),
            //         InkWell(
            //           onTap: () {
            //             if (prefModel.selectedAddress == null && _selectedValue==1) {
            //               showErrorToast(context, "Please select delivery address");
            //             } else {
            //               dashboardProvider.placeOrder(_selectedValue);
            //             }
            //           },
            //           child: Container(
            //             width: double.infinity,
            //             padding: const EdgeInsets.symmetric(vertical: 13.0),
            //             decoration: const BoxDecoration(
            //               color: AppColors.secondaryColor,
            //               borderRadius: BorderRadius.all(
            //                 Radius.circular(10.0),
            //               ),
            //             ),
            //             child: const Text.rich(
            //               TextSpan(
            //                 children: [
            //                   TextSpan(
            //                     text: 'Place Order (',
            //                     style: TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   ),
            //                   TextSpan(
            //                     // text:
            //                     //     '₹${dashboardProvider.reviewCartResponse!.result!.orderGrandTotal}',
            //                     style: TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w700,
            //                     ),
            //                   ),
            //                   TextSpan(
            //                     text: ')',
            //                     style: TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 16,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               textAlign: TextAlign.center,
            //             ),
            //           ),
            //         ),
            //       ],
            //     )),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   width: screenSize.width,
                  //   padding: const EdgeInsets.all(20),
                  //   decoration: ShapeDecoration(
                  //     color: AppColors.walletBg,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8)),
                  //   ),
                  //   child: const Column(
                  //     children: [
                  //       Text(
                  //         'You have 1200 points in wallet \neligible to redeem',
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //           color: AppColors.walletFont,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //       Text(
                  //         'Redeem Now !',
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //           color: Color(0xFF1B8902),
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w500,
                  //           decoration: TextDecoration.underline,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  const Text(
                    'Payment Details',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.60,
                    ),
                  ),
                  Divider(),
                  for(int i=0;i<dashboardProvider.reviewCartResponse!.result!.calculation!.length;i++)
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          '${dashboardProvider.reviewCartResponse!.result!.calculation![i].name}',
                          style: const TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.60,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          '${dashboardProvider.reviewCartResponse!.result!.calculation![i].value}',
                          // '₹${dashboardProvider.getSubTotal()}',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.60,
                          ),
                        ),
                      )
                    ],
                  ),
                  // const Text(
                  //   'Payment Methods',
                  //   style: TextStyle(
                  //     color: AppColors.fontColor,
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.w500,
                  //     letterSpacing: 0.60,
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 100,
                  // ),
                  Divider(),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: screenSize.width,
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                    decoration: const BoxDecoration(
                      color: AppColors.creditBg,
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Text(
                      'You will save ₹${dashboardProvider.reviewCartResponse!.overAlldiscountAmount} on this order',
                      style: const TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.60,
                      ),
                    ),
                  ),
                  const Text(
                    'Products',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.60,
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dashboardProvider
                        .reviewCartResponse!.result!.productDetails!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: screenSize.width,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: screenSize.width / 6,
                              height: screenSize.width / 6,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: dashboardProvider
                                          .reviewCartResponse!
                                          .result!
                                          .productDetails![index]
                                          .productImgArray!
                                          .isEmpty
                                      ? const NetworkImage(
                                          "https://via.placeholder.com/115x111")
                                      : NetworkImage(
                                          '${UrlConstant.imageBaseUrl}${dashboardProvider.reviewCartResponse!.result!.productDetails![index].productImgArray![0].imagePath!}'),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${dashboardProvider.reviewCartResponse!.result!.productDetails![index].productName}',
                                    style: const TextStyle(
                                      color: AppColors.fontColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.60,
                                    ),
                                  ),
                                  Text(
                                    '${dashboardProvider.reviewCartResponse!.result!.productDetails![index].productSubCategory!.productSubCategoryName}',
                                    style: const TextStyle(
                                      color: Color(0x8937474F),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      // decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  Text(
                                    'Selling price : ₹${dashboardProvider.reviewCartResponse!.result!.productDetails![index].sellingPrice}',
                                    style: const TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      // decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  Text(
                                    'Discount : ${dashboardProvider.reviewCartResponse!.result!.productDetails![index].productDiscount}%',
                                    style: const TextStyle(
                                      color: AppColors.secondaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      // decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Sub total : ₹${dashboardProvider.reviewCartResponse!.result!.productDetails![index].productGrandTotal!}',
                                        style: const TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      if (dashboardProvider
                                              .reviewCartResponse!
                                              .result!
                                              .productDetails![index]
                                              .addedCartQuantity ==
                                          0)
                                        InkWell(
                                          onTap: () {
                                            dashboardProvider
                                                .addUpdateProductToCart(
                                                    prefModel.cartItems![index],
                                                    "add");
                                            dashboardProvider
                                                .reviewCartResponse = null;
                                            setState(() {
                                              firstTimeLoading = false;
                                            });
                                          },
                                          child: Container(
                                            width: screenSize.width / 4,
                                            height: 35,
                                            decoration: ShapeDecoration(
                                              color: AppColors.secondaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                              ),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Add',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      else
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                await dashboardProvider
                                                    .addUpdateProductToCart(
                                                        prefModel
                                                            .cartItems![index],
                                                        'remove');
                                                if (prefModel
                                                    .cartItems!.isEmpty) {
                                                  Navigator.pop(context);
                                                } else {
                                                  setState(() {
                                                    dashboardProvider
                                                            .reviewCartResponse =
                                                        null;
                                                    firstTimeLoading = false;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: ShapeDecoration(
                                                  color: AppColors.primaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    '-',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 20,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                '${dashboardProvider.reviewCartResponse!.result!.productDetails![index].addedCartQuantity}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: AppColors.fontColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await dashboardProvider
                                                    .addUpdateProductToCart(
                                                        prefModel.cartItems![index],
                                                        'add');
                                                dashboardProvider
                                                    .reviewCartResponse = null;
                                                setState(() {
                                                  firstTimeLoading = false;
                                                });
                                              },
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: ShapeDecoration(
                                                  color:
                                                      AppColors.secondaryColor,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    '+',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: ShapeDecoration(
                        color: AppColors.walletBg,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      width: screenSize.width,
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        'Add More Products',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.walletFont,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
              body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/loading_delivery_boy.json',
                    height: 150),
                const Text(
                  "Loading...",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ));
        }
      },
    );
  }
}
