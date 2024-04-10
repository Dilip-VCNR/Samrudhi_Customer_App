import 'package:flutter/material.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/auth/models/login_response_model.dart';
import 'package:samruddhi/dashboard/orders/models/deliverable_address_model.dart';
import 'package:samruddhi/dashboard/providers/dashboard_provider.dart';
import 'package:samruddhi/database/app_pref.dart';
import 'package:samruddhi/utils/app_widgets.dart';

import '../../auth/provider/auth_provider.dart';
import '../../utils/app_colors.dart';
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
    DeliverableAddressModel? deliverableAddress =
        arguments['deliverableAddress'];

    return Consumer(
      builder: (BuildContext context, DashboardProvider dashboardProvider,
          Widget? child) {
        dashboardProvider.selectAddressPageContext = context;
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
          bottomNavigationBar: Consumer(
            builder: (BuildContext context, AuthProvider authProvider,
                Widget? child) {
              authProvider.selectAddressPageContext = context;
              return Container(
                width: screenSize.width,
                height: 100,
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: () async {
                    await authProvider.getApproxLocationForAdd();
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
              );
            },
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
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
                        textEditingController:
                            dashboardProvider.addressSearchController,
                        googleAPIKey: UrlConstant.googleApiKey,
                        debounceTime: 100,
                        countries: const ["In"],
                        isLatLngRequired: true,
                        getPlaceDetailWithLatLng: (prediction) async {
                          prefModel.selectedAddress = UserAddressArray(
                              lat: double.parse(prediction.lat!),
                              lng: double.parse(prediction.lng!),
                              completeAddress: prediction.description);
                          AppPref.setPref(prefModel);
                          dashboardProvider.getHomeData();
                          dashboardProvider.addressSearchController.clear();
                          showSuccessToast(
                              context, "Location changed successfully");
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
                  prefModel.userData!.addressArray!.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: prefModel.userData!.addressArray!.length,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return !prefModel
                                    .userData!.addressArray![index].isDeleted!
                                ? InkWell(
                                    onTap: () {
                                      if (deliverableAddress != null) {
                                        if (deliverableAddress.result!.contains(
                                            prefModel.userData!
                                                .addressArray![index].id)) {
                                          dashboardProvider.setDeliveryAddress(
                                              prefModel.userData!
                                                  .addressArray![index]);
                                        } else {
                                          showErrorToast(context,
                                              "This address is not eligible for delivery for this store");
                                        }
                                      } else {
                                        prefModel.selectedAddress = prefModel
                                            .userData!.addressArray![index];
                                        AppPref.setPref(prefModel);
                                        showSuccessToast(context,
                                            "Address selected successfully");
                                        dashboardProvider.getHomeData();
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  prefModel
                                                      .userData!
                                                      .addressArray![index]
                                                      .addressType!,
                                                  style: const TextStyle(
                                                    color: AppColors.fontColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 0.60,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: screenSize.width / 1.5,
                                                  child: Text(
                                                    '${prefModel.userData!.addressArray![index].completeAddress}',
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors.fontColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    prefModel
                                                                .userData!
                                                                .addressArray!
                                                                .length !=
                                                            1
                                                        ? showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    'Are you sure ?'),
                                                                content: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        'Are you sure you want to delete ${prefModel.userData!.addressArray![index].addressType} address?'),
                                                                    Text(
                                                                        '${prefModel.userData!.addressArray![index].completeAddress}'),
                                                                  ],
                                                                ),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                    child:
                                                                        const Text(
                                                                            'No'),
                                                                    onPressed:
                                                                        () async {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                  TextButton(
                                                                    child: const Text(
                                                                        'Yes'),
                                                                    onPressed:
                                                                        () async {
                                                                      await dashboardProvider.deleteUserAddress(
                                                                          prefModel
                                                                              .userData!
                                                                              .addressArray![index]
                                                                              .id,
                                                                          index);
                                                                      if (context
                                                                          .mounted) {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      }
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            })
                                                        : showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    'Cannot delete !'),
                                                                content:
                                                                    const Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        'At least one address mandatory.'),
                                                                  ],
                                                                ),
                                                                actions: <Widget>[
                                                                  TextButton(
                                                                    child:
                                                                        const Text(
                                                                            'OK'),
                                                                    onPressed:
                                                                        () async {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                  },
                                                  child: const CircleAvatar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                      )),
                                                )
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
                                  )
                                : const SizedBox.shrink();
                          },
                        )
                      : const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("No saved address to display."),
                          ),
                        ),
                ],
              )),
        );
      },
    );
  }
}
