import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:samruddhi/auth/controller/auth_controller.dart';
import 'package:samruddhi/utils/app_colors.dart';

import '../../utils/routes.dart';
import '../../utils/url_constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool termsAndConditionsIsChecked = false;
  final _formKey = GlobalKey<FormState>();

  AuthController authController = AuthController();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController storeReferralCodeController = TextEditingController();
  TextEditingController operatorCodeController = TextEditingController();
  TextEditingController cableSubscriberIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Information',
          style: TextStyle(
            color: AppColors.fontColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 150,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          margin: const EdgeInsets.only(right: 10),
                          child: const Icon(
                            Icons.newspaper_outlined,
                            color: Colors.black,
                            size: 15,
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width - 150,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                              children: <TextSpan>[
                                const TextSpan(
                                    text:
                                        'By clicking on proceed, you agree with our '),
                                TextSpan(
                                  text: 'Privacy Policy ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, Routes.webViewRoute,
                                          arguments: {
                                            'url': UrlConstant.privacyPolicy,
                                            'title': "Privacy Policy",
                                          });
                                    },
                                ),
                                const TextSpan(text: 'and '),
                                TextSpan(
                                  text: 'Terms and conditions',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                          context, Routes.webViewRoute,
                                          arguments: {
                                            'url': UrlConstant.termsOfUse,
                                            'title': "Terms and Conditions",
                                          });
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: AppColors.primaryColor,
                      value: termsAndConditionsIsChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          termsAndConditionsIsChecked = value!;
                        });
                      },
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    if (!termsAndConditionsIsChecked) {
                      return;
                    }
                    Position currentPosition;
                    try {
                      currentPosition =
                          await authController.getCurrentLocation();
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
                    if (context.mounted) {
                      Navigator.pushNamed(context, Routes.primaryLocationRoute,
                          arguments: {
                            'name': nameController.text,
                            'email': emailController.text,
                            'storeReferralCode':
                                storeReferralCodeController.text,
                            'operatorCode': operatorCodeController.text,
                            'cableSubscriberId':
                                cableSubscriberIdController.text,
                            "currentLocation": currentPosition
                          });
                    }
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 13.0),
                  decoration: const BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'It looks like you don’t have account in this number. Please let us know some information for a secure service',
                  style: TextStyle(
                    color: Color(0xB737474F),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (authController.isNotValidName(value)) {
                      return "Please enter valid name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    hintText: 'Full Name',
                    counterText: "",
                    isCollapsed: true,
                    filled: true,
                    fillColor: AppColors.inputFieldColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (authController.isNotValidEmail(value)) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    hintText: 'Email',
                    counterText: "",
                    isCollapsed: true,
                    filled: true,
                    fillColor: AppColors.inputFieldColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: storeReferralCodeController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.store),
                    hintText: 'Store referral code (Optional)',
                    counterText: "",
                    isCollapsed: true,
                    filled: true,
                    fillColor: AppColors.inputFieldColor,
                    // Set the fill color to grey
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // Set the border radius
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: operatorCodeController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.settings_input_antenna),
                    hintText: 'Operator code (Optional)',
                    counterText: "",
                    isCollapsed: true,
                    filled: true,
                    fillColor: AppColors.inputFieldColor,
                    // Set the fill color to grey
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // Set the border radius
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: cableSubscriberIdController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.tv),
                    hintText: 'Cable subscriber Id (Optional)',
                    counterText: "",
                    isCollapsed: true,
                    filled: true,
                    fillColor: AppColors.inputFieldColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
