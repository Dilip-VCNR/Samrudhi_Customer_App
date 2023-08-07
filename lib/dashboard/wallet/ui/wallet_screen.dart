import 'package:flutter/material.dart';
import 'package:samruddhi/utils/app_colors.dart';

import '../../../utils/routes.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
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
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: ShapeDecoration(
                color: AppColors.walletBg,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Available reward points',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.walletFont,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '10,967',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1B8902),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Total earned',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1B8902),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '19,967',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1B8902),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Total Orders',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1B8902),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '17',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF1B8902),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.redeemPointsOperatorRoute);
              },
              child: Container(
                width: screenSize.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Claim for operator bill payment',
                          style: TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 212,
                          child: Text(
                            'You can claim your wallet points against operator bill payment',
                            style: TextStyle(
                              color: AppColors.fontColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
              ),
            ),
            Container(
              width: screenSize.width,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.all(20),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Redeem points on shopping',
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 212,
                        child: Text(
                          'You can redeem your wallet points on shopping in app (Min order value should be ₹500)',
                          style: TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  Icon(Icons.arrow_forward)
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'History',
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: screenSize.width,
              padding: const EdgeInsets.all(20),
              decoration: ShapeDecoration(
                color: AppColors.creditBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '300 points credited for',
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Order #36',
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'August 27, 2023 4:50 AM',
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  Icon(
                    Icons.navigate_next_rounded,
                    size: 40,
                    color: AppColors.fontColor,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: screenSize.width,
              padding: const EdgeInsets.all(20),
              decoration: ShapeDecoration(
                color: AppColors.debitBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '300 points credited for',
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Order #36',
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'August 27, 2023 4:50 AM',
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  Icon(
                    Icons.navigate_next_rounded,
                    size: 40,
                    color: AppColors.fontColor,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
