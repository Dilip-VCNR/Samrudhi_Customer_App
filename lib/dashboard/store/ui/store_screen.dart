import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/dashboard/providers/dashboard_provider.dart';
import 'package:samruddhi/utils/app_colors.dart';

import '../../../utils/routes.dart';
import '../controller/cart_controller.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  // List<StoreProducts> products = [];

  // List<String> hiddenSubcategories = [];

  // @override
  // void initState() {
  //   super.initState();
  //   // Category 1: Jeans
  //   products.add(StoreProducts(
  //       id: "64b79066088dc100320f63aa",
  //       createdAt: DateTime(2023, 7, 19, 12, 57, 34),
  //       productName: "Blue Jeans",
  //       image: "/uploads/products/jeans_blue.jpeg",
  //       storeId: "store_d1af2420-1fb2-11ee-a954-0b7214842cb7",
  //       storeName: "praveenstores",
  //       productCategory: "clothes",
  //       subCategory: "Jeans",
  //       description: "Comfortable and stylish blue jeans.",
  //       mrp: 600,
  //       tax: 30,
  //       sellingPrice: 400,
  //       availability: true,
  //       sku: "xyz123",
  //       uom: "pcs",
  //       discount: 10,
  //       offer: 20,
  //       status: true,
  //       productId: "product_ba80a8b0-2605-11ee-80f5-f197921726c5",
  //       v: 0,
  //       cartCount: 0));
  //
  //   products.add(StoreProducts(
  //       id: "75c88fd11fb2a9c320f6da9",
  //       createdAt: DateTime(2023, 8, 1, 10, 15, 22),
  //       productName: "Black Jeans",
  //       image: "/uploads/products/jeans_black.jpeg",
  //       storeId: "store_d1af2420-1fb2-11ee-a954-0b7214842cb7",
  //       storeName: "praveenstores",
  //       productCategory: "clothes",
  //       subCategory: "Jeans",
  //       description: "Classic black jeans for everyday wear.",
  //       mrp: 550,
  //       tax: 25,
  //       sellingPrice: 350,
  //       availability: true,
  //       sku: "abc456",
  //       uom: "pcs",
  //       discount: 15,
  //       offer: 30,
  //       status: true,
  //       productId: "product_ea81b3d3-3807-22fa-67b1-f1058aa891bc",
  //       v: 0,
  //       cartCount: 0));
  //
  //   // Category 2: T-Shirts
  //   products.add(StoreProducts(
  //       id: "63a1de77efbcb9e7e4c6d700",
  //       createdAt: DateTime(2023, 8, 2, 14, 10, 45),
  //       productName: "Red T-shirt",
  //       image: "/uploads/products/tshirt_red.jpeg",
  //       storeId: "store_d1af2420-1fb2-11ee-a954-0b7214842cb7",
  //       storeName: "praveenstores",
  //       productCategory: "clothes",
  //       subCategory: "T-Shirts",
  //       description: "Stylish red t-shirt for casual occasions.",
  //       mrp: 300,
  //       tax: 15,
  //       sellingPrice: 250,
  //       availability: true,
  //       sku: "pqr789",
  //       uom: "pcs",
  //       discount: 10,
  //       offer: 20,
  //       status: true,
  //       productId: "product_75f8d9a1-10bb-88fe-29c4-e1a987d394bb",
  //       v: 0,
  //       cartCount: 0));
  //
  //   products.add(StoreProducts(
  //       id: "b1e23aa3f0aa9958ac25b889",
  //       createdAt: DateTime(2023, 8, 3, 11, 30, 18),
  //       productName: "White T-shirt",
  //       image: "/uploads/products/tshirt_white.jpeg",
  //       storeId: "store_d1af2420-1fb2-11ee-a954-0b7214842cb7",
  //       storeName: "praveenstores",
  //       productCategory: "clothes",
  //       subCategory: "T-Shirts",
  //       description: "Classic white t-shirt suitable for any occasion.",
  //       mrp: 350,
  //       tax: 18,
  //       sellingPrice: 300,
  //       availability: true,
  //       sku: "def123",
  //       uom: "pcs",
  //       discount: 10,
  //       offer: 25,
  //       status: true,
  //       productId: "product_aefba812-d6bb-12ef-456b-3abf3e7d094d",
  //       v: 0,
  //       cartCount: 0));
  //
  //   // Category 3: Shirts
  //   products.add(StoreProducts(
  //     id: "c1a5f74e2da24b408a2bc0a1",
  //     createdAt: DateTime(2023, 8, 5, 9, 20, 15),
  //     productName: "Formal Shirt",
  //     image: "/uploads/products/shirt_formal.jpeg",
  //     storeId: "store_d1af2420-1fb2-11ee-a954-0b7214842cb7",
  //     storeName: "praveenstores",
  //     productCategory: "clothes",
  //     subCategory: "T-Shirts",
  //     description: "Elegant formal shirt for professional occasions.",
  //     mrp: 800,
  //     tax: 40,
  //     sellingPrice: 600,
  //     availability: true,
  //     sku: "ghi789",
  //     uom: "pcs",
  //     discount: 10,
  //     offer: 30,
  //     status: true,
  //     productId: "product_2e1e1e12-4bc7-11ee-b33d-af26c1f4a044",
  //     v: 0,
  //     cartCount: 0,
  //   ));
  //
  //   // Category 3: Shirts
  //   products.add(StoreProducts(
  //     id: "e35a7d5fc243b9e8ca1daad7",
  //     createdAt: DateTime(2023, 8, 5, 11, 45, 30),
  //     productName: "Casual Shirt",
  //     image: "/uploads/products/shirt_casual.jpeg",
  //     storeId: "store_d1af2420-1fb2-11ee-a954-0b7214842cb7",
  //     storeName: "praveenstores",
  //     productCategory: "clothes",
  //     subCategory: "Shirts",
  //     description: "Comfortable and trendy casual shirt.",
  //     mrp: 600,
  //     tax: 30,
  //     sellingPrice: 450,
  //     availability: true,
  //     sku: "jkl101",
  //     uom: "pcs",
  //     discount: 10,
  //     offer: 25,
  //     status: true,
  //     productId: "product_3ff7ddc2-d091-4df3-b1d8-279871428fa8",
  //     v: 0,
  //     cartCount: 0,
  //   ));
  // }

  CartController cartController = CartController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder: (BuildContext context, DashboardProvider dashboardProvider,
          Widget? child) {
        return Scaffold(
          bottomNavigationBar: cartController.cartItems.isNotEmpty
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
                          Navigator.pushNamed(context, Routes.placeOrderRoute,
                              arguments: {
                                'cartItems': cartController.cartItems
                              });
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
                                  text: '₹${cartController.payable}',
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
                for(int i=0; i < dashboardProvider.storeData!.result!.productDetails!.length;i++)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(dashboardProvider.storeData!.result!.productDetails![i].productCategories!,
                          style: const TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: dashboardProvider.storeData!.result!.productDetails![i].productList!.length,
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
                                        image: const DecorationImage(
                                          image: NetworkImage(
                                              "https://via.placeholder.com/115x111"),
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dashboardProvider.storeData!.result!
                                                .productDetails![i].productList![index].
                                            productName!,
                                            style: const TextStyle(
                                              color: AppColors.fontColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.60,
                                            ),
                                          ),
                                          Text(
                                            '₹${ dashboardProvider.storeData!.result!
                                                .productDetails![i].productList![index]
                                                .sellingPrice!}',
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
                                                '₹${ dashboardProvider.storeData!.result!
                                                    .productDetails![i].productList![index]
                                                    .sellingPrice!}',
                                                style: const TextStyle(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await dashboardProvider.addProductToCart(dashboardProvider.storeData!.result!
                                                      .productDetails![i].productList![index]);
                                                },
                                                child: Container(
                                                  width: screenSize.width / 4,
                                                  height: 40,
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
                                              ),
                                            ],
                                          ),
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
