import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/dashboard/providers/dashboard_provider.dart';
import 'package:samruddhi/utils/routes.dart';
import 'package:samruddhi/utils/url_constants.dart';

import '../../../utils/app_colors.dart';
import '../../models/home_data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool firstTimeLoading = false;
  int nearbyStoreFilter = 1;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder: (BuildContext context, DashboardProvider dashboardProvider,
          Widget? child) {
        dashboardProvider.homePageContext = context;
        if (firstTimeLoading != true) {
          dashboardProvider.getHomeData();
          firstTimeLoading = true;
        }
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 120,
            backgroundColor: AppColors.scaffoldBackground,
            automaticallyImplyLeading: false,
            title: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hi ${prefModel.userData!.firstName}',
                        style: const TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.placeOrderRoute);
                              },
                              icon: const Icon(Icons.shopping_cart_outlined)),
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.notificationsRoute);
                              },
                              icon: const Icon(Icons.notifications_none_outlined)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:0.0),
                    child: GestureDetector(
                      onTap: () {
                        dashboardProvider.searchType = 'productName';
                        dashboardProvider.searchController.clear();
                        dashboardProvider.searchKeyWord = '';
                        Navigator.pushNamed(
                            context, Routes.searchScreenRoute);
                      },
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search products or stores',
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          body: dashboardProvider.homeData != null
              ? RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 1));
                    _pullRefresh(dashboardProvider);
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.selectAddressRoute);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const ShapeDecoration(
                                    color: AppColors.primaryColor,
                                    shape: OvalBorder(),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Your Location',
                                      style: TextStyle(
                                        color: AppColors.fontColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenSize.width / 1.6,
                                      child: Text(
                                        '${dashboardProvider.address}',
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: AppColors.fontColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const Icon(
                                  Icons.navigate_next,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                        ),

                        dashboardProvider.homeData!.result!.myStore!.isNotEmpty
                            ? const SizedBox(
                                height: 10,
                              )
                            : const SizedBox.shrink(),
                        dashboardProvider.homeData!.result!.myStore!.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    dashboardProvider.getIntoStore(
                                        dashboardProvider
                                            .homeData!.result!.myStore![0]);
                                    // Navigator.pushNamed(context, Routes.storeInRoute);
                                  },
                                  child: Container(
                                    width: screenSize.width,
                                    decoration: ShapeDecoration(
                                      color: AppColors.storeBackground,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.52),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 125,
                                          height: 130,
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                '${UrlConstant.imageBaseUrl}${dashboardProvider.homeData!.result!.myStore![0].storeImgArray![0].imageUrl}',
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15.50),
                                                bottomLeft:
                                                    Radius.circular(15.50),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            const Text(
                                              'My Store',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.55,
                                                fontWeight: FontWeight.bold,
                                                height: 1.25,
                                              ),
                                            ),
                                            Text(
                                              '${dashboardProvider.homeData!.result!.myStore![0].displayName}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                height: 1.48,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            SizedBox(
                                              width: screenSize.width / 2,
                                              child: Text(
                                                '${dashboardProvider.homeData!.result!.myStore![0].addressArray!.completeAddress}',
                                                style: const TextStyle(
                                                  color: AppColors.fontColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            // const SizedBox(
                                            //   height: 5,
                                            // ),
                                            // Container(
                                            //   padding:
                                            //       const EdgeInsets.symmetric(
                                            //           horizontal: 16,
                                            //           vertical: 4),
                                            //   decoration: ShapeDecoration(
                                            //     color: Colors.white,
                                            //     shape: RoundedRectangleBorder(
                                            //       borderRadius:
                                            //           BorderRadius.circular(
                                            //               31.03),
                                            //     ),
                                            //   ),
                                            //   child: const Row(
                                            //     mainAxisSize: MainAxisSize.min,
                                            //     mainAxisAlignment:
                                            //         MainAxisAlignment.center,
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment.center,
                                            //     children: [
                                            //       Text(
                                            //         'Browse ',
                                            //         style: TextStyle(
                                            //           color: Colors.black,
                                            //           fontSize: 12.41,
                                            //           fontWeight:
                                            //               FontWeight.w400,
                                            //           height: 1.33,
                                            //         ),
                                            //       ),
                                            //       SizedBox(width: 4.14),
                                            //       Icon(
                                            //           Icons.navigate_next_sharp)
                                            //     ],
                                            //   ),
                                            // ),
                                            // const SizedBox(
                                            //   height: 5,
                                            // ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            'Categories',
                            style: TextStyle(
                              color: AppColors.fontColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          itemCount: dashboardProvider.homeData!.result!.productCategories!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () async {
                                dashboardProvider.searchType =
                                    'productCategory';
                                dashboardProvider.searchKeyWord =
                                    '${dashboardProvider.homeData!.result!.productCategories![index].productCategoryName}';
                                dashboardProvider.searchController.clear();
                                Navigator.pushNamed(
                                    context, Routes.searchScreenRoute);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '${UrlConstant.imageBaseUrl}${dashboardProvider.homeData!.result!.productCategories![index].productCategoryImgArray![0].imagePath}'),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: const OvalBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      '${dashboardProvider.homeData!.result!.productCategories![index].productCategoryName}',
                                      textAlign: TextAlign.center,
                                      maxLines: 2, // Set maximum number of lines
                                      overflow: TextOverflow.ellipsis, // Define overflow behavior
                                      style: const TextStyle(
                                        color: AppColors.fontColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        // SizedBox(
                        //   height: 230,
                        //   child: GridView.builder(
                        //     shrinkWrap: true,
                        //     gridDelegate:
                        //     const SliverGridDelegateWithFixedCrossAxisCount(
                        //       crossAxisCount: 2,
                        //       // Number of columns
                        //       mainAxisSpacing: 4.0,
                        //       // Vertical spacing between rows
                        //       crossAxisSpacing:
                        //       4.0, // Horizontal spacing between columns
                        //     ),
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: dashboardProvider.homeData!.result!.productCategories!.length,
                        //     itemBuilder: (context, index) {
                        //       return GestureDetector(
                        //         onTap: () async {
                        //           dashboardProvider.searchType = 'productCategory';
                        //           dashboardProvider.searchKeyWord = '${dashboardProvider.homeData!.result!.productCategories![index].productCategoryName}';
                        //           dashboardProvider.searchController.clear();
                        //           Navigator.pushNamed(context, Routes.searchScreenRoute);
                        //         },
                        //         child: Padding(
                        //           padding:
                        //           const EdgeInsets.symmetric(horizontal: 8.0),
                        //           child: Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             children: [
                        //               Container(
                        //                 width: 80,
                        //                 height: 80,
                        //                 decoration: ShapeDecoration(
                        //                   image: DecorationImage(
                        //                     image: NetworkImage(
                        //                         '${UrlConstant.imageBaseUrl}${dashboardProvider.homeData!.result!.productCategories![index].productCategoryImgArray![0].imagePath}'),
                        //                     fit: BoxFit.fill,
                        //                   ),
                        //                   shape: const OvalBorder(),
                        //                 ),
                        //               ),
                        //               const SizedBox(height: 5),
                        //               Text(
                        //                 '${dashboardProvider.homeData!.result!.productCategories![index].productCategoryName}',
                        //                 style: const TextStyle(
                        //                   color: AppColors.fontColor,
                        //                   fontSize: 10,
                        //                   fontWeight: FontWeight.w600,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            'Stores near you',
                            style: TextStyle(
                              color: AppColors.fontColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    nearbyStoreFilter=1;
                                  });
                                },
                                child: Container(
                                  margin:const EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    color: nearbyStoreFilter==1?AppColors.secondaryColor:Colors.grey,
                                    borderRadius: const BorderRadius.all(Radius.circular(8))
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                  child: const Center(
                                    child: Text("All",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    nearbyStoreFilter=2;
                                  });
                                },
                                child: Container(
                                  margin:const EdgeInsets.only(right: 20),
                                  decoration:BoxDecoration(
                                      color: nearbyStoreFilter==2?AppColors.secondaryColor:Colors.grey,
                                      borderRadius: const BorderRadius.all(Radius.circular(8))
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                  child: const Center(
                                    child: Text("Delivery",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    nearbyStoreFilter=3;
                                  });
                                },
                                child: Container(
                                  margin:const EdgeInsets.only(right: 20),
                                  decoration:BoxDecoration(
                                      color: nearbyStoreFilter==3?AppColors.secondaryColor:Colors.grey,
                                      borderRadius: const BorderRadius.all(Radius.circular(8))
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                  child: const Center(
                                    child: Text("Self pickup",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ListView.separated(
                              shrinkWrap: true,
                            itemCount: nearbyStoreFilter==2?dashboardProvider.homeData!.result!.nearStoresdata!.where((store) => store.isHomeDelivery!).length:nearbyStoreFilter==1?dashboardProvider.homeData!.result!.nearStoresdata!.length:nearbyStoreFilter==3?dashboardProvider.homeData!.result!.nearStoresdata!.where((store) => !store.isHomeDelivery!).length:0,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                MyStore? store;
                                if(nearbyStoreFilter==1){
                                  store = dashboardProvider.homeData!.result!.nearStoresdata![index];
                                }else if(nearbyStoreFilter==2){
                                  store = dashboardProvider.homeData!.result!.nearStoresdata!.where((store) => store.isHomeDelivery!).toList()[index];
                                }else if(nearbyStoreFilter==3){
                                  store = dashboardProvider.homeData!.result!.nearStoresdata!.where((store) => !store.isHomeDelivery!).toList()[index];
                                }
                                return GestureDetector(
                                    onTap: () {
                                      dashboardProvider.getIntoStore(store!);
                                    },
                                    child: Container(
                                      // margin: const EdgeInsets.only(
                                      //     bottom: 10),
                                      width: screenSize.width,
                                      decoration: ShapeDecoration(
                                        color: AppColors.storeBackground,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.52),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 125,
                                            height: 130,
                                            decoration: ShapeDecoration(
                                              image: DecorationImage(
                                                image: store!
                                                        .storeImgArray!
                                                        .isNotEmpty
                                                    ? NetworkImage(
                                                        "${UrlConstant.imageBaseUrl}${store.storeImgArray![0].imageUrl}")
                                                    : const NetworkImage(
                                                        "https://via.placeholder.com/110x125"),
                                                fit: BoxFit.fill,
                                              ),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(15.50),
                                                  bottomLeft:
                                                      Radius.circular(15.50),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                '${store.displayName}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.55,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.25,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 212,
                                                child: Text(
                                                  '${store.storeCategoryName}',
                                                  style: const TextStyle(
                                                    color: AppColors.fontColor,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              SizedBox(
                                                child: Text(
                                                  store.isHomeDelivery!?'Home Delivery':'Self pickup',
                                                  style: const TextStyle(
                                                    color: AppColors.fontColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              SizedBox(
                                                width: 212,
                                                child: Text(
                                                  '${store.addressArray!.completeAddress}',
                                                  style: const TextStyle(
                                                    color: AppColors.fontColor,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              // Container(
                                              //   padding:
                                              //       const EdgeInsets.symmetric(
                                              //           horizontal: 16,
                                              //           vertical: 4),
                                              //   decoration: ShapeDecoration(
                                              //     color: Colors.white,
                                              //     shape: RoundedRectangleBorder(
                                              //       borderRadius:
                                              //           BorderRadius.circular(
                                              //               31.03),
                                              //     ),
                                              //   ),
                                              //   child: const Row(
                                              //     mainAxisSize:
                                              //         MainAxisSize.min,
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment.center,
                                              //     crossAxisAlignment:
                                              //         CrossAxisAlignment.center,
                                              //     children: [
                                              //       Text(
                                              //         'Browse ',
                                              //         style: TextStyle(
                                              //           color: Colors.black,
                                              //           fontSize: 12.41,
                                              //           fontWeight:
                                              //               FontWeight.w400,
                                              //           height: 1.33,
                                              //         ),
                                              //       ),
                                              //       SizedBox(width: 4.14),
                                              //       Icon(Icons
                                              //           .navigate_next_sharp)
                                              //     ],
                                              //   ),
                                              // ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                              }, separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(height: 10,);
                          },),
                        )
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }

  _pullRefresh(DashboardProvider dashboardProvider) async {
    dashboardProvider.homeData = null;
    dashboardProvider.getHomeData();
  }
}
