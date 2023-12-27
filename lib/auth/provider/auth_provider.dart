import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../database/app_pref.dart';
import '../../utils/app_widgets.dart';
import '../../utils/routes.dart';
import '../models/login_response_model.dart';

class AuthProvider extends ChangeNotifier {

  ApiCalls apiCalls = ApiCalls();
  String? verificationIdValue;

  // Login Page declarations
  int currentSlideIndex = 0;
  TextEditingController phoneNumberController = TextEditingController();
  String? selectedCountryCode = "+91";
  final loginFormKey = GlobalKey<FormState>();
  BuildContext? loginPageContext;

  // register page declarations
  bool termsAndConditionsIsChecked = false;
  final registerFormKey = GlobalKey<FormState>();
  BuildContext? registerPageContext;

  // otp screen declarations
  CountdownController countdownController =
      CountdownController(autoStart: true);
  int seconds = 30;
  bool firstStateEnabled = false;
  String otpCode = "";
  BuildContext? otpScreenContext;

  // select address declarations
  TextEditingController searchController = TextEditingController();
  BuildContext? selectAddressPageContext;

  bool isNotValidEmail(String email) {
    const emailRegex =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,})$';
    final regExp = RegExp(emailRegex);
    return !regExp.hasMatch(email);
  }

  bool isNotValidName(String name) {
    // Regular expression pattern to validate name format
    const nameRegex = r'^[a-zA-Z\s]+$';

    // Use RegExp to check if the name matches the pattern
    final regExp = RegExp(nameRegex);
    if (!regExp.hasMatch(name)) {
      return true;
    }

    // Check if the name contains any numbers
    final containsNumbers = name.contains(RegExp(r'[0-9]'));
    return containsNumbers;
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

  Future<void> loginWithPhoneNumber() async {
    showLoaderDialog(loginPageContext!);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$selectedCountryCode ${phoneNumberController.text}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        Navigator.pop(loginPageContext!);
        showErrorToast(loginPageContext!, "Something Went Wrong $e");
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationIdValue = verificationId;
        Navigator.pop(loginPageContext!);
        showSuccessToast(loginPageContext!, "OTP is sent to $selectedCountryCode ${phoneNumberController.text}");
        Navigator.pushNamed(loginPageContext!, Routes.otpScreenRoute);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> resendOtp() async {
    showLoaderDialog(loginPageContext!);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$selectedCountryCode ${phoneNumberController.text}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        Navigator.pop(otpScreenContext!);
        showErrorToast(loginPageContext!, "Something Went Wrong $e");
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationIdValue = verificationId;
        Navigator.pop(otpScreenContext!);
        showSuccessToast(loginPageContext!, "OTP is sent to $selectedCountryCode ${phoneNumberController.text}");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyOtp() async {
    showLoaderDialog(loginPageContext!);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIdValue!,
      smsCode: otpCode,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
        await apiCallForUserDetails(value.user!.uid);
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(otpScreenContext!);
      showErrorToast(otpScreenContext!, "Oops !You have entered a wrong OTP\n$e");
    }
  }

  apiCallForUserDetails(String uid) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    LoginResponseModel authResponse = await apiCalls.getUserDetails(uid, fcmToken!);
    await clearFieldData();
    if(authResponse.statusCode==200){
      prefModel.userData = authResponse.result;
      await AppPref.setPref(prefModel);
      Navigator.pop(otpScreenContext!);
      Navigator.pushNamed(otpScreenContext!, Routes.dashboardRoute);
    }else if(authResponse.statusCode==404){
      Navigator.pop(otpScreenContext!);
      Navigator.pushNamed(otpScreenContext!, Routes.registerRoute);
    }else{
      Navigator.pop(otpScreenContext!);
      showErrorToast(otpScreenContext!, authResponse.message!);
    }
  }

  clearFieldData() {
    phoneNumberController.text = "";
    otpCode = "";
    notifyListeners();
  }
}
