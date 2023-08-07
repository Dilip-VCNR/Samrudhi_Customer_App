import 'package:flutter/material.dart';

import '../../database/app_pref.dart';
import '../../database/models/pref_model.dart';
import '../../utils/routes.dart';

class SplashController {
  moveToCorrespondingScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      PrefModel prefModel = AppPref.getPref();
      if (prefModel.uid == null) {
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
