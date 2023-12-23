import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:samruddhi/address/controller/location_controller.dart';
import 'package:samruddhi/auth/controller/auth_controller.dart';
import 'package:samruddhi/auth/model/register_request_model.dart';
import 'package:samruddhi/utils/app_colors.dart';
import 'package:samruddhi/utils/app_widgets.dart';
import 'package:samruddhi/utils/url_constants.dart';

class PrimaryLocation extends StatefulWidget {
  const PrimaryLocation({Key? key}) : super(key: key);

  @override
  State<PrimaryLocation> createState() => _PrimaryLocationState();
}

class _PrimaryLocationState extends State<PrimaryLocation> {
  GoogleMapController? mapController;
  ValueNotifier<CameraPosition>? cameraPositionNotifier;
  String location = "Search location";

  LocationController locationController = LocationController();

  TextEditingController searchController = TextEditingController();
  RegisterRequestModel? userDetails;
  AuthController authController = AuthController();

  @override
  void dispose() {
    cameraPositionNotifier!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    Position currentLocation = arguments['currentLocation'];
    userDetails = arguments['userDetails'];
    cameraPositionNotifier = ValueNotifier<CameraPosition>(CameraPosition(
        target: LatLng(arguments['currentLocation'].latitude,
            arguments['currentLocation'].longitude),
        zoom: 14.0));
    var screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Set Primary Location',
            style: TextStyle(
              color: AppColors.fontColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        floatingActionButton: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              backgroundColor: Colors.white,
              onPressed: () {
                FocusScope.of(context).unfocus();
                searchController.clear();
                mapController?.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(currentLocation.latitude,
                            currentLocation.longitude),
                        zoom: 17.0),
                  ),
                );
              },
              label: const Text(
                "Use current location",
                style: TextStyle(color: Colors.black),
              ),
              icon: const Icon(
                Icons.my_location,
                color: Colors.black,
              ),
            )),
        body: Stack(
          children: [
            GoogleMap(
              myLocationButtonEnabled: true,
              zoomGesturesEnabled: true,
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(currentLocation.latitude, currentLocation.longitude),
                zoom: 17.0,
              ),
              mapType: MapType.normal,
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              onCameraMove: (position) {
                cameraPositionNotifier!.value = position;
              },
            ),
            const Center(
                child: Icon(Icons.location_pin,
                    color: AppColors.primaryColor, size: 50)),
            Positioned(
                top: 10,
                child: Container(
                  width: screenSize.width,
                  padding: const EdgeInsets.all(20),
                  child: GooglePlacesAutoCompleteTextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      inputDecoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: InkWell(
                            onTap: () {
                              searchController.clear();
                            },
                            child: const Icon(Icons.clear)),
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
                      debounceTime: 100,
                      countries: const ["In"],
                      isLatLngRequired: true,
                      getPlaceDetailWithLatLng: (prediction) async {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          location =
                              prediction.description ?? "Search location";
                        });
                        var newLatLng = LatLng(double.parse(prediction.lat!),
                            double.parse(prediction.lng!));

                        mapController?.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(target: newLatLng, zoom: 17),
                          ),
                        );
                      },
                      itmClick: (prediction) async {
                        searchController.text = prediction.description!;
                        searchController.selection = TextSelection.fromPosition(
                            TextPosition(
                                offset: prediction.description!.length));
                      }),
                ))
          ],
        ),
        bottomNavigationBar: _buildMapConfirmationBar(screenSize, arguments),
      ),
    );
  }

  Widget _buildMapConfirmationBar(
      Size screenSize, Map<dynamic, dynamic> arguments) {
    return ValueListenableBuilder<CameraPosition>(
      valueListenable: cameraPositionNotifier!,
      builder: (context, cameraPosition, _) {
        return FutureBuilder<Map<String, dynamic>>(
          future:
              locationController.getAddressFromLatLong(cameraPosition.target),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: screenSize.height / 6,
                width: screenSize.width,
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasData) {
              return Container(
                  padding: const EdgeInsets.all(20),
                  width: screenSize.width,
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            size: 40,
                            color: AppColors.primaryColor,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!['subLocality'] != ""
                                    ? snapshot.data!['subLocality']
                                    : snapshot.data!['name'].toString(),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                  width: screenSize.width / 2,
                                  child: Text(
                                    snapshot.data!['locality'],
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  )),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          showInputCompleteAddressModal(context, snapshot.data!,
                              cameraPosition.target, arguments);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 13.0),
                          decoration: const BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Enter full address',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ));
            } else {
              return Container(
                width: screenSize.width,
                height: screenSize.height / 4,
                color: Colors.white,
                child: const Center(
                  child: Text(
                    'Error retrieving location',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  showInputCompleteAddressModal(
      BuildContext context,
      Map<String, dynamic> locationData,
      LatLng target,
      Map<dynamic, dynamic> arguments) {
    final formKey = GlobalKey<FormState>();

    TextEditingController addressController = TextEditingController();
    TextEditingController stateController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController postalCodeController = TextEditingController();
    postalCodeController.text = locationData['postalCode'].toString();
    stateController.text = locationData['administrativeArea'].toString();
    cityController.text = locationData['subAdministrativeArea'].toString();
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Enter address details",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.close))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 100,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColors.walletBg,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                      child: Text(
                        "Primary",
                        style: TextStyle(color: AppColors.walletFont),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: addressController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter complete address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.line_weight),
                      hintText: 'Complete address',
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
                  TextFormField(
                    controller: stateController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your state';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.countertops_outlined),
                      hintText: 'State',
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
                  TextFormField(
                    controller: cityController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_city),
                      hintText: 'City',
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
                  TextFormField(
                    controller: postalCodeController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your postal code';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.pin_drop),
                      hintText: 'Postal Code',
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
                  GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        showLoaderDialog(context);
                        userDetails!.addressType = 'Primary';
                        userDetails!.completeAddress = addressController.text;
                        userDetails!.city = cityController.text;
                        userDetails!.state = stateController.text;
                        userDetails!.zipCode = int.parse(postalCodeController.text);
                        userDetails!.lat = target.latitude;
                        userDetails!.lng = target.longitude;
                        await authController.registerUser(context, userDetails);
                      }
                      return;
                    },
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      decoration: const BoxDecoration(
                        color: AppColors.secondaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ],
                      ),
                    ),
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
