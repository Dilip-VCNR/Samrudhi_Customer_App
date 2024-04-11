import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_widgets.dart';
import '../../../utils/url_constants.dart';
import '../../models/store_data_model.dart';
import '../../providers/dashboard_provider.dart';

class StoreSearch extends StatefulWidget {
  const StoreSearch({Key? key}) : super(key: key);

  @override
  State<StoreSearch> createState() => _StoreSearchState();
}

class _StoreSearchState extends State<StoreSearch> {
  List<ProductList> filteredProducts = [];
  TextEditingController directQtyController = TextEditingController();
  final qtyFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    return Consumer(builder: (BuildContext context,
        DashboardProvider dashboardProvider, Widget? child) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Search for products"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextField(
                    onChanged: (String val) {
                      filteredProducts = [];
                      setState(() {
                        filteredProducts = dashboardProvider
                            .storeData!.result!.productDetails!
                            .expand((detail) => detail.productList!)
                            .where((product) =>
                            product
                                .productDetail!.productName!
                                .toLowerCase()
                                .contains(val.toLowerCase()))
                            .toList();
                      });
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search products',
                      counterText: "",
                      isCollapsed: true,
                      filled: true,
                      fillColor: AppColors.inputFieldColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                filteredProducts.isNotEmpty
                    ? ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider());
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showProductDetailsModal(
                            filteredProducts[index], context, screenSize);
                      },
                      child: Container(
                        width: screenSize.width,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: screenSize.width * .25,
                              height: screenSize.width * .25,
                              decoration: ShapeDecoration(
                                color: Colors.grey.shade400,
                                image: DecorationImage(
                                  image: filteredProducts[index]
                                      .productDetail!
                                      .productImgArray!
                                      .isEmpty
                                      ? const NetworkImage(
                                      "https://via.placeholder.com/115x111")
                                      : NetworkImage(
                                      '${UrlConstant
                                          .imageBaseUrl}${filteredProducts[index]
                                          .productDetail!.productImgArray![0]
                                          .imagePath!}'),
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
                            SizedBox(
                              width: screenSize.width * .6,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredProducts[index]
                                        .productDetail!
                                        .productName!,
                                    style: const TextStyle(
                                      color: AppColors.fontColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.60,
                                    ),
                                  ),
                                  Text(
                                    filteredProducts[index]
                                        .productDetail!
                                        .productSubCategory!
                                        .productSubCategoryName!,
                                    style: const TextStyle(
                                      color: Color(0x8937474F),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "UOM : ${filteredProducts[index]
                                        .productDetail!.productUom!}",
                                    style: const TextStyle(
                                      color: Color(0x8937474F),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      // decoration:
                                      //     TextDecoration.lineThrough,
                                    ),
                                  ),
                                  filteredProducts[index]
                                      .productDetail!
                                      .productDiscount! >
                                      0
                                      ? Text(
                                    '₹${filteredProducts[index].productDetail!
                                        .sellingPrice!}/${filteredProducts[index]
                                        .productDetail!.productUom!}',
                                    style: const TextStyle(
                                        color:
                                        AppColors.primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration
                                            .lineThrough,
                                        decorationColor: AppColors
                                            .secondaryColor),
                                  )
                                      : const SizedBox.shrink(),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SizedBox(
                                        width: screenSize.width / 3,
                                        child: Text(
                                          '₹${filteredProducts[index]
                                              .productDetail!
                                              .productDiscountedValue!}/${filteredProducts[index]
                                              .productDetail!.productUom!}',
                                          style: const TextStyle(
                                            color: AppColors.walletFont,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      !dashboardProvider
                                          .productExistInCart(
                                          filteredProducts[index])
                                          ? InkWell(
                                        onTap: () async {
                                          await dashboardProvider
                                              .addUpdateProductToCart(
                                              filteredProducts[
                                              index]
                                                  .productDetail!,
                                              'add',
                                              context,
                                              null);
                                        },
                                        child: Container(
                                          width:
                                          screenSize.width / 4,
                                          height: 35,
                                          decoration:
                                          ShapeDecoration(
                                            color: filteredProducts[
                                            index]
                                                .productDetail!
                                                .productQuantity! >
                                                0
                                                ? AppColors
                                                .secondaryColor
                                                : Colors.grey,
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(7),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              filteredProducts[
                                              index]
                                                  .productDetail!
                                                  .productQuantity! >
                                                  0
                                                  ? 'Add'
                                                  : 'Out Of Stock',
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
                                          : Row(
                                        children: [
                                          GestureDetector(
                                            onLongPress: () {
                                              showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    AlertDialog(
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                      backgroundColor:
                                                      Colors.white,
                                                      content: Column(
                                                        mainAxisSize:
                                                        MainAxisSize
                                                            .min,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "Enter Quantity",
                                                            textAlign:
                                                            TextAlign
                                                                .start,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Form(
                                                            key: qtyFormKey,
                                                            child: TextFormField(
                                                              controller:
                                                              directQtyController,
                                                              autovalidateMode:
                                                              AutovalidateMode
                                                                  .onUserInteraction,
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .trim()
                                                                    .isEmpty) {
                                                                  return 'Please enter valid quantity';
                                                                }
                                                                if (double
                                                                    .parse(
                                                                    value) >
                                                                    filteredProducts[index]
                                                                        .productDetail!
                                                                        .productQuantity!) {
                                                                  return 'Entered quantity is out of range, please reduce it and try again !';
                                                                }
                                                                return null;
                                                              },
                                                              keyboardType:
                                                              TextInputType
                                                                  .number,
                                                              decoration:
                                                              InputDecoration(
                                                                errorMaxLines:
                                                                3,
                                                                hintText:
                                                                'Enter quantity',
                                                                counterText:
                                                                "",
                                                                isCollapsed:
                                                                true,
                                                                focusedBorder:
                                                                OutlineInputBorder(
                                                                  borderSide: const BorderSide(
                                                                      color:
                                                                      AppColors
                                                                          .secondaryColor,
                                                                      width: 2),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                border:
                                                                OutlineInputBorder(
                                                                  borderSide: const BorderSide(
                                                                      color:
                                                                      Colors
                                                                          .black,
                                                                      width: 2),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                contentPadding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                    15,
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed:
                                                                () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "Close")),
                                                        TextButton(
                                                            onPressed:
                                                                () {
                                                              if (qtyFormKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                dashboardProvider
                                                                    .addUpdateProductToCart(
                                                                    filteredProducts[index]
                                                                        .productDetail!,
                                                                    'add',
                                                                    context,
                                                                    double
                                                                        .parse(
                                                                        directQtyController
                                                                            .text));
                                                                Navigator.pop(
                                                                    context);
                                                                directQtyController
                                                                    .clear();
                                                              }
                                                            },
                                                            child: const Text(
                                                                "Confirm"))
                                                      ],
                                                    ),
                                              );
                                            },
                                            onTap: () {
                                              dashboardProvider
                                                  .addUpdateProductToCart(
                                                  filteredProducts[
                                                  index]
                                                      .productDetail!,
                                                  'remove',
                                                  context,
                                                  null);
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
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
                                                    textAlign: TextAlign
                                                        .center,
                                                  )),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            width: 35,
                                            child: Center(
                                                child: Text(
                                                  dashboardProvider
                                                      .getProductCountInCart(
                                                      filteredProducts[
                                                      index])
                                                      .toString(),
                                                  // '${dashboardProvider.storeData!.result!.productDetails![i].productList![index].addedCartQuantity}',
                                                  style: const TextStyle(
                                                      color:
                                                      Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold),
                                                  textAlign:
                                                  TextAlign.center,
                                                )),
                                          ),
                                          GestureDetector(
                                            onLongPress: () {
                                              showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    AlertDialog(
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                      backgroundColor:
                                                      Colors.white,
                                                      content: Column(
                                                        mainAxisSize:
                                                        MainAxisSize
                                                            .min,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            "Enter Quantity",
                                                            textAlign:
                                                            TextAlign
                                                                .start,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Form(
                                                            key: qtyFormKey,
                                                            child: TextFormField(
                                                              controller:
                                                              directQtyController,
                                                              autovalidateMode:
                                                              AutovalidateMode
                                                                  .onUserInteraction,
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .trim()
                                                                    .isEmpty) {
                                                                  return 'Please enter valid quantity';
                                                                }
                                                                if (double
                                                                    .parse(
                                                                    value) >
                                                                    filteredProducts[index]
                                                                        .productDetail!
                                                                        .productQuantity!) {
                                                                  return 'Entered quantity is out of range, please reduce it and try again !';
                                                                }
                                                                return null;
                                                              },
                                                              keyboardType:
                                                              TextInputType
                                                                  .number,
                                                              decoration:
                                                              InputDecoration(
                                                                errorMaxLines:
                                                                3,
                                                                hintText:
                                                                'Enter quantity',
                                                                counterText:
                                                                "",
                                                                isCollapsed:
                                                                true,
                                                                focusedBorder:
                                                                OutlineInputBorder(
                                                                  borderSide: const BorderSide(
                                                                      color:
                                                                      AppColors
                                                                          .secondaryColor,
                                                                      width: 2),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                border:
                                                                OutlineInputBorder(
                                                                  borderSide: const BorderSide(
                                                                      color:
                                                                      Colors
                                                                          .black,
                                                                      width: 2),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                ),
                                                                contentPadding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                    15,
                                                                    horizontal:
                                                                    10),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed:
                                                                () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "Close")),
                                                        TextButton(
                                                            onPressed:
                                                                () {
                                                              if (qtyFormKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                dashboardProvider
                                                                    .addUpdateProductToCart(
                                                                    filteredProducts[index]
                                                                        .productDetail!,
                                                                    'add',
                                                                    context,
                                                                    double
                                                                        .parse(
                                                                        directQtyController
                                                                            .text));
                                                                Navigator.pop(
                                                                    context);
                                                                directQtyController
                                                                    .clear();
                                                              }
                                                            },
                                                            child: const Text(
                                                                "Confirm"))
                                                      ],
                                                    ),
                                              );
                                            },
                                            onTap: () {
                                              dashboardProvider
                                                  .addUpdateProductToCart(
                                                  filteredProducts[
                                                  index]
                                                      .productDetail!,
                                                  'add',
                                                  context,
                                                  null);
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
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
                                                    textAlign: TextAlign
                                                        .center,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  filteredProducts[index]
                                      .productDetail!
                                      .productDiscount! >
                                      0
                                      ? Text(
                                    "${filteredProducts[index].saveMessage}",
                                    style: const TextStyle(
                                        color: AppColors
                                            .secondaryColor,
                                        fontSize: 12),
                                  )
                                      : const SizedBox.shrink()
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
                    : const Center(
                  child: Text("No results to display"),
                )
              ],
            ),
          ));
    });
  }
}
