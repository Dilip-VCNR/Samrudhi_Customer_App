import 'dart:async';

import 'package:flutter/material.dart';
import 'package:samruddhi/splash/controller/splash_controller.dart';

import '../../api_calls.dart';
import '../../utils/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = SplashController();

  @override
  Widget build(BuildContext context) {
    // splashController.moveToCorrespondingScreen(context);
    Timer(
        const Duration(seconds: 3),
            () {
              if (prefModel.userData == null) {
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                }
              } else {
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, Routes.dashboardRoute);
                }
              }
            });

    return const Scaffold(
      body: Center(
        child: Image(image: AssetImage('assets/images/logo.png')),
      ),
    );
  }
}
