import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/auth/provider/auth_provider.dart';
import 'package:samruddhi/utils/app_colors.dart';
import 'package:samruddhi/utils/app_widgets.dart';

import '../../utils/routes.dart';
import '../../utils/url_constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Consumer<AuthProvider>(
      builder: (BuildContext context, AuthProvider authProvider, Widget? child) {
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
                          value: authProvider.termsAndConditionsIsChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              authProvider.termsAndConditionsIsChecked = value!;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      if (authProvider.registerFormKey.currentState!.validate()) {
                        if (!authProvider.termsAndConditionsIsChecked) {
                          showErrorToast(context, "Please agree to terms and conditions.");
                          return;
                        }
                        if (context.mounted) {
                          authProvider.chooseCurrentAddress(context);
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
                key: authProvider.registerFormKey,
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
                      controller: authProvider.firstNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your First name';
                        }
                        if (authProvider.isNotValidName(value)) {
                          return "Please enter valid first name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_2_outlined),
                        hintText: 'First Name',
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
                      controller: authProvider.lastNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your last name';
                        }
                        if (authProvider.isNotValidName(value)) {
                          return "Please enter valid last name";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_2_outlined),
                        hintText: 'Last Name',
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
                      controller: authProvider.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (authProvider.isNotValidEmail(value)) {
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
                      controller: authProvider.storeReferralCodeController,
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
                      controller: authProvider.operatorCodeController,
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
                      controller: authProvider.cableSubscriberIdController,
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
      },
    );
  }
}
