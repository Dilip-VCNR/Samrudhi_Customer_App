import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:samruddhi/dashboard/models/store_data_model.dart';
import 'package:samruddhi/utils/url_constants.dart';
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
                Lottie.asset('assets/lottie/loading_delivery_boy.json',
                    height: 150),
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

Future<bool?> showWarningDialog(BuildContext context, String message) async {
  return await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Warning"),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text("Proceed"),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );
}

showProductDetailsModal(
    ProductList product, BuildContext context, Size screenSize) {
  return showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Product details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const Divider(),
              SizedBox(
                height: screenSize.width / 2,
                width: screenSize.width,
                child: Image(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(UrlConstant.imageBaseUrl +
                        product.productDetail!.productImgArray![0].imagePath!)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Product Name : ${product.productDetail!.productName!}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                  "Product Description : ${product.productDetail!.description!}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.normal)),
              Text('Selling Price : ₹${product.productDetail!.sellingPrice!}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.normal)),
              Text(
                  'Discount Percentage : ₹${product.productDetail!.productDiscount!}%',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.normal)),
              Text(
                  'Offer Price : ₹${product.productDetail!.productDiscountedValue!}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.normal)),
              Text("UOM : ${product.productDetail!.productUom!}"),
              Text(
                '${product.saveMessage}',
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        );
      });
}
