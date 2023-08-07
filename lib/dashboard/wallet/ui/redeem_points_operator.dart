import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class RedeemPointsOperator extends StatefulWidget {
  const RedeemPointsOperator({Key? key}) : super(key: key);

  @override
  State<RedeemPointsOperator> createState() => _RedeemPointsOperatorState();
}

class _RedeemPointsOperatorState extends State<RedeemPointsOperator> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldBackground,
        title: const Text(
          'Operator bill payment',
          style: TextStyle(
            color: AppColors.fontColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'My Active plan',
                style: TextStyle(
                  color: AppColors.fontColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.60,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Super Malayalam regional +\nGeneral sports pack',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.60,
                    ),
                  ),
                  Text(
                    '₹422',
                    style: TextStyle(
                      color: Color(0xFFF37A20),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: screenSize.width,
                padding: const EdgeInsets.all(20),
                decoration: ShapeDecoration(
                  color: AppColors.creditBg,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'You have 1200 points in wallet \neligible to redeem',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Redeem Now !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1B8902),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.60,
                    ),
                  ),
                  Text(
                    '₹422',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.60,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Taxes',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.60,
                    ),
                  ),
                  Text(
                    '₹20',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.60,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gateway charges',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.60,
                    ),
                  ),
                  Text(
                    '₹10',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.60,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Wallet points redemption',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.60,
                    ),
                  ),
                  Text(
                    '-₹110',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.60,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.60,
                    ),
                  ),
                  Text(
                    '₹342',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.fontColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.60,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Payment Method',
                style: TextStyle(
                  color: AppColors.fontColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.60,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: 75,
                    height: 75,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image:
                            NetworkImage("https://via.placeholder.com/50x50"),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 3,
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: 75,
                    height: 75,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image:
                            NetworkImage("https://via.placeholder.com/50x50"),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 3,
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: 75,
                    height: 75,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image:
                            NetworkImage("https://via.placeholder.com/50x50"),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 3,
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {},
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
                      'Pay now',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
