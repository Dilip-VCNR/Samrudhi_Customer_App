import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/dashboard/providers/dashboard_provider.dart';
import 'package:samruddhi/utils/app_colors.dart';

import '../../../utils/routes.dart';
import '../../../utils/url_constants.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder: (BuildContext context, DashboardProvider dashboardProvider,
          Widget? child) {
        return Scaffold(
          bottomNavigationBar: prefModel.cartItems!.isNotEmpty
              ? Container(
                  width: screenSize.width,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("*Taxes and transaction fees may apply."),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.placeOrderRoute);
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
                                  text: dashboardProvider.getTotal(),
                                  // text: prefModel.cartItems!.length.toString(),
                                  // text: '₹${dashboardProvider.payable}',
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
                      )
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: screenSize.width,
                  decoration: const ShapeDecoration(
                    color: AppColors.storeBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              color: AppColors.fontColor,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Text(
                              '${dashboardProvider.storeData!.result!.storeDetails!.displayName}',
                              style: const TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.ios_share_outlined),
                              color: AppColors.fontColor,
                              onPressed: () {},
                            )
                          ],
                        ),
                        Text(
                          '${dashboardProvider.storeData!.result!.storeDetails!.storeCategoryName}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width / 1.75,
                          child: Text(
                            '${dashboardProvider.storeData!.result!.storeDetails!.addressArray![0].completeAddress} ${dashboardProvider.storeData!.result!.storeDetails!.addressArray![0].state} ${dashboardProvider.storeData!.result!.storeDetails!.addressArray![0].city} ${dashboardProvider.storeData!.result!.storeDetails!.addressArray![0].zipCode}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.fontColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                for (int i = 0;
                    i <
                        dashboardProvider
                            .storeData!.result!.productDetails!.length;
                    i++)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          dashboardProvider.storeData!.result!
                              .productDetails![i].productCategories!,
                          style: const TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: dashboardProvider.storeData!.result!
                            .productDetails![i].productList!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                width: screenSize.width,
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Container(
                                      width: screenSize.width / 3.75,
                                      height: screenSize.width / 3.75,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: dashboardProvider
                                                  .storeData!
                                                  .result!
                                                  .productDetails![i]
                                                  .productList![index]
                                                  .productImgArray!
                                                  .isEmpty
                                              ? const NetworkImage(
                                                  "https://via.placeholder.com/115x111")
                                              : NetworkImage(
                                                  '${UrlConstant.imageBaseUrl}${dashboardProvider.storeData!.result!.productDetails![i].productList![index].productImgArray![0].imagePath!}'),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dashboardProvider
                                                .storeData!
                                                .result!
                                                .productDetails![i]
                                                .productList![index]
                                                .productName!,
                                            style: const TextStyle(
                                              color: AppColors.fontColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.60,
                                            ),
                                          ),
                                          Text(
                                            dashboardProvider
                                                .storeData!
                                                .result!
                                                .productDetails![i]
                                                .productList![index]
                                                .productSubCategory!
                                                .productSubCategoryName!,
                                            style: const TextStyle(
                                              color: Color(0x8937474F),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              // decoration:
                                              //     TextDecoration.lineThrough,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '₹${dashboardProvider.storeData!.result!.productDetails![i].productList![index].sellingPrice!}',
                                                style: const TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              !dashboardProvider
                                                      .productExistInCart(
                                                          dashboardProvider
                                                              .storeData!
                                                              .result!
                                                              .productDetails![
                                                                  i]
                                                              .productList![index])
                                                  ? InkWell(
                                                      onTap: () async {
                                                        await dashboardProvider
                                                            .addUpdateProductToCart(
                                                                dashboardProvider
                                                                    .storeData!
                                                                    .result!
                                                                    .productDetails![
                                                                        i]
                                                                    .productList![index],
                                                                'add');
                                                      },
                                                      child: Container(
                                                        width:
                                                            screenSize.width /
                                                                4,
                                                        height: 40,
                                                        decoration:
                                                            ShapeDecoration(
                                                          color: AppColors
                                                              .secondaryColor,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                          ),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            'Add',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            dashboardProvider.addUpdateProductToCart(
                                                                dashboardProvider
                                                                    .storeData!
                                                                    .result!
                                                                    .productDetails![
                                                                        i]
                                                                    .productList![index],
                                                                'remove');
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            width: 40,
                                                            decoration: const BoxDecoration(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                            child: const Center(
                                                                child: Text(
                                                              "-",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                          width: 30,
                                                          child: Center(
                                                              child: Text(
                                                            dashboardProvider
                                                                .getProductCountInCart(
                                                                    dashboardProvider
                                                                        .storeData!
                                                                        .result!
                                                                        .productDetails![
                                                                            i]
                                                                        .productList![index])
                                                                .toString(),
                                                            // '${dashboardProvider.storeData!.result!.productDetails![i].productList![index].addedCartQuantity}',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            textAlign: TextAlign
                                                                .center,
                                                          )),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            dashboardProvider.addUpdateProductToCart(
                                                                dashboardProvider
                                                                    .storeData!
                                                                    .result!
                                                                    .productDetails![
                                                                        i]
                                                                    .productList![index],
                                                                'add');
                                                          },
                                                          child: Container(
                                                            height: 40,
                                                            width: 40,
                                                            decoration: const BoxDecoration(
                                                                color: AppColors
                                                                    .secondaryColor,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5))),
                                                            child: const Center(
                                                                child: Text(
                                                              "+",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
