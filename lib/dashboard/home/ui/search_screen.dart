import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/routes.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List suggestions = ["Rice", "Bread", "Biscuits", "Apple", "green peas"];
  String? searchKeyword;
  TextEditingController searchController = TextEditingController();
  bool? isLoaded;

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    if (isLoaded != true) {
      searchKeyword = arguments['searchQuery'];
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
                    searchKeyword = query;
                  });
                },
                autofocus: searchKeyword == null ? true : false,
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
              const SizedBox(
                height: 20,
              ),
              if (searchKeyword != null && searchKeyword != "")
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stores with $searchKeyword',
                      style: const TextStyle(
                        color: AppColors.fontColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.storeInRoute);
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          'Vinayaka Provision stores',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.55,
                                            fontWeight: FontWeight.bold,
                                            height: 1.25,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 212,
                                          child: Text(
                                            'Groceries and shopping',
                                            style: TextStyle(
                                              color: AppColors.fontColor,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        const SizedBox(
                                          width: 212,
                                          child: Text(
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
                            searchController.text = suggestions[index];
                            searchKeyword = suggestions[index];
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
  }
}
