import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/auth/models/check_user_response_model.dart';
import 'package:samruddhi/auth/models/register_user_request_model.dart';
import 'package:samruddhi/auth/models/register_user_response_model.dart';
import 'package:samruddhi/database/models/pref_model.dart';
import 'package:samruddhi/utils/app_widgets.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../database/app_pref.dart';
import '../../utils/routes.dart';

class AuthProvider extends ChangeNotifier {

  BuildContext? context;
  ApiCalls apiCalls = ApiCalls();
  int currentSlideIndex = 0;
  TextEditingController phoneNumberController = TextEditingController();
  String? selectedCountryCode = "+91";
  String? lastVerificationId;
  int? lastResendToken;
  Position? currentPosition;

  User? lastAuthUserData;
  final registerFormKey = GlobalKey<FormState>();

  CountdownController controller = CountdownController(autoStart: true);
  int seconds = 30;
  bool firstStateEnabled = false;
  String otpCode = "";


  bool termsAndConditionsIsChecked = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController storeReferralCodeController = TextEditingController();
  TextEditingController operatorCodeController = TextEditingController();
  TextEditingController cableSubscriberIdController = TextEditingController();


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

  Future<void> sendOtp() async {
    showLoaderDialog(context!);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '$selectedCountryCode ${phoneNumberController.text}',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        showErrorToast(context!, e.toString());
        Navigator.pop(context!);
      },
      codeSent: (String verificationId, int? resendToken) {
        lastVerificationId = verificationId;
        lastResendToken = resendToken;
        Navigator.pop(context!);
        showSuccessToast(context!, "Otp is sent to $selectedCountryCode ${phoneNumberController.text} Successfully !");
        Navigator.pushNamed(context!, Routes.otpScreenRoute);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
      },
    );
  }

  Future<void> verifyOtp() async {
    showLoaderDialog(context!);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: lastVerificationId!,
      smsCode: otpCode,
    );
    try {
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        await apiCallForUserDetails(value.user,);
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context!);
      showErrorToast(
        context!,
        "Oops !You have entered a wrong OTP $e",
      );
    }
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

  apiCallForUserDetails(User? user) async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    CheckUserResponseModel userData = await apiCalls.checkForUser(user,fcmToken);
    if(userData.statusCode==200){
      PrefModel prefModel = AppPref.getPref();
      prefModel.userdata = userData.result;
      await AppPref.setPref(prefModel);
      Navigator.pop(context!);
      Navigator.pushNamed(context!, Routes.dashboardRoute);
    }else{
      if(userData.statusCode==404){
        lastAuthUserData = user;
        Navigator.pop(context!);
        Navigator.pushNamed(context!, Routes.registerRoute);
      }else{
        Navigator.pop(context!);
        showErrorToast(context!, userData.message!);
      }
    }
  }

  Future<void> chooseCurrentAddress() async {
    showLoaderDialog(context!);
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
        speedAccuracy: 0,
      );
    }
    Navigator.pop(context!);
    Navigator.pushNamed(context!, Routes.primaryLocationRoute,arguments: {
      "currentLocation": currentPosition
    });
  }

  Future<void> registerNewCustomer() async {
    showLoaderDialog(context!);
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    RegisterUserRequestModel reqObj = RegisterUserRequestModel();
    reqObj.firstName = firstNameController.text;
    reqObj.lastName = lastNameController.text;
    reqObj.customerUuid = lastAuthUserData!.uid;
    reqObj.emailId = emailController.text;
    reqObj.password = "xyz";
    reqObj.mobile = phoneNumberController.text;
    reqObj.customerFcmToken = fcmToken;
    reqObj.operatorUuid = operatorCodeController.text;
    reqObj.operatorType = "fdsfsdf";
    reqObj.storeReferralCode = storeReferralCodeController.text;
    reqObj.cableSubscriberUuid = cableSubscriberIdController.text;
    reqObj.addressType = "Primary";
    reqObj.completeAddress = addressController.text;
    reqObj.city = cityController.text;
    reqObj.state = stateController.text;
    reqObj.lat = currentPosition!.latitude.toString();
    reqObj.lng = currentPosition!.longitude.toString();
    reqObj.zipCode = postalCodeController.text;

    RegisterUserResponseModel response = await apiCalls.registerNewCustomer(context!,reqObj.toJson());
    if(response.statusCode==201){
      PrefModel prefModel = AppPref.getPref();
      prefModel.userdata = response.result;
      await AppPref.setPref(prefModel);
      Navigator.pop(context!);
      Navigator.of(context!).pushNamedAndRemoveUntil(
          Routes.dashboardRoute, (route) => false);
    }else{
      Navigator.pop(context!);
      if(response.statusCode==301){
        showErrorToast(context!, response.message!);
      }else{
        showErrorToast(context!, response.message!);

      }
    }

  }
}
