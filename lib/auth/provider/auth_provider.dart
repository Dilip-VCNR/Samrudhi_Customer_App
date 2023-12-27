import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/auth/models/register_response_model.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../database/app_pref.dart';
import '../../utils/app_widgets.dart';
import '../../utils/routes.dart';
import '../models/login_response_model.dart';

class AuthProvider extends ChangeNotifier {
  ApiCalls apiCalls = ApiCalls();
  String? verificationIdValue;
  String? latestUid;
  LatLng? selectedLocation;

  // Login Page declarations
  int currentSlideIndex = 0;
  TextEditingController phoneNumberController = TextEditingController();
  String? selectedCountryCode = "+91";
  final loginFormKey = GlobalKey<FormState>();
  BuildContext? loginPageContext;

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

  // register page declarations
  bool termsAndConditionsIsChecked = false;
  final registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController storeReferralCodeController = TextEditingController();
  TextEditingController operatorCodeController = TextEditingController();
  TextEditingController operatorTypeController = TextEditingController();
  TextEditingController cableSubscriberIdController = TextEditingController();
  BuildContext? registerPageContext;
  File? selectedImage;

  Position? currentPosition;

  // selectPrimaryAddress Bottom sheet declarations
  final primaryAddressFormKey = GlobalKey<FormState>();

  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();

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
        showSuccessToast(loginPageContext!,
            "OTP is sent to $selectedCountryCode ${phoneNumberController.text}");
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
        showSuccessToast(loginPageContext!,
            "OTP is sent to $selectedCountryCode ${phoneNumberController.text}");
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
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        latestUid = value.user!.uid;
        await apiCallForUserDetails(value.user!.uid);
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(otpScreenContext!);
      showErrorToast(
          otpScreenContext!, "Oops !You have entered a wrong OTP\n$e");
    }
  }

  apiCallForUserDetails(String uid) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    LoginResponseModel authResponse =
        await apiCalls.getUserDetails(uid, fcmToken!);
    if (authResponse.statusCode == 200) {
      otpCode = "";
      notifyListeners();
      prefModel.userData = authResponse.result;
      await AppPref.setPref(prefModel);
      Navigator.pop(otpScreenContext!);
      Navigator.pushNamed(otpScreenContext!, Routes.dashboardRoute);
    } else if (authResponse.statusCode == 404) {
      Navigator.pop(otpScreenContext!);
      Navigator.pushNamed(otpScreenContext!, Routes.registerRoute);
    } else {
      Navigator.pop(otpScreenContext!);
      showErrorToast(otpScreenContext!, authResponse.message!);
    }
  }

  clearFieldData() {
    phoneNumberController.text = "";
    otpCode = "";
    notifyListeners();
  }

  getApproxLocation() async {
    showLoaderDialog(registerPageContext!);
    try {
      currentPosition = await getCurrentLocation();
    } catch (e) {
      currentPosition = const Position(
          latitude: 10.1632,
          longitude: 76.6413,
          timestamp: null,
          accuracy: 100,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0);
    }
    Navigator.pop(registerPageContext!);
    Navigator.pushNamed(registerPageContext!, Routes.primaryLocationRoute);
  }

  registerNewUser() async {
    showLoaderDialog(selectAddressPageContext!);
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    RegisterResponseModel registerResponse = await apiCalls.registerNewUser(
        firstNameController.text,
        lastNameController.text,
        latestUid,
        emailController.text,
        phoneNumberController.text,
        fcmToken,
        operatorCodeController.text,
        operatorTypeController.text,
        storeReferralCodeController.text,
        cableSubscriberIdController.text,
        "Home",
        addressController.text,
        cityController.text,
        stateController.text,
        selectedLocation!.latitude,
        selectedLocation!.longitude,
        postalCodeController.text,
        selectedImage
    );
    if(registerResponse.statusCode==201){
      prefModel.userData = registerResponse.result;
      await AppPref.setPref(prefModel);
      await clearFieldData();
      Navigator.pop(selectAddressPageContext!);
      Navigator.pushNamedAndRemoveUntil(selectAddressPageContext!, Routes.dashboardRoute, (route) => false);
    }else{
      Navigator.pop(selectAddressPageContext!);
      showErrorToast(selectAddressPageContext!, registerResponse.message!);
    }
  }
}
