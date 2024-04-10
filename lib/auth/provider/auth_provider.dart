import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/auth/models/register_response_model.dart';
import 'package:samruddhi/utils/app_colors.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../database/app_pref.dart';
import '../../utils/app_widgets.dart';
import '../../utils/routes.dart';
import '../../utils/url_constants.dart';
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

  BuildContext? profilePageContext;
  BuildContext? editProfilePageContext;

  TextEditingController editFirstNameController = TextEditingController();
  TextEditingController editLastNameController = TextEditingController();
  TextEditingController editEmailController = TextEditingController();
  TextEditingController editStoreReferralCodeController =
      TextEditingController();

  Position? currentPosition;

  // selectPrimaryAddress Bottom sheet declarations
  final primaryAddressFormKey = GlobalKey<FormState>();

  TextEditingController addressController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  BuildContext? fillAddressBottomSheetContext;

  // add new address declarations
  final newAddressFormKey = GlobalKey<FormState>();

  List<String> addressType = ['Home', 'Office', 'Other'];
  String selectedAddressType = '';

  TextEditingController newAddressController = TextEditingController();
  TextEditingController newStateController = TextEditingController();
  TextEditingController newCityController = TextEditingController();
  TextEditingController newPostalCodeController = TextEditingController();
  BuildContext? markLocationContext;
  BuildContext? markLocationContext1;

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
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Ask the user to enable location services
      bool enableService = await askUserToEnableLocationService();
      if (!enableService) {
        // Return last known location if the user chooses not to enable location services
        return getLastKnownLocation();
      }
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Return last known location if permission is denied
        return getLastKnownLocation();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Return last known location if permission is permanently denied
      return getLastKnownLocation();
    }

    // Get current position
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );
      return position;
    } catch (e) {
      // Handle any errors while getting current position
      // Return last known location if there is an error
      return getLastKnownLocation();
    }
  }

  Future<Position> getLastKnownLocation() async {
    try {
      Position? position = await Geolocator.getLastKnownPosition();
      if (position != null) {
        return position;
      } else {
        throw Exception('No last known location available');
      }
    } catch (e) {
      throw Exception('Error getting last known location');
    }
  }
  Future<bool> askUserToEnableLocationService() async {
    // You can use your preferred method to prompt the user to enable location services
    // For example, show a dialog or navigate to the device settings
    // Return true if the user enables location services, false otherwise

    // Example using a simple dialog (this is just for illustration purposes):
    // You should implement a proper UI for your application
    bool userEnabledService = await showDialog(
      context: registerPageContext!,
      // Implement your dialog here
      builder: (context) => AlertDialog(
        title: const Text("Enable Location Services"),
        content: const Text("Please enable location services for better experience."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false); // User chose not to enable
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true); // User chose to enable
            },
            child: const Text("Enable"),
          ),
        ],
      ),
    );

    return userEnabledService ;
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
    selectedImage = null;
    notifyListeners();
  }

  getApproxLocationForAdd() async {
    showLoaderDialog(selectAddressPageContext!);
    try {
      currentPosition = await getCurrentLocation();
    } catch (e) {
      currentPosition = Position(
          latitude: 10.1632,
          longitude: 76.6413,
          timestamp: DateTime.now(),
          accuracy: 500,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0, altitudeAccuracy: 100, headingAccuracy: 100
      );
    }
    Navigator.pop(selectAddressPageContext!);
    Navigator.pushNamed(selectAddressPageContext!, Routes.markLocationRoute);
  }

  getApproxLocation() async {
    showLoaderDialog(registerPageContext!);
    try {
      currentPosition = await getCurrentLocation();
    } catch (e) {
      currentPosition = Position(
          latitude: 10.1632,
          longitude: 76.6413,
          timestamp: DateTime.now(),
          accuracy: 500,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0, altitudeAccuracy: 100, headingAccuracy: 100
      );
    }
    Navigator.pop(registerPageContext!);
    Navigator.pushNamed(registerPageContext!, Routes.primaryLocationRoute);
  }

  getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CroppedFile croppedFile = await getCroppedImage(pickedFile.path);
      selectedImage = File(croppedFile.path);
      notifyListeners();
    }
  }

  getCroppedImage(String path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColors.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    return croppedFile;
  }
  registerNewUser() async {
    showLoaderDialog(fillAddressBottomSheetContext!);
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
        "Primary",
        addressController.text,
        cityController.text,
        stateController.text,
        selectedLocation!.latitude,
        selectedLocation!.longitude,
        postalCodeController.text,
        selectedImage,
        fillAddressBottomSheetContext!);
    if (registerResponse.statusCode == 201) {
      prefModel.userData = registerResponse.result;
      await AppPref.setPref(prefModel);
      await clearFieldData();
      Navigator.pop(fillAddressBottomSheetContext!);
      Navigator.pushNamedAndRemoveUntil(fillAddressBottomSheetContext!,
          Routes.dashboardRoute, (route) => false);
    } else {
      Navigator.pop(fillAddressBottomSheetContext!);
      showErrorToast(fillAddressBottomSheetContext!, registerResponse.message!);
    }
  }

  addNewAddress() async {
    showLoaderDialog(markLocationContext!);
    LoginResponseModel newAddressResponse = await apiCalls.apiAddNewAddress(
        selectedLocation,
        selectedAddressType,
        newAddressController.text,
        newCityController.text,
        newStateController.text,
        newPostalCodeController.text);
    if (newAddressResponse.statusCode == 200) {
      prefModel.userData = newAddressResponse.result;
      AppPref.setPref(prefModel);
      Navigator.pop(markLocationContext!);
      Navigator.pop(markLocationContext!);
      Navigator.pop(markLocationContext1!);
      selectedAddressType = '';
      newAddressController.clear();
      newCityController.clear();
      newStateController.clear();
      newPostalCodeController.clear();
      notifyListeners();
      showSuccessToast(markLocationContext!, newAddressResponse.message!);
    } else {
      Navigator.pop(markLocationContext!);
      showErrorToast(markLocationContext!, newAddressResponse.message!);
    }
  }

  updateProfile() async {
    showLoaderDialog(editProfilePageContext!);
    LoginResponseModel updateResponse = await apiCalls.updateUserDetails(
        editFirstNameController.text,
        editLastNameController.text,
        editEmailController.text,
        selectedImage);
    selectedImage = null;
    if (updateResponse.statusCode == 200) {
      otpCode = "";
      prefModel.userData = updateResponse.result;
      await AppPref.setPref(prefModel);
      notifyListeners();
      showSuccessToast(editProfilePageContext!, updateResponse.message!);
      Navigator.pop(editProfilePageContext!);
      Navigator.pop(editProfilePageContext!);
    } else if (updateResponse.statusCode == 404) {
      Navigator.pop(editProfilePageContext!);
      Navigator.pushNamed(editProfilePageContext!, Routes.registerRoute);
    } else {
      Navigator.pop(editProfilePageContext!);
      showErrorToast(editProfilePageContext!, updateResponse.message!);
    }
  }

  setEditProfile() async {
    showLoaderDialog(profilePageContext!);
    editFirstNameController.text = prefModel.userData!.firstName!;
    editLastNameController.text = prefModel.userData!.lastName!;
    editEmailController.text = prefModel.userData!.emailId!;
    editStoreReferralCodeController.text = prefModel.userData!.storeReferralCode ?? '';
    if(prefModel.userData!.profileImgArray!.isNotEmpty){
      selectedImage = await downloadImageAndReturnFilePath(UrlConstant.imageBaseUrl+prefModel.userData!.profileImgArray![0].imageUrl!);
    }else{
      selectedImage=null;
    }
    Navigator.pop(profilePageContext!);
    Navigator.pushNamed(profilePageContext!, Routes.editProfileRoute)
        .then((value) {
          notifyListeners();
      return null;
    });
  }

  Future<File?> downloadImageAndReturnFilePath(String imageUrl) async {
    try {
      // Fetch the image data
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Create a temporary file
        File tempFile = File('${Directory.systemTemp.path}/temp_image_${DateTime.now().millisecondsSinceEpoch}.jpg');

        // Write the image data to the temporary file
        await tempFile.writeAsBytes(response.bodyBytes);

        // Return the path to the temporary file
        return tempFile;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
