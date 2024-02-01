import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/utils/app_colors.dart';

import '../provider/wallet_provider.dart';

class WalletScreen extends StatefulWidget {
  final Function(int) changeScreen;

  const WalletScreen({Key? key,required this.changeScreen}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool firstTimeLoading = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder: (BuildContext context, WalletProvider walletProvider, Widget? child) {
        walletProvider.walletScreenContext =  context;
        if(firstTimeLoading!=true){
          walletProvider.getWalletData();
          firstTimeLoading = true;
        }
        return Scaffold(
          body: walletProvider.walletResponse!=null?SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenSize.width,
                  height: screenSize.height / 5,
                  decoration: const ShapeDecoration(
                    color: AppColors.storeBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'The Wallet',
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 212,
                        child: Text(
                          'Rewards from your purchases and referrals appear here',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: screenSize.width,
                  margin: const EdgeInsets.only(top: 20, left: 20,right: 20),
                  decoration: ShapeDecoration(
                    color: AppColors.walletBg,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenSize.width/2.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Points earned',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF1B8902),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${walletProvider.walletResponse!.result!.totalEarnedPoints!}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF1B8902),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width/2.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Points Value',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF1B8902),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${walletProvider.walletResponse!.result!.totalAvailableRedeemPointsValue}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF1B8902),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenSize.width/2.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Redeemable',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF1B8902),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${walletProvider.walletResponse!.result!.totalAvailableRedeemPoints}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF1B8902),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width/2.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Redeemed',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF1B8902),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${walletProvider.walletResponse!.result!.redeemPoints!}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF1B8902),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.pushNamed(context, Routes.redeemPointsOperatorRoute);
                //   },
                //   child: Container(
                //     width: screenSize.width,
                //     margin: const EdgeInsets.symmetric(horizontal: 20),
                //     padding: const EdgeInsets.all(20),
                //     decoration: ShapeDecoration(
                //       color: Colors.white,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       shadows: const [
                //         BoxShadow(
                //           color: Color(0x3F000000),
                //           blurRadius: 4,
                //           offset: Offset(0, 4),
                //           spreadRadius: 0,
                //         )
                //       ],
                //     ),
                //     child: const Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Column(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               'Claim for operator bill payment',
                //               style: TextStyle(
                //                 color: AppColors.fontColor,
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //             ),
                //             SizedBox(
                //               width: 212,
                //               child: Text(
                //                 'You can claim your wallet points against operator bill payment',
                //                 style: TextStyle(
                //                   color: AppColors.fontColor,
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //         Icon(Icons.arrow_forward)
                //       ],
                //     ),
                //   ),
                // ),
                // GestureDetector(
                //   onTap: (){
                //     widget.changeScreen(0);
                //   },
                //   child: Container(
                //     width: screenSize.width,
                //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                //     padding: const EdgeInsets.all(20),
                //     decoration: ShapeDecoration(
                //       color: Colors.white,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10),
                //       ),
                //       shadows: const [
                //         BoxShadow(
                //           color: Color(0x3F000000),
                //           blurRadius: 4,
                //           offset: Offset(0, 4),
                //           spreadRadius: 0,
                //         )
                //       ],
                //     ),
                //     child: const Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Column(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               'Redeem points on shopping',
                //               style: TextStyle(
                //                 color: AppColors.fontColor,
                //                 fontSize: 14,
                //                 fontWeight: FontWeight.w600,
                //               ),
                //             ),
                //             SizedBox(
                //               width: 212,
                //               child: Text(
                //                 'You can redeem your wallet points on shopping in app (Min order value should be ₹500)',
                //                 style: TextStyle(
                //                   color: AppColors.fontColor,
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //         Icon(Icons.arrow_forward)
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Earn History',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                if (walletProvider.walletResponse!.result!.earnedPointsDetails!.isNotEmpty) ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: walletProvider.walletResponse!.result!.earnedPointsDetails!.length,
                  itemBuilder: (BuildContext context,int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: screenSize.width,
                      padding: const EdgeInsets.all(20),
                      decoration: ShapeDecoration(
                        color: AppColors.debitBg,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${walletProvider.walletResponse!.result!.earnedPointsDetails![index].earnedpoint} points credited for',
                                style: const TextStyle(
                                  color: AppColors.fontColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Order #${walletProvider.walletResponse!.result!.earnedPointsDetails![index].orderId}',
                                style: const TextStyle(
                                  color: AppColors.fontColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${walletProvider.walletResponse!.result!.earnedPointsDetails![index].date}',
                                style: const TextStyle(
                                  color: AppColors.fontColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          const Icon(
                            Icons.navigate_next_rounded,
                            size: 40,
                            color: AppColors.fontColor,
                          )
                        ],
                      ),
                    );
                  }, separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10,);
                },
                ) else const Center(child: Text("No records found"),),

                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Redeem History',
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
                walletProvider.walletResponse!.result!.redeemPointsDetails!.isNotEmpty?ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: walletProvider.walletResponse!.result!.redeemPointsDetails!.length,
                    itemBuilder: (BuildContext context,int index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: screenSize.width,
                        padding: const EdgeInsets.all(20),
                        decoration: ShapeDecoration(
                          color: AppColors.creditBg,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${walletProvider.walletResponse!.result!.redeemPointsDetails![index].earnedpoint} points credited for',
                                  style: const TextStyle(
                                    color: AppColors.fontColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'Order #${walletProvider.walletResponse!.result!.redeemPointsDetails![index].orderId}',
                                  style: const TextStyle(
                                    color: AppColors.fontColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${walletProvider.walletResponse!.result!.redeemPointsDetails![index].date}',
                                  style: const TextStyle(
                                    color: AppColors.fontColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            const Icon(
                              Icons.navigate_next_rounded,
                              size: 40,
                              color: AppColors.fontColor,
                            )
                          ],
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10,);
                },
                ):const Center(child: Text("No records found"),),
              ],
            ),
          ):const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
