import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/dashboard/providers/dashboard_provider.dart';
import 'package:samruddhi/utils/url_constants.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_widgets.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  bool firstTimeLoading = false;
  bool delivery = true;
  int _selectedValue = 1;

  @override
  void initState() {
    super.initState();
    if (prefModel.cartItems!.isNotEmpty) {
      if (prefModel.cartStore != null &&
          prefModel.cartStore!.isHomeDelivery == true) {
        _selectedValue = 1;
      } else {
        _selectedValue = 2;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Consumer(
      builder: (BuildContext context, DashboardProvider dashboardProvider,
          Widget? child) {
        dashboardProvider.reviewCartScreenContext = context;
        if (firstTimeLoading != true && prefModel.cartItems!.isNotEmpty) {
          dashboardProvider.reviewCartResponse = null;
          dashboardProvider.reviewMyCart(_selectedValue);
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
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Store Details',
                      style: TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${prefModel.cartStore!.storeName}',
                      style: const TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${prefModel.cartStore!.addressArray!.completeAddress}\n${prefModel.cartStore!.addressArray!.state} ${prefModel.cartStore!.addressArray!.city} ${prefModel.cartStore!.addressArray!.zipCode}',
                      style: const TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 16,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    const Text(
                      'Payment Details',
                      style: TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    for (int i = 0;
                        i <
                            dashboardProvider.reviewCartResponse!.result!
                                .calculation!.length;
                        i++)
                      dashboardProvider.reviewCartResponse!.result!
                                  .calculation![i].name !=
                              'redeemPoints' && dashboardProvider.reviewCartResponse!.result!
                          .calculation![i].name !='Order GrandTotal' && double.parse(dashboardProvider.reviewCartResponse!.result!.calculation![i].value!)>0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    dashboardProvider.capitalizeWords(
                                        dashboardProvider.reviewCartResponse!
                                            .result!.calculation![i].name!),
                                    style: const TextStyle(
                                      color: AppColors.fontColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    '₹${dashboardProvider.reviewCartResponse!.result!.calculation![i].value}',
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: AppColors.fontColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ],
                            )
                          : const SizedBox.shrink(),
                    const Divider(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            'Total Payable',
                            style: TextStyle(
                              color: AppColors.fontColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            '₹${dashboardProvider.reviewCartResponse!.result!.calculation?.firstWhere((calculation) {
                              return calculation.name == 'Order GrandTotal';
                            }).value}',
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: AppColors.fontColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
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
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 100,
                    // ),
                    const Divider(),
                    if (dashboardProvider.walletData!.result!
                                .totalAvailableRedeemPoints! >
                            0 &&
                        dashboardProvider
                            .reviewCartResponse!.result!.calculation!
                            .every((element) =>
                                element.name != 'redeemPointValue'))
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: screenSize.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        decoration: const BoxDecoration(
                            color: AppColors.debitBg,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'You have ${dashboardProvider.walletData!.result!.totalAvailableRedeemPoints} Points worth ₹${dashboardProvider.walletData!.result!.totalAvailableRedeemPointsValue} You can apply to get discount on this order',
                              style: const TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () async {
                                bool? confirmed = await showWarningDialog(context,
                                    "Are you sure to apply ${dashboardProvider.walletData!.result!.totalAvailableRedeemPoints} Points worth ₹${dashboardProvider.walletData!.result!.totalAvailableRedeemPointsValue}?");
                                if (confirmed!) {
                                  dashboardProvider.applyWalletPoints();
                                  return;
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: AppColors.secondaryColor,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: const Center(
                                  child: Text(
                                    "Redeem",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: screenSize.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      decoration: const BoxDecoration(
                          color: AppColors.creditBg,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        'You will save ₹${dashboardProvider.reviewCartResponse!.overAlldiscountAmount!.toStringAsFixed(2)} on this order',
                        style: const TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      'Products',
                      style: TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
                                  color: Colors.grey.shade400,
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
                                      ),
                                    ),
                                    Text(
                                      '${dashboardProvider.reviewCartResponse!.result!.productDetails![index].productSubCategory!.productSubCategoryName}',
                                      style: const TextStyle(
                                        color: Color(0x8937474F),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        // decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    dashboardProvider.reviewCartResponse!.result!.productDetails![index].productDiscount!>0?Text(
                                      'Price : ₹${dashboardProvider.reviewCartResponse!.result!.productDetails![index].sellingPrice}/${dashboardProvider.reviewCartResponse!.result!.productDetails![index].productUom}',
                                      style: TextStyle(
                                        color: AppColors.fontColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        decoration: dashboardProvider.reviewCartResponse!.result!.productDetails![index].productDiscount! > 0?TextDecoration.lineThrough:TextDecoration.none,
                                      ),
                                    ):SizedBox.shrink(),
                                    dashboardProvider.reviewCartResponse!.result!.productDetails![index].productDiscount!>0?Text(
                                      'Discount : ${dashboardProvider.reviewCartResponse!.result!.productDetails![index].productDiscount}%',
                                      style: const TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        // decoration: TextDecoration.lineThrough,
                                      ),
                                    ):SizedBox.shrink(),
                                    Text(
                                      dashboardProvider.reviewCartResponse!.result!.productDetails![index].productDiscount!>0?
                                      'Offer price : ₹${dashboardProvider.reviewCartResponse!.result!.productDetails![index].sellingPrice}':
                                      'Price : ₹${dashboardProvider.reviewCartResponse!.result!.productDetails![index].sellingPrice}',
                                      style: const TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        // decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    Text(
                                      'UOM : ${dashboardProvider.reviewCartResponse!.result!.productDetails![index].productUom}',
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
                                        SizedBox(
                                          width: screenSize.width / 3,
                                          child: Text(
                                            'Total : ₹${dashboardProvider.reviewCartResponse!.result!.productDetails![index].productGrandTotal!}',
                                            style: const TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        if (dashboardProvider
                                                .reviewCartResponse!
                                                .result!
                                                .productDetails![index]
                                                .addedCartQuantity ==
                                            0)
                                          InkWell(
                                            onTap: () async {
                                              dashboardProvider
                                                  .addUpdateProductToCart(
                                                      prefModel
                                                          .cartItems![index],
                                                      "add",
                                                      context);
                                              // dashboardProvider.reviewCartResponse = null;
                                              showLoaderDialog(context);
                                              await dashboardProvider
                                                  .reviewMyCart(_selectedValue);
                                              Navigator.pop(context);
                                              // setState(() {
                                              //   // firstTimeLoading = false;
                                              // });
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
                                                          prefModel.cartItems![
                                                              index],
                                                          'remove',
                                                          context);
                                                  if (prefModel
                                                      .cartItems!.isEmpty) {
                                                    if (context.mounted) {
                                                      Navigator.pop(context);
                                                    }
                                                  } else {
                                                    // dashboardProvider.reviewCartResponse = null;
                                                    showLoaderDialog(context);
                                                    await dashboardProvider
                                                        .reviewMyCart(
                                                            _selectedValue);
                                                    Navigator.pop(context);
                                                    // setState(() {
                                                    //
                                                    //   // firstTimeLoading =
                                                    //   //     false;
                                                    // });
                                                  }
                                                },
                                                child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: ShapeDecoration(
                                                    color:
                                                        AppColors.primaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      '-',
                                                      textAlign:
                                                          TextAlign.center,
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
                                                width: 30,
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
                                                          prefModel.cartItems![
                                                              index],
                                                          'add',
                                                          context);
                                                  // dashboardProvider.reviewCartResponse = null;
                                                  showLoaderDialog(context);
                                                  await dashboardProvider
                                                      .reviewMyCart(
                                                          _selectedValue);
                                                  Navigator.pop(context);
                                                  // setState(() {
                                                  //   // firstTimeLoading =
                                                  //   //     false;
                                                  // });
                                                },
                                                child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: ShapeDecoration(
                                                    color: AppColors
                                                        .secondaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      '+',
                                                      textAlign:
                                                          TextAlign.center,
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
                      height: 10,
                    ),
                    const Text(
                      "Delivery type",
                      style: TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    prefModel.cartStore!.isHomeDelivery == true
                        ? RadioListTile(
                            title: const Text('Delivery'),
                            subtitle: const Text(
                                'Order will be delivered to selected address'),
                            value: 1,
                            groupValue: _selectedValue,
                            onChanged: (value) {
                              showLoaderDialog(context);
                              _selectedValue = value!;
                              dashboardProvider.reviewMyCart(_selectedValue);
                              Navigator.pop(context);
                            },
                          )
                        : const SizedBox.shrink(),
                    RadioListTile(
                      title: const Text('Self Pickup'),
                      subtitle: const Text(
                          'You can pick up your order by visiting the store'),
                      value: 2,
                      groupValue: _selectedValue,
                      onChanged: (value) {
                        showLoaderDialog(context);
                        _selectedValue = value!;
                        dashboardProvider.reviewMyCart(_selectedValue);
                        Navigator.pop(context);
                      },
                    ),
                    _selectedValue == 1
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Delivery address",
                                    style: TextStyle(
                                      color: AppColors.fontColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await dashboardProvider
                                          .getDeliverableAddress();
                                    },
                                    child: const Text(
                                      "Change",
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              dashboardProvider.deliveryAddress != null
                                  ? SizedBox(
                                      width: screenSize.width - 100,
                                      child: Text(
                                        '${dashboardProvider.deliveryAddress!.addressType!} - ${dashboardProvider.deliveryAddress!.completeAddress!}',
                                        style: const TextStyle(
                                          color: AppColors.fontColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      "Please select the delivery address",
                                      style: TextStyle(
                                        color: AppColors.fontColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        if (dashboardProvider.deliveryAddress == null &&
                            _selectedValue == 1) {
                          showErrorToast(
                              context, "Please select delivery address");
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm order?"),
                                  content: const Text(
                                      "Confirm placing the order ? "),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("No")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          dashboardProvider
                                              .placeOrder(_selectedValue,dashboardProvider.reviewCartResponse);
                                        },
                                        child: const Text("Yes"))
                                  ],
                                );
                              });
                        }
                      },
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
                                text:
                                    '₹${dashboardProvider.reviewCartResponse!.result!.calculation?.firstWhere((calculation) {
                                  return calculation.name == 'Order GrandTotal';
                                }).value}',
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
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ));
        } else {
          if (prefModel.cartItems!.isEmpty) {
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
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Cart is empty !",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
                        width: screenSize.width/2,
                        padding: const EdgeInsets.all(20),
                        child: const Text(
                          'Browse Products',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.walletFont,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
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
