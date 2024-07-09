import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/dashboard/providers/dashboard_provider.dart';
import 'package:samruddhi/utils/url_constants.dart';

import '../../../utils/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List suggestions = ["Rice", "Bread", "Biscuits", "Apple", "green peas"];
  bool firstTimeLoading = false;
  Timer? _debounce;

  final Map<String, String> searchTypes = {
    'productCategory': 'Product Category',
    'productName': 'Product Name',
    'store': 'Store'
  };

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Consumer<DashboardProvider>(
      builder: (BuildContext context, DashboardProvider dashboardProvider,
          Widget? child) {
        if (firstTimeLoading != true &&
            dashboardProvider.searchKeyWord != null &&
            dashboardProvider.searchKeyWord != '') {
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
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        'Search Keyword',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      )),
                  TextField(
                    onChanged: (query) {
                      if (_debounce?.isActive ?? false) _debounce!.cancel();
                      _debounce = Timer(const Duration(milliseconds: 1000), () {
                        setState(() {
                          firstTimeLoading = false;
                          dashboardProvider.searchKeyWord = query;
                        });
                      });
                    },
                    autofocus:
                        dashboardProvider.searchKeyWord == null ? true : false,
                    controller: dashboardProvider.searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search',
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
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        'Search Type',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      )),
                  DropdownButtonFormField<String>(
                    value: dashboardProvider.searchType,
                    style: const TextStyle(color: AppColors.fontColor),
                    onChanged: (String? newValue) {
                      setState(() {
                        firstTimeLoading = false;
                        dashboardProvider.searchType = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.inputFieldColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 10.0),
                    ),
                    items: searchTypes.entries
                        .map<DropdownMenuItem<String>>((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (dashboardProvider.searchKeyWord != null &&
                      dashboardProvider.searchKeyWord != "" &&
                      dashboardProvider.searchResponse != null)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dashboardProvider.searchType == 'store'
                              ? 'Search results for ${dashboardProvider.searchKeyWord}'
                              : 'Stores with ${dashboardProvider.searchKeyWord}',
                          style: const TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        dashboardProvider.searchResponse!.result!.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: dashboardProvider
                                    .searchResponse!.result!.length,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: () {
                                        dashboardProvider.getIntoStore(
                                            dashboardProvider
                                                .searchResponse!.result![index],
                                            dashboardProvider.searchKeyWord!);
                                        // Navigator.pushNamed(
                                        //     context, Routes.storeInRoute);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
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
                                              width: screenSize.width * .25,
                                              height: 125,
                                              decoration: ShapeDecoration(
                                                color: Colors.grey,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      '${UrlConstant.imageBaseUrl}${dashboardProvider.searchResponse!.result![index].storeImgArray![0].imageUrl}'),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
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
                                                  width: screenSize.width * .55,
                                                  child: Text(
                                                    '${dashboardProvider.searchResponse!.result![index].displayName}',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.55,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      height: 1.25,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      screenSize.width / 1.75,
                                                  child: Text(
                                                    '${dashboardProvider.searchResponse!.result![index].storeCategoryName}',
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors.fontColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                SizedBox(
                                                  width:
                                                      screenSize.width / 1.75,
                                                  child: Text(
                                                    '${dashboardProvider.searchResponse!.result![index].addressArray!.completeAddress} ${dashboardProvider.searchResponse!.result![index].addressArray!.completeAddress}',
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors.fontColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(
                                                  width:
                                                      screenSize.width / 1.75,
                                                  child: Text(
                                                    dashboardProvider
                                                            .searchResponse!
                                                            .result![index]
                                                            .isHomeDelivery!
                                                        ? 'Home delivery'
                                                        : 'Self Pickup',
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors.fontColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: const Center(
                                    child: Text("No results to display")))
                      ],
                    )
                  else
                    const Center(
                      child: Text("No results to display"),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
