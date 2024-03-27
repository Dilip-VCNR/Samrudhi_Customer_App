import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/dashboard/models/notifications_response_model.dart';
import 'package:samruddhi/dashboard/providers/dashboard_provider.dart';

import '../../../utils/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.fontColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Consumer(
        builder: (BuildContext context, DashboardProvider dashboardProvider,
            Widget? child) {
          return FutureBuilder(
            future: dashboardProvider.getNotifications(),
            builder: (BuildContext context,
                AsyncSnapshot<NotificationsResponseModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < snapshot.data!.result!.length; i++)
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.result![i].notifications!.length,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '#${snapshot.data!.result![i].orderId}',
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors.fontColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.60,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: screenSize.width*.8,
                                                    child: Text(
                                                      '${snapshot.data!.result![i].notifications![index].notificationMessage}',
                                                      style: const TextStyle(
                                                        color: AppColors.fontColor,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5,),
                                                  SizedBox(
                                                    width: screenSize.width*.7,
                                                    child: Text(
                                                      '${snapshot.data!.result![i].notifications![index].notificationDate} ${snapshot.data!.result![i].notifications![index].notificationTime}',
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              // const CircleAvatar(
                                              //   backgroundColor:
                                              //       AppColors.primaryColor,
                                              //   child: Icon(
                                              //     Icons.call,
                                              //     color: Colors.white,
                                              //   ),
                                              // )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey.shade300,
                                          height: 1,
                                        ),
                                      ],
                                    )),
                        ],
                      )));
            },
          );
        },
      ),
    );
  }
}
