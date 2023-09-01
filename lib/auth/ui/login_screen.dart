import 'package:carousel_slider/carousel_slider.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:samruddhi/auth/controller/auth_controller.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_widgets.dart';
import '../../utils/routes.dart';
import '../../utils/url_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int currentSlideIndex = 0;
  TextEditingController phoneNumberController = TextEditingController();
  String? selectedCountryCode = "+91";
  final _formKey = GlobalKey<FormState>();

  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
                          currentSlideIndex = index;
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
                      3, // Replace 3 with the number of slides you have
                      (index) => buildDotIndicator(index),
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
                  Container(
                    width: screenSize.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            CountryCodePicker(
                              showFlag: false,
                              enabled: true,
                              onChanged: (element) {
                                selectedCountryCode = element.dialCode;
                              },
                              initialSelection: 'IN',
                              favorite: const ['+91', 'IN'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                            ),
                            Form(
                              key: _formKey,
                              child: SizedBox(
                                width: screenSize.width / 1.5,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter valid phone number';
                                    }
                                    if (authController.isNotValidPhone(value)) {
                                      return "Please enter valid phone number";
                                    }
                                    return null;
                                  },
                                  controller: phoneNumberController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  decoration: const InputDecoration(
                                      hintText: 'Phone Number',
                                      counterText: "",
                                      isCollapsed: true,
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'By clicking on proceed, you agree to our \n',
                          style: TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, Routes.webViewRoute,
                                  arguments: {
                                    'url': UrlConstant.privacyPolicy,
                                    'title': "Privacy Policy",
                                  });
                            },
                          text: 'Privacy policy ',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const TextSpan(
                          text: 'and ',
                          style: TextStyle(
                            color: AppColors.fontColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, Routes.webViewRoute,
                                  arguments: {
                                    'url': UrlConstant.termsOfUse,
                                    'title': "Terms and Conditions",
                                  });
                            },
                          text: 'Terms and conditions',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        showLoaderDialog(context);
                        authController.loginWithPhoneNumber(context,
                            phoneNumberController.text, selectedCountryCode);
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
  }

  Widget buildDotIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: currentSlideIndex == index ? 12.0 : 6.0,
      height: 6.0,
      decoration: BoxDecoration(
        color: currentSlideIndex == index ? Colors.black : Colors.grey,
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
