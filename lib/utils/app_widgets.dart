import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:toastification/toastification.dart';

import 'app_colors.dart';

showErrorToast(BuildContext context, String message) {
  toastification.show(
    style: ToastificationStyle.fillColored,
    type: ToastificationType.error,
    context: context,
    closeOnClick: true,
    title: message,
    autoCloseDuration: const Duration(seconds: 5),
  );
}

showSuccessToast(BuildContext context, String message) {
  toastification.show(
    style: ToastificationStyle.fillColored,
    type: ToastificationType.success,
    closeOnClick: true,
    context: context,
    title: message,
    autoCloseDuration: const Duration(seconds: 5),
  );
}

showLoaderDialog(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/loading_delivery_boy.json', height: 150),
            const Text(
              "Loading...",
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ));
}

showWarningDialog(BuildContext context, String message, {required Null Function() onPressed}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Warning'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onPressed();
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Proceed'),
          ),
        ],
      );
    },
  );
}