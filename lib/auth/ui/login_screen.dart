import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/utils/routes.dart';

import '../../utils/app_colors.dart';
import '../../utils/url_constants.dart';
import '../provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder:
          (BuildContext context, AuthProvider authProvider, Widget? child) {
        authProvider.loginPageContext = context;
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Image(image: AssetImage('assets/images/logo.png')),
                      CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          height: screenSize.height / 2.5,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              authProvider.currentSlideIndex = index;
                            });
                          },
                        ),
                        items: [
                          Image.asset('assets/images/login_bg.png'),
                          Image.asset('assets/images/login_bg.png'),
                          Image.asset('assets/images/login_bg.png'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          3,
                          (index) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              width: authProvider.currentSlideIndex == index
                                  ? 12.0
                                  : 6.0,
                              height: 6.0,
                              decoration: BoxDecoration(
                                color: authProvider.currentSlideIndex == index
                                    ? Colors.black
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Enter your mobile number',
                        style: TextStyle(
                          color: AppColors.fontColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'We need to verify you. We will send you a \none time verification code. ',
                        style: TextStyle(
                          color: Color(0xB737474F),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            child: CountryCodePicker(
                              showFlag: true,
                              enabled: true,
                              onChanged: (element) {
                                authProvider.selectedCountryCode =
                                    element.dialCode;
                              },
                              initialSelection: 'IN',
                              favorite: const ['+91', 'IN'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Form(
                              key: authProvider.loginFormKey,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter valid phone number';
                                  }
                                  if (authProvider.isNotValidPhone(value)) {
                                    return "Please enter valid phone number";
                                  }
                                  return null;
                                },
                                controller: authProvider.phoneNumberController,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                decoration: InputDecoration(
                                  hintText: 'Phone Number',
                                  counterText: "",
                                  isCollapsed: true,
                                  errorStyle: const TextStyle(
                                      color: AppColors.secondaryColor),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'By clicking on proceed, you agree to our \n',
                              style: TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy policy ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
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
                            TextSpan(
                              text: 'and ',
                              style: TextStyle(
                                color: AppColors.fontColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms and conditions',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          if (authProvider.loginFormKey.currentState!.validate()) {
                            await authProvider.loginWithPhoneNumber();
                          }
                        },
                        child: Container(
                          width: screenSize.width,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: ShapeDecoration(
                            color: AppColors.secondaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Center(
                            child: Text(
                              'Next',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
