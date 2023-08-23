import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:samruddhi/auth/controller/auth_controller.dart';
import 'package:samruddhi/auth/model/login_response_model.dart';

import '../../database/app_pref.dart';
import '../../database/models/pref_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/routes.dart';
import '../../utils/url_constants.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({Key? key}) : super(key: key);

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  TextEditingController searchController = TextEditingController();

  AuthController authController = AuthController();
  PrefModel prefModel = AppPref.getPref();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    final Function(Address) onAddressChanged =
        arguments['callBack'] as Function(Address);

    return Scaffold(
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
              currentPosition = await authController.getCurrentLocation();
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
                    textEditingController: searchController,
                    googleAPIKey: UrlConstant.googleApiKey,
                    debounceTime: 400,
                    countries: const ["In"],
                    isLatLngRequired: true,
                    getPlaceDetailWithLatLng: (prediction) async {
                      onAddressChanged(Address(
                        type: 'OnMap',
                        address: prediction.description,
                        lat: double.parse(prediction.lat!),
                        lng: double.parse(prediction.lng!)
                      ));
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
                itemCount: prefModel.userData!.address!.length,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    onAddressChanged(prefModel.userData!.address![index]);
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prefModel.userData!.address![index].type!,
                                style: const TextStyle(
                                  color: AppColors.fontColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.60,
                                ),
                              ),
                              Text(
                                prefModel.userData!.address![index].address!,
                                style: const TextStyle(
                                  color: AppColors.fontColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          const Row(
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
                                    Icons.delete_outline_outlined,
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
  }
}
