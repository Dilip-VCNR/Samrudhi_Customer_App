import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:provider/provider.dart';

import '../../auth/provider/auth_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/routes.dart';
import '../../utils/url_constants.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({Key? key}) : super(key: key);

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final Function(String) onAddressChanged =
        arguments['callBack'] as Function(String);

    return Consumer(
      builder: (BuildContext context, AuthProvider authProvider, Widget? child) {
        authProvider.selectAddressPageContext = context;
        return  Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBackground,
            title: const Text(
              'My Address',
              style: TextStyle(
                color: AppColors.fontColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          bottomNavigationBar: Container(
            width: screenSize.width,
            height: 100,
            padding: const EdgeInsets.all(20),
            child: InkWell(
              onTap: () async {
                Position currentPosition;
                try {
                  currentPosition = await authProvider.getCurrentLocation();
                } catch (e) {
                  currentPosition = const Position(
                    latitude: 10.1632,
                    longitude: 76.6413,
                    timestamp: null,
                    accuracy: 100,
                    altitude: 0,
                    heading: 0,
                    speed: 0,
                    speedAccuracy: 0,
                  );
                }
                if (context.mounted) {
                  Navigator.pushNamed(context, Routes.markLocationRoute,
                      arguments: {"currentLocation": currentPosition});
                }
              },
              child: Container(
                width: screenSize.width,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: ShapeDecoration(
                  color: AppColors.secondaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Center(
                  child: Text(
                    'Add new address',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Search address',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: screenSize.width,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: GooglePlacesAutoCompleteTextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        inputDecoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search a place',
                          counterText: "",
                          isCollapsed: true,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        textEditingController: authProvider.searchController,
                        googleAPIKey: UrlConstant.googleApiKey,
                        debounceTime: 400,
                        countries: const ["In"],
                        isLatLngRequired: true,
                        getPlaceDetailWithLatLng: (prediction) async {
                          onAddressChanged(prediction.toJson().toString());
                          Navigator.pop(context);
                        },
                        itmClick: (prediction) async {
                          FocusScope.of(context).unfocus();
                        }),
                  ),
                  const Text(
                    'Saved address',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        onAddressChanged("THis is saved address");
                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Home',
                                    style: TextStyle(
                                      color: AppColors.fontColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.60,
                                    ),
                                  ),
                                  Text(
                                    '11/1 b Jest building peenya..',
                                    style: TextStyle(
                                      color: AppColors.fontColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                      backgroundColor: AppColors.primaryColor,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
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
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
