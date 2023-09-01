import 'package:flutter/material.dart';
import 'package:samruddhi/dashboard/home/controller/home_controller.dart';
import 'package:samruddhi/dashboard/home/model/stores_on_category_model.dart';
import 'package:samruddhi/utils/app_widgets.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/routes.dart';
import '../../../utils/url_constants.dart';
import '../model/in_store_data_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List suggestions = ["Rice", "Bread", "Biscuits", "Apple", "green peas"];
  TextEditingController searchController = TextEditingController();
  bool? isLoaded;
  late Future<StoresOnSearchModel> storesData;

  HomeController homeController = HomeController();
  Map? arguments;

  @override
  Widget build(BuildContext context) {
    if (isLoaded != true) {
      arguments = (ModalRoute.of(context)?.settings.arguments ??
          <String, dynamic>{}) as Map;
      storesData = homeController.getStoresOnSearch(context, arguments!);
      isLoaded = true;
    }

    var screenSize = MediaQuery.of(context).size;
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              TextField(
                onChanged: (query) {
                  if (query.isNotEmpty || query != "") {
                    setState(() {
                      arguments!['searchKeyWord'] = query;
                      storesData =
                          homeController.getStoresOnSearch(context, arguments!);
                    });
                  } else {
                    setState(() {
                      arguments!['searchKeyWord'] = null;
                    });
                  }
                },
                autofocus:
                    arguments!['searchType'] == 'productName' ? true : false,
                controller: searchController,
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
                  contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                textAlignVertical: TextAlignVertical.center,
              ),
              FutureBuilder(
                  future: storesData,
                  builder: (BuildContext context,
                      AsyncSnapshot<StoresOnSearchModel?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        margin: const EdgeInsets.all(20),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          if (arguments!['searchKeyWord'] != null &&
                              arguments!['searchKeyWord'] != "")
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Stores with ${arguments!['searchKeyWord']}',
                                  style: const TextStyle(
                                    color: AppColors.fontColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                snapshot.data!.result!.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            snapshot.data!.result!.length,
                                        scrollDirection: Axis.vertical,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            GestureDetector(
                                              onTap: () async {
                                                showLoaderDialog(context);
                                                InStoreDataModel inStoreData =
                                                    await homeController
                                                        .getInStoreData(
                                                            snapshot
                                                                .data!
                                                                .result![index]
                                                                .storeId,
                                                            context);
                                                if (context.mounted) {
                                                  Navigator.pop(context);
                                                  if (inStoreData.statusCode ==
                                                      200) {
                                                    Navigator.pushNamed(context,
                                                        Routes.storeInRoute,
                                                        arguments: {
                                                          "inStoreData":
                                                              inStoreData,
                                                          "searchQuery":
                                                              arguments![
                                                                  'searchKeyWord']
                                                        });
                                                  } else {
                                                    showErrorToast(context,
                                                        inStoreData.message!);
                                                  }
                                                }
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                width: screenSize.width,
                                                decoration: ShapeDecoration(
                                                  color:
                                                      AppColors.storeBackground,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.52),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 125,
                                                      height: 130,
                                                      decoration:
                                                          ShapeDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              UrlConstant
                                                                      .imageBaseUrl +
                                                                  snapshot
                                                                      .data!
                                                                      .result![
                                                                          index]
                                                                      .image!),
                                                          fit: BoxFit.fill,
                                                        ),
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15.50),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15.50),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          snapshot
                                                              .data!
                                                              .result![index]
                                                              .displayName!,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16.55,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            height: 1.25,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 212,
                                                          child: Text(
                                                            snapshot
                                                                .data!
                                                                .result![index]
                                                                .storeCategory!,
                                                            style:
                                                                const TextStyle(
                                                              color: AppColors
                                                                  .fontColor,
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 3,
                                                        ),
                                                        SizedBox(
                                                          width: 212,
                                                          child: Text(
                                                            "${snapshot.data!.result![index].address!.address!} ${snapshot.data!.result![index].address!.city!} ${snapshot.data!.result![index].address!.zipCode!}",
                                                            style:
                                                                const TextStyle(
                                                              color: AppColors
                                                                  .fontColor,
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 4),
                                                          decoration:
                                                              ShapeDecoration(
                                                            color: Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          31.03),
                                                            ),
                                                          ),
                                                          child: const Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Browse ',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      12.41,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  height: 1.33,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 4.14),
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
                                            ))
                                    : Container(
                                        margin: const EdgeInsets.all(20),
                                        child: Center(
                                            child: Text(
                                          "No Stores are delivering ${arguments!['searchKeyWord']} currently",
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        )))
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
                                        searchController.text =
                                            suggestions[index];
                                        arguments!['searchKeyWord'] =
                                            suggestions[index];
                                      });
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
