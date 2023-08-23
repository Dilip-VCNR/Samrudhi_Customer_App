import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:samruddhi/auth/model/register_request_model.dart';
import 'package:samruddhi/network/api_calls.dart';

import '../../database/app_pref.dart';
import '../../database/models/pref_model.dart';
import '../../utils/app_widgets.dart';
import '../../utils/routes.dart';
import '../model/login_response_model.dart';

class AuthController {
  ApiCalls apiCalls = ApiCalls();
  PrefModel prefModel = AppPref.getPref();

  bool isNotValidEmail(String email) {
    const emailRegex =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,})$';
    final regExp = RegExp(emailRegex);
    return !regExp.hasMatch(email);
  }

  bool isNotValidPhone(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return true;
    }
    if (phoneNumber.length != 10 || !isNumeric(phoneNumber)) {
      return true;
    }
    return false;
  }

  bool isNumeric(String? str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  bool isNotValidName(String name) {
    const nameRegex = r'^[a-zA-Z\s]+$';
    final regExp = RegExp(nameRegex);
    if (!regExp.hasMatch(name)) {
      return true;
    }
    final containsNumbers = name.contains(RegExp(r'[0-9]'));
    return containsNumbers;
  }

  bool? serviceEnabled;
  LocationPermission? permission;

  Future<Position> getCurrentLocation() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  Future<void> loginWithPhoneNumber(BuildContext context, String phoneNumber,
      String? selectedCountryCode) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$selectedCountryCode $phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        Navigator.pop(context);
        showErrorToast(context, "Something Went Wrong!\n$e");
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.otpScreenRoute, arguments: {
          'verificationId': verificationId,
          'phone': phoneNumber,
          'selectedCountryCode': selectedCountryCode,
        });
        showSuccessToast(
            context, "OTP is sent to $selectedCountryCode $phoneNumber");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyOTPCode(BuildContext context, String verificationCode,
      String? verificationId, String phone, String countryCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: verificationCode,
    );
    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        await apiCallForUserDetails(
            context, value.user?.uid, phone, countryCode);
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorToast(
        context,
        "Oops !You have entered a wrong OTP $e",
      );
    }
  }

  Future<void> resendOtp(BuildContext context, String phone, String countryCode,
      Size screenSize) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$countryCode $phone',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        Navigator.pop(context);
        showErrorToast(context, "Something Went Wrong.$e");
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pop(context);
        showSuccessToast(context, "OTP is sent to $countryCode $phone");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  apiCallForUserDetails(BuildContext context, String? uid, String phone,
      String countryCode) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    LoginResponseModel userDetails =
        await apiCalls.getUserDetails(uid, fcmToken);
    if (userDetails.statusCode == 200) {
      prefModel.userData = userDetails.result;
      await AppPref.setPref(prefModel);
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, Routes.dashboardRoute);
      }
    } else if (userDetails.statusCode == 400) {
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pushNamed(context, Routes.registerRoute, arguments: {
          'phone': phone,
          'countryCode': countryCode,
          'uid': uid
        });
      }
    } else {
      if (context.mounted) {
        Navigator.pop(context);
        showErrorToast(context, "${userDetails.message}");
      }
    }
  }

  registerUser(
      BuildContext context, RegisterRequestModel? userDetailsRequest) async {
    LoginResponseModel userDetails =
        await apiCalls.registerUser(userDetailsRequest!);
    if (userDetails.statusCode == 200) {
      prefModel.userData = userDetails.result;
      await AppPref.setPref(prefModel);
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.dashboardRoute, (route) => false);
      }
    } else if (userDetails.statusCode == 400) {
      if (context.mounted) {
        Navigator.pop(context);
        showErrorToast(context, "${userDetails.message}");
      }
    } else {
      if (context.mounted) {
        Navigator.pop(context);
        showErrorToast(context, "${userDetails.message}");
      }
    }
  }
}
