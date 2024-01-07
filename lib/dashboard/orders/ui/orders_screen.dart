import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/dashboard/orders/provider/orders_provider.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/routes.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool firstTimeLoading = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Consumer(
      builder:
          (BuildContext context, OrdersProvider ordersProvider, Widget? child) {
        ordersProvider.ordersPageContext = context;
        if (firstTimeLoading != true) {
          ordersProvider.getAllOrders();
          firstTimeLoading = true;
        }
        return DefaultTabController(
          length: 2,
          child: ordersProvider.allOrdersResponse != null
              ? Scaffold(
                  appBar: AppBar(
                    backgroundColor: AppColors.scaffoldBackground,
                    automaticallyImplyLeading: false,
                    title: const Text(
                      'My Orders',
                      style: TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    bottom: TabBar(
                      indicator: ShapeDecoration(
                        color: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      indicatorColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        Tab(text: "Ongoing"),
                        Tab(text: "Finished"),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: orderWidget(screenSize, ordersProvider),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: orderWidget(screenSize, ordersProvider),
                      )
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }


  orderWidget(Size screenSize, OrdersProvider ordersProvider) {
    return SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: ordersProvider.allOrdersResponse!.result![0].orderList!.length,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.orderDetailsRoute,arguments: {'order':ordersProvider.allOrdersResponse!.result![0].orderList![index]});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: screenSize.width,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: ShapeDecoration(
                                image: const DecorationImage(
                                  image: NetworkImage(
                                      "https://via.placeholder.com/75x75"),
                                  fit: BoxFit.fill,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${ordersProvider.allOrdersResponse!.result![0].orderList![index].productDetails![0].storeName}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        height: 1.48,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 10),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFFF8702),
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFFF8702)),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        '${ordersProvider.allOrdersResponse!.result![0].orderList![index].orderStatus}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 212,
                                  child: Text(
                                    '#11, First floor vcnr Hospital, Nelamangala \nbangalore - 562123',
                                    style: TextStyle(
                                      color: AppColors.fontColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        for (int i = 0;
                            i <
                                ordersProvider.allOrdersResponse!.result![0]
                                    .orderList![index].productDetails!.length;
                            i++)
                          Text(
                            '${ordersProvider.allOrdersResponse!.result![0].orderList![index].productDetails![i].addedCartQuantity}X ${ordersProvider.allOrdersResponse!.result![0].orderList![index].productDetails![i].productName}',
                            style: TextStyle(
                              color: AppColors.fontColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${ordersProvider.allOrdersResponse!.result![0].orderList![index].orderDate}',
                              style: TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '₹${ordersProvider.allOrdersResponse!.result![0].orderList![index].orderGrandTotal}',
                              style: TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )));
  }
}
