import 'package:flutter/material.dart';
import 'package:samruddhi/auth/model/login_response_model.dart';
import 'package:samruddhi/dashboard/home/controller/home_controller.dart';
import 'package:samruddhi/dashboard/home/model/home_data_model.dart';
import 'package:samruddhi/utils/app_widgets.dart';
import 'package:samruddhi/utils/routes.dart';
import 'package:samruddhi/utils/url_constants.dart';

import '../../../database/app_pref.dart';
import '../../../database/models/pref_model.dart';
import '../../../utils/app_colors.dart';
import '../model/in_store_data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PrefModel prefModel = AppPref.getPref();

  HomeController homeController = HomeController();
  late Future<Map> homeData;

  @override
  void initState() {
    homeData = homeController.getHomeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.scaffoldBackground,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.notificationsRoute);
                },
                icon: const Icon(Icons.notifications_none_outlined)),
            // IconButton(
            //     onPressed: () {
            //       Navigator.pushNamed(context, Routes.placeOrderRoute)
            //           .then((value) {
            //         setState(() {});
            //         return;
            //       });
            //     },
            //     icon: const Icon(Icons.shopping_cart_outlined))
          ],
          title: Text(
            'Hi ${prefModel.userData!.firstName}',
            style: const TextStyle(
              color: AppColors.fontColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: FutureBuilder(
              future: homeData,
              builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  Address selectedAddress = snapshot.data!['Address'];
                  HomeDataModel homeData = snapshot.data!['HomeData'];
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.selectAddressRoute,
                                  arguments: {'callBack': onAddressChanged});
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
                                      'Selected Location',
                                      style: TextStyle(
                                        color: AppColors.fontColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(
                                        width: screenSize.width / 1.6,
                                        child: Text(
                                          selectedAddress.completeAddress!,
                                          style: const TextStyle(
                                            color: AppColors.fontColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
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
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.searchScreenRoute,
                                  arguments: {
                                    'lat': selectedAddress.lat,
                                    'lng': selectedAddress.lng,
                                    "searchType": 'productName',
                                    "searchKeyWord": ' ',
                                  });
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
                        SizedBox(
                          height: homeData.result!.myStore!.isNotEmpty ? 20 : 0,
                        ),
                        homeData.result!.myStore!.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.storeInRoute);
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
                                          decoration: const ShapeDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://via.placeholder.com/110x125"),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: RoundedRectangleBorder(
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
                                            const Text(
                                              'Vinayaka Provision stores',
                                              style: TextStyle(
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
                                              child: const Text(
                                                '#11, First floor vcnr Hospital, Nelamangala bangalore - 562123',
                                                style: TextStyle(
                                                  color: AppColors.fontColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 4),
                                              decoration: ShapeDecoration(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          31.03),
                                                ),
                                              ),
                                              child: const Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Browse ',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12.41,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.33,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4.14),
                                                  Icon(
                                                      Icons.navigate_next_sharp)
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(
                          height: 20,
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
                          height: 20,
                        ),
                        SizedBox(
                          height: 210,
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // Number of columns
                              mainAxisSpacing: 4.0,
                              // Vertical spacing between rows
                              crossAxisSpacing:
                                  4.0, // Horizontal spacing between columns
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                homeData.result!.productCategories!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  if (context.mounted) {
                                    Navigator.pushNamed(
                                        context, Routes.searchScreenRoute,
                                        arguments: {
                                          'lat': selectedAddress.lat,
                                          'lng': selectedAddress.lng,
                                          "searchType": 'productCategory',
                                          "searchKeyWord": homeData
                                              .result!
                                              .productCategories![index]
                                              .productCategoryName,
                                        });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(homeData
                                                .result!
                                                .productCategories![index]
                                                .image!=null?UrlConstant
                                                    .imageBaseUrl +
                                                homeData
                                                    .result!
                                                    .productCategories![index]
                                                    .image:"https://placehold.co/100x100/png"),
                                            fit: BoxFit.fill,
                                          ),
                                          shape: const OvalBorder(),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        homeData
                                            .result!
                                            .productCategories![index]
                                            .productCategoryName!,
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
                        ),
                        const SizedBox(
                          height: 20,
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
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  homeData.result!.nearStoresdata!.length,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => GestureDetector(
                                    onTap: () async {
                                      showLoaderDialog(context);
                                      InStoreDataModel inStoreData =
                                          await homeController.getInStoreData(
                                              homeData
                                                  .result!
                                                  .nearStoresdata![index]
                                                  .storeId,
                                              context);
                                      if (context.mounted) {
                                        Navigator.pop(context);
                                        if (inStoreData.statusCode == 200) {
                                          Navigator.pushNamed(
                                              context, Routes.storeInRoute,
                                              arguments: {
                                                "inStoreData": inStoreData,
                                                "searchQuery": null
                                              });
                                        } else {
                                          showErrorToast(
                                              context, inStoreData.message!);
                                        }
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
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
                                                image: NetworkImage(UrlConstant
                                                        .imageBaseUrl +
                                                    homeData
                                                        .result!
                                                        .nearStoresdata![index]
                                                        .image!),
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
                                              SizedBox(
                                                width: screenSize.width / 2,
                                                child: Text(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  homeData
                                                      .result!
                                                      .nearStoresdata![index]
                                                      .displayName!,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.55,
                                                    fontWeight: FontWeight.bold,
                                                    height: 1.25,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: screenSize.width / 2,
                                                child: Text(
                                                  homeData
                                                      .result!
                                                      .nearStoresdata![index]
                                                      .storeCategory!,
                                                  style: const TextStyle(
                                                    color: AppColors.fontColor,
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              SizedBox(
                                                width: 212,
                                                child: Text(
                                                  "${homeData.result!.nearStoresdata![index].address!.address!} ${homeData.result!.nearStoresdata![index].address!.city!} ${homeData.result!.nearStoresdata![index].address!.zipCode!}",
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
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 4),
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            31.03),
                                                  ),
                                                ),
                                                child: const Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Browse ',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.41,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.33,
                                                      ),
                                                    ),
                                                    SizedBox(width: 4.14),
                                                    Icon(Icons
                                                        .navigate_next_sharp)
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                        )
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${snapshot.error}'),
                        ElevatedButton(
                            onPressed: _pullRefresh,
                            child: const Text("Refresh"))
                      ],
                    ),
                  );
                }
                return const Center(
                  child: Text("Loadingg....."),
                );
              }),
        ));
  }

  Future<void> _pullRefresh() async {
    setState(() {
      homeData = homeController.getHomeData();
    });
  }

  Future<void> onAddressChanged(Address? address) async {
    prefModel.selectedAddress = address;
    await AppPref.setPref(prefModel);
    setState(() {
      homeData = homeController.getHomeData();
    });
  }
}
