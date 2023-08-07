import 'package:flutter/material.dart';
import 'package:samruddhi/utils/routes.dart';

import '../../../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              icon: const Icon(Icons.notifications_none_outlined))
        ],
        title: const Text(
          'Hi John Doe',
          style: TextStyle(
            color: AppColors.fontColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.selectAddressRoute,
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
                          'Your Location',
                          style: TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 11,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width / 1.6,
                          child: const Text(
                            '#11, First floor vcnr Hospital,Bangal..',
                            style: TextStyle(
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
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
                                borderRadius: BorderRadius.circular(31.03),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  mainAxisSpacing: 4.0, // Vertical spacing between rows
                  crossAxisSpacing: 4.0, // Horizontal spacing between columns
                ),
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      Navigator.pushNamed(context, Routes.searchScreenRoute,
                          arguments: {'searchQuery': 'Fruits'});
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: const ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/70x70"),
                                fit: BoxFit.fill,
                              ),
                              shape: OvalBorder(),
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Fruits',
                            style: TextStyle(
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
                  itemCount: 5,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.storeInRoute);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
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
                      )),
            )
          ],
        ),
      ),
    );
  }

  void onAddressChanged(String newAddress) {
    // Your logic to handle the changed address
    print(newAddress);
  }
}
