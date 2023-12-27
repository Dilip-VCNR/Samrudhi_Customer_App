import 'package:flutter/material.dart';
import '../../api_calls.dart';
import '../../utils/routes.dart';

class SplashController {
  moveToCorrespondingScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
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
  }
}
