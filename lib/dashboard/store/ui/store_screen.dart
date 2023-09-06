import 'package:flutter/material.dart';
import 'package:samruddhi/dashboard/home/model/in_store_data_model.dart';
import 'package:samruddhi/dashboard/wallet/model/wallet_response_model.dart';
import 'package:samruddhi/utils/app_colors.dart';
import 'package:samruddhi/utils/app_widgets.dart';
import 'package:samruddhi/utils/url_constants.dart';

import '../../../database/app_pref.dart';
import '../../../database/models/pref_model.dart';
import '../../../utils/routes.dart';
import '../controller/cart_controller.dart';
import '../models/store_response_model.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  List<StoreProducts> products = [];

  List<String> hiddenSubcategories = [];

  CartController cartController = CartController();

  InStoreDataModel? inStoreData;
  String? searchQuery;
  bool? isLoaded;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    if (isLoaded != true) {
      final arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;
      searchQuery = arguments['searchQuery'];
      inStoreData = arguments['inStoreData'];
      isLoaded = true;
    }
    PrefModel prefModel = AppPref.getPref();
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
                    onTap: () async {
                      showLoaderDialog(context);
                      WalletResponseModel wallet = await cartController.getAvailablePoints(context);
                      if(context.mounted){
                        if(wallet.statusCode==200){
                          Navigator.pushNamed(context, Routes.placeOrderRoute,arguments: {"store_data":inStoreData!.result!.storeDetails,"wallet":wallet})
                              .then((value) {
                            setState(() {});
                            return;
                          });
                        }
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
                  )
                ],
              ),
            )
          : const SizedBox.shrink(),
      body: Column(
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
                      SizedBox(
                        width: screenSize.width / 1.5,
                        child: Text(
                          textAlign: TextAlign.center,
                          inStoreData!.result!.storeDetails!.displayName!,
                          style: const TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.search),
                        color: AppColors.fontColor,
                        onPressed: () {},
                      )
                    ],
                  ),
                  Text(
                    inStoreData!.result!.storeDetails!.storeCategory!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: screenSize.width / 1.75,
                    child: Text(
                      "${inStoreData!.result!.storeDetails!.address!.address!} ${inStoreData!.result!.storeDetails!.address!.city!} ${inStoreData!.result!.storeDetails!.address!.zipCode!}",
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
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: inStoreData!.result!.productDetails!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              inStoreData!.result!.productDetails![index]
                                  .productCategories!,
                              style: const TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (inStoreData!
                                      .result!
                                      .productDetails![index]
                                      .isSubcategoryHidden!) {
                                    // show
                                    inStoreData!.result!.productDetails![index]
                                            .isSubcategoryHidden =
                                        !inStoreData!
                                            .result!
                                            .productDetails![index]
                                            .isSubcategoryHidden!;
                                  } else {
                                    //hide
                                    inStoreData!.result!.productDetails![index]
                                            .isSubcategoryHidden =
                                        !inStoreData!
                                            .result!
                                            .productDetails![index]
                                            .isSubcategoryHidden!;
                                  }
                                });
                              },
                              child: Icon(
                                inStoreData!.result!.productDetails![index]
                                        .isSubcategoryHidden!
                                    ? Icons.keyboard_arrow_up_rounded
                                    : Icons.keyboard_arrow_down_rounded,
                                color: AppColors.fontColor,
                                size: 40,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    for (int i = 0;
                        i <
                            inStoreData!.result!.productDetails![index]
                                .productList!.length;
                        i++)
                      inStoreData!.result!.productDetails![index]
                              .isSubcategoryHidden!
                          ? Container(
                              width: screenSize.width,
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Container(
                                    width: screenSize.width / 3.75,
                                    height: screenSize.width / 3.75,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            UrlConstant.imageBaseUrl +
                                                inStoreData!
                                                    .result!
                                                    .productDetails![index]
                                                    .productList![i]
                                                    .image!),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          inStoreData!
                                              .result!
                                              .productDetails![index]
                                              .productList![i]
                                              .productName!,
                                          style: const TextStyle(
                                            color: AppColors.fontColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.60,
                                          ),
                                        ),
                                        Text(
                                          '₹${inStoreData!.result!.productDetails![index].productList![i].mrp}',
                                          style: const TextStyle(
                                            color: Color(0x8937474F),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '₹${inStoreData!.result!.productDetails![index].productList![i].sellingPrice}',
                                              style: const TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            if (!prefModel.cartItems!
                                                .any((element) {
                                              return element.productId ==
                                                  inStoreData!
                                                      .result!
                                                      .productDetails![index]
                                                      .productList![i]
                                                      .productId;
                                            }))
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    inStoreData!
                                                        .result!
                                                        .productDetails![index]
                                                        .productList![i]
                                                        .cartCount = (inStoreData!
                                                            .result!
                                                            .productDetails![
                                                                index]
                                                            .productList![i]
                                                            .cartCount! +
                                                        1);
                                                    cartController.manageCartItems(
                                                        inStoreData!
                                                            .result!
                                                            .productDetails![
                                                                index]
                                                            .productList![i],
                                                        "ADD",
                                                        inStoreData!
                                                            .result!
                                                            .storeDetails!
                                                            .storeId!);
                                                  });
                                                },
                                                child: Container(
                                                  width: screenSize.width / 4,
                                                  height: 40,
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
                                                      'Add',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                        if (inStoreData!
                                                                .result!
                                                                .productDetails![
                                                                    index]
                                                                .productList![i]
                                                                .cartCount! >
                                                            1) {
                                                          inStoreData!
                                                              .result!
                                                              .productDetails![
                                                                  index]
                                                              .productList![i]
                                                              .cartCount = inStoreData!
                                                                  .result!
                                                                  .productDetails![
                                                                      index]
                                                                  .productList![
                                                                      i]
                                                                  .cartCount! -
                                                              1;
                                                          cartController.manageCartItems(
                                                              inStoreData!
                                                                      .result!
                                                                      .productDetails![
                                                                          index]
                                                                      .productList![
                                                                  i],
                                                              "UPDATE",
                                                              inStoreData!
                                                                  .result!
                                                                  .storeDetails!
                                                                  .storeId!);
                                                        } else {
                                                          inStoreData!
                                                              .result!
                                                              .productDetails![
                                                                  index]
                                                              .productList![i]
                                                              .cartCount = inStoreData!
                                                                  .result!
                                                                  .productDetails![
                                                                      index]
                                                                  .productList![
                                                                      i]
                                                                  .cartCount! -
                                                              1;
                                                          cartController.manageCartItems(
                                                              inStoreData!
                                                                      .result!
                                                                      .productDetails![
                                                                          index]
                                                                      .productList![
                                                                  i],
                                                              "REMOVE",
                                                              inStoreData!
                                                                  .result!
                                                                  .storeDetails!
                                                                  .storeId!);
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 35,
                                                      height: 35,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: AppColors
                                                            .primaryColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
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
                                                    width: 20,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: prefModel.cartItems!
                                                            .any((element) {
                                                      return element
                                                              .productId ==
                                                          inStoreData!
                                                              .result!
                                                              .productDetails![
                                                                  index]
                                                              .productList![i]
                                                              .productId;
                                                    })
                                                        ? Text(
                                                            '${prefModel.cartItems!.firstWhere((element) => element.productId == inStoreData!.result!.productDetails![index].productList![i].productId).cartCount}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color: AppColors
                                                                  .fontColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          )
                                                        : Text(
                                                            '${inStoreData!.result!.productDetails![index].productList![i].cartCount}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color: AppColors
                                                                  .fontColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        inStoreData!
                                                            .result!
                                                            .productDetails![
                                                                index]
                                                            .productList![i]
                                                            .cartCount = inStoreData!
                                                                .result!
                                                                .productDetails![
                                                                    index]
                                                                .productList![i]
                                                                .cartCount! +
                                                            1;
                                                        cartController.manageCartItems(
                                                            inStoreData!
                                                                    .result!
                                                                    .productDetails![
                                                                        index]
                                                                    .productList![
                                                                i],
                                                            "UPDATE",
                                                            inStoreData!
                                                                .result!
                                                                .storeDetails!
                                                                .storeId!);
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 35,
                                                      height: 35,
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: AppColors
                                                            .secondaryColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(7),
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
                            )
                          : Container(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
