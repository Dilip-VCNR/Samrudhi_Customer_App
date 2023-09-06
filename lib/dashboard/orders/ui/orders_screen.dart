import 'package:flutter/material.dart';
import 'package:samruddhi/dashboard/orders/controller/order_controller.dart';
import 'package:samruddhi/dashboard/orders/model/my_orders_model.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/routes.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future<MyOrdersModel> ordersData;
  OrderController orderController = OrderController();

  @override
  void initState() {
    ordersData = orderController.getOrdersData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    List<Result>? pendingOrders = [];
    List<Result>? completedOrders = [];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 16),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(text: "Ongoing"),
                Tab(text: "Finished"),
              ],
            ),
          ),
          body: FutureBuilder(
              future: ordersData,
              builder: (BuildContext context,
                  AsyncSnapshot<MyOrdersModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.hasData) {
                  for (int i = 0; i < snapshot.data!.result!.length; i++) {
                    if (snapshot.data!.result![i].status != "completed") {
                      pendingOrders.add(snapshot.data!.result![i]);
                    } else {
                      completedOrders.add(snapshot.data!.result![i]);
                    }
                  }
                  return TabBarView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: pendingOrders.isNotEmpty?ongoingOrderWidget(screenSize, pendingOrders):const Center(child: Text("No orders yet"),),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: completedOrders.isNotEmpty?finishedOrderWidget(screenSize, completedOrders):const Center(child: Text("No orders yet"),),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${snapshot.error}'),
                        // ElevatedButton(
                        //     onPressed: _pullRefresh,
                        //     child: const Text("Refresh"))
                      ],
                    ),
                  );
                }
                return const Center(
                  child: Text("Loadingg....."),
                );
              })),
    );
  }

  finishedOrderWidget(Size screenSize, List<Result> completedOrders) {
    return SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: completedOrders.length,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.orderDetailsRoute);
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
                                  children: [
                                    const Text(
                                      'More Super stores',
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
                                        color: AppColors.secondaryColor,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 0.50,
                                              color: AppColors.secondaryColor),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: const Center(
                                          child: Text(
                                        'Delivered',
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
                        const Text(
                          '1X Butter Nandini 250ML',
                          style: TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          '2X Bullet rice 1KG Packet',
                          style: TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          '3X Dosa batter half KG packet',
                          style: TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Divider(),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '27 August 2023 at 5:30 PM',
                              style: TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '₹ 172.50',
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

  ongoingOrderWidget(Size screenSize, List<Result> pendingOrders) {
    return SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: pendingOrders.length,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.orderDetailsRoute);
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Store name",
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
                                        '${pendingOrders[index].status}',
                                        style: const TextStyle(
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
                            i < pendingOrders[index].productDetails!.length;
                            i++)
                          Text(
                            '${pendingOrders[index].productDetails![i].cartCount}X ${pendingOrders[index].productDetails![i].productName}',
                            style: const TextStyle(
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
                              '${pendingOrders[index].date}',
                              // '27 August 2023 at 5:30 PM',
                              style: const TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '₹${pendingOrders[index].grandTotal}',
                              style: const TextStyle(
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
