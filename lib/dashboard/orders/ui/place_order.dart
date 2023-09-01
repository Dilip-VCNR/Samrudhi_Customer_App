import 'package:flutter/material.dart';
import 'package:samruddhi/dashboard/store/controller/cart_controller.dart';
import 'package:samruddhi/utils/url_constants.dart';

import '../../../auth/model/login_response_model.dart';
import '../../../database/app_pref.dart';
import '../../../database/models/pref_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/routes.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({Key? key}) : super(key: key);

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  CartController cartController = CartController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    PrefModel prefModel = AppPref.getPref();

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
      bottomNavigationBar: Container(
          width: screenSize.width,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: AppColors.storeBackground,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Delivery Location',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.60,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.selectAddressRoute,
                          arguments: {
                            'callBack': onAddressChanged,
                            "from": "orders"
                          });
                    },
                    child: const Text(
                      'Change',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: AppColors.walletFont,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.60,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: screenSize.width - 100,
                    child: Text(
                      prefModel.selectedAddress != null
                          ? prefModel.selectedAddress!.address!
                          : "Click on change to select delivery address",
                      style: const TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 13.0),
                  decoration: const BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Place Order (',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: '₹${prefModel.cartPayable}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const TextSpan(
                          text: ')',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: screenSize.width,
              padding: const EdgeInsets.all(20),
              decoration: ShapeDecoration(
                color: AppColors.walletBg,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Column(
                children: [
                  Text(
                    'You have 1200 points in wallet \neligible to redeem',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.walletFont,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Redeem Now !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1B8902),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: TextStyle(
                    color: AppColors.fontColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.60,
                  ),
                ),
                Text(
                  '₹189',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: AppColors.fontColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.60,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery Charge',
                  style: TextStyle(
                    color: AppColors.fontColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.60,
                  ),
                ),
                Text(
                  '₹50',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: AppColors.fontColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.60,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    color: AppColors.fontColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.60,
                  ),
                ),
                Text(
                  '₹230',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: AppColors.fontColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.60,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Payment Methods',
              style: TextStyle(
                color: AppColors.fontColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.60,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            const Text(
              'Products',
              style: TextStyle(
                color: AppColors.fontColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.60,
              ),
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: prefModel.cartItems!.length,
              itemBuilder: (context, index) {
                return Container(
                  width: screenSize.width,
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        width: screenSize.width / 3.75,
                        height: screenSize.width / 3.75,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(UrlConstant.imageBaseUrl +
                                prefModel.cartItems![index].image!),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              prefModel.cartItems![index].productName!,
                              style: const TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.60,
                              ),
                            ),
                            Text(
                              '₹${prefModel.cartItems![index].mrp}',
                              style: const TextStyle(
                                color: Color(0x8937474F),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '₹${prefModel.cartItems![index].sellingPrice}',
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (!prefModel.cartItems!.any((element) {
                                  return element.productId ==
                                      prefModel.cartItems![index].productId;
                                }))
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        prefModel.cartItems![index].cartCount =
                                            (prefModel.cartItems![index]
                                                    .cartCount! +
                                                1);
                                        cartController.manageCartItems(
                                            prefModel.cartItems![index],
                                            "ADD",
                                            prefModel
                                                .cartItems![index].storeId!);
                                      });
                                    },
                                    child: Container(
                                      width: screenSize.width / 4,
                                      height: 40,
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
                                        onTap: () {
                                          setState(() {
                                            if (prefModel.cartItems![index]
                                                    .cartCount! >
                                                1) {
                                              prefModel.cartItems![index]
                                                  .cartCount = prefModel
                                                      .cartItems![index]
                                                      .cartCount! -
                                                  1;
                                              cartController.manageCartItems(
                                                  prefModel.cartItems![index],
                                                  "UPDATE",
                                                  prefModel.cartItems![index]
                                                      .storeId!);
                                            } else {
                                              prefModel.cartItems![index]
                                                  .cartCount = prefModel
                                                      .cartItems![index]
                                                      .cartCount! -
                                                  1;
                                              cartController.manageCartItems(
                                                  prefModel.cartItems![index],
                                                  "REMOVE",
                                                  prefModel.cartItems![index]
                                                      .storeId!);
                                            }
                                          });
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 35,
                                          decoration: ShapeDecoration(
                                            color: AppColors.primaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              '-',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 20,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: prefModel.cartItems!
                                                .any((element) {
                                          return element.productId ==
                                              prefModel
                                                  .cartItems![index].productId;
                                        })
                                            ? Text(
                                                '${prefModel.cartItems!.firstWhere((element) => element.productId == prefModel.cartItems![index].productId).cartCount}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: AppColors.fontColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )
                                            : Text(
                                                '${prefModel.cartItems![index].cartCount}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: AppColors.fontColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            prefModel.cartItems![index]
                                                .cartCount = prefModel
                                                    .cartItems![index]
                                                    .cartCount! +
                                                1;
                                            cartController.manageCartItems(
                                                prefModel.cartItems![index],
                                                "UPDATE",
                                                prefModel.cartItems![index]
                                                    .storeId!);
                                          });
                                        },
                                        child: Container(
                                          width: 35,
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
                                              '+',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
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
  }

  Future<void> onAddressChanged(Address? address) async {
    PrefModel prefModel = AppPref.getPref();
    prefModel.selectedAddress = address;
    await AppPref.setPref(prefModel);
    setState(() {});
  }
}
