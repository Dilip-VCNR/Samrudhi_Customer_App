
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/dashboard/models/home_data_model.dart';
import 'package:samruddhi/dashboard/providers/dashboard_provider.dart';
import 'package:samruddhi/utils/routes.dart';
import 'package:samruddhi/utils/url_constants.dart';

import '../../../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool firstTimeLoading = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder: (BuildContext context, DashboardProvider dashboardProvider,
          Widget? child) {
        dashboardProvider.homePageContext = context;
        if(firstTimeLoading!=true){
          dashboardProvider.getHomeData();
          firstTimeLoading = true;
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBackground,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.notificationsRoute);
                  },
                  icon: const Icon(Icons.notifications_none_outlined))
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
          body: FutureBuilder(
            future: dashboardProvider.homeData,
            builder:
                (BuildContext context, AsyncSnapshot<HomeDataModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.hasData && snapshot.data!.result!=null) {
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
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: GestureDetector(
                          onTap: () {
                            dashboardProvider.searchType = 'productName';
                            dashboardProvider.searchController.clear();
                            dashboardProvider.searchKeyWord = '';
                            Navigator.pushNamed(context, Routes.searchScreenRoute);
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
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.storeInRoute);
                          },
                          child: Container(
                            width: screenSize.width,
                            decoration: ShapeDecoration(
                              color: AppColors.storeBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.52),
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
                                        bottomLeft: Radius.circular(15.50),
                                      ),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 4),
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(31.03),
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
                                              fontWeight: FontWeight.w400,
                                              height: 1.33,
                                            ),
                                          ),
                                          SizedBox(width: 4.14),
                                          Icon(Icons.navigate_next_sharp)
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
                      ),
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
                          itemCount: snapshot.data!.result!.productCategories!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                dashboardProvider.searchType = 'productCategory';
                                dashboardProvider.searchKeyWord = '${snapshot.data!.result!.productCategories![index].productCategoryName}';
                                dashboardProvider.searchController.clear();
                                Navigator.pushNamed(context, Routes.searchScreenRoute);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: ShapeDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '${UrlConstant.imageBaseUrl}${snapshot.data!.result!.productCategories![index].productCategoryImgArray![0].imagePath}'),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: const OvalBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${snapshot.data!.result!.productCategories![index].productCategoryName}',
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
                                snapshot.data!.result!.nearStoresdata!.length,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    dashboardProvider.getIntoStore(snapshot.data!.result!.nearStoresdata![index]);
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
                                              image: snapshot.data!.result!.nearStoresdata![index].storeImgArray!.isNotEmpty?NetworkImage(
                                                  "${UrlConstant.imageBaseUrl}${snapshot.data!.result!.nearStoresdata![index].storeImgArray![0].imageUrl}"):const NetworkImage(
                                                  "https://via.placeholder.com/110x125"),
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
                                            Text(
                                              '${snapshot.data!.result!.nearStoresdata![index].displayName}',
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
                                                '${snapshot.data!.result!.nearStoresdata![index].storeCategoryName}',
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
                                                '${snapshot.data!.result!.nearStoresdata![index].addressArray![0].completeAddress} ${snapshot.data!.result!.nearStoresdata![index].addressArray![0].state} ${snapshot.data!.result!.nearStoresdata![index].addressArray![0].city} ${snapshot.data!.result!.nearStoresdata![index].addressArray![0].completeAddress} ${snapshot.data!.result!.nearStoresdata![index].addressArray![0].zipCode}',
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
                          onPressed: (){_pullRefresh(dashboardProvider);},
                          child: const Text("Refresh"))
                    ],
                  ),
                );
              }
              return const Center(
                child: Text("Loadingg....."),
              );
            },
          ),
        );
      },
    );
  }

  _pullRefresh(DashboardProvider dashboardProvider) async {
    dashboardProvider.getHomeData();
  }
}
