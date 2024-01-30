import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/dashboard/providers/dashboard_provider.dart';
import 'package:samruddhi/utils/url_constants.dart';

import '../../../utils/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List suggestions = ["Rice", "Bread", "Biscuits", "Apple", "green peas"];
  bool firstTimeLoading = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Consumer(
      builder: (BuildContext context, DashboardProvider dashboardProvider,
          Widget? child) {
        if (firstTimeLoading != true && dashboardProvider.searchKeyWord!=null && dashboardProvider.searchKeyWord!='') {
          dashboardProvider.searchScreenContext = context;
          dashboardProvider.getSearchResults();
          firstTimeLoading = true;
        }
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Search',
                style: TextStyle(
                  color: AppColors.fontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (query) {
                      setState(() {
                        firstTimeLoading = false;
                        dashboardProvider.searchKeyWord = query;
                      });
                    },
                    autofocus:
                        dashboardProvider.searchKeyWord == null ? true : false,
                    controller: dashboardProvider.searchController,
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
                  const SizedBox(
                    height: 20,
                  ),
                  if (dashboardProvider.searchKeyWord != null &&
                      dashboardProvider.searchKeyWord != "" && dashboardProvider.searchResponse != null)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Stores with ${dashboardProvider.searchKeyWord}',
                          style: const TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: dashboardProvider.searchResponse!.result!.length,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    dashboardProvider.getIntoStore(dashboardProvider.searchResponse!.result![index]);
                                    // Navigator.pushNamed(
                                    //     context, Routes.storeInRoute);
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
                                              image: NetworkImage(
                                                  '${UrlConstant.imageBaseUrl}${dashboardProvider.searchResponse!.result![index].storeImgArray![0].imageUrl}'),
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
                                              '${dashboardProvider.searchResponse!.result![index].displayName}',
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
                                                '${dashboardProvider.searchResponse!.result![index].storeCategoryName}',
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
                                              width: 212,
                                              child: Text(
                                                '${dashboardProvider.searchResponse!.result![index].addressArray!.completeAddress}',
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
                                            SizedBox(
                                              width: 212,
                                              child: Text(
                                                dashboardProvider.searchResponse!.result![index].isHomeDelivery!?'Home delivery':'Self pickup',
                                                style: const TextStyle(
                                                  color: AppColors.fontColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
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
                                ))
                      ],
                    )
                  else
                    Container(),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: suggestions.length,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              setState(() {
                                dashboardProvider.searchController.text =
                                    suggestions[index];
                                dashboardProvider.searchKeyWord =
                                    suggestions[index];
                                dashboardProvider.searchType = 'productName';
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      color: AppColors.fontColor,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      suggestions[index],
                                      style: const TextStyle(
                                        color: AppColors.fontColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  color: Colors.grey.shade300,
                                  height: 1,
                                ),
                              ],
                            ),
                          ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
