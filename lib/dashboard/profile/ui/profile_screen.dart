import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/auth/provider/auth_provider.dart';
import 'package:samruddhi/database/app_pref.dart';
import 'package:samruddhi/utils/app_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/routes.dart';
import '../../../utils/url_constants.dart';

class ProfileScreen extends StatefulWidget {
  final Function(int) changeScreen;

  const ProfileScreen({super.key, required this.changeScreen});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List options = [
    {'title': 'Edit Profile', 'icon': Icons.edit, 'clickType': 'edit_profile'},
    {
      'title': 'My Address',
      'icon': Icons.location_on_outlined,
      'clickType': 'my_address'
    },
    {
      'title': 'My Orders',
      'icon': Icons.shopping_bag_outlined,
      'clickType': 'my_orders'
    },
    {'title': 'About', 'icon': Icons.info_outline, 'clickType': 'about'},
    {'title': 'FAQ’S', 'icon': Icons.question_mark_rounded, 'clickType': 'faq'},
    {
      'title': 'Privacy policy',
      'icon': Icons.fingerprint,
      'clickType': 'privacy'
    },
    {
      'title': 'Mail to us',
      'icon': Icons.mail_lock_outlined,
      'clickType': 'mail'
    },
    {
      'title': 'Terms and conditions',
      'icon': Icons.edit_note_rounded,
      'clickType': 'tc'
    },
    {
      'title': 'Log out',
      'icon': Icons.power_settings_new,
      'clickType': 'logout'
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer(
      builder:
          (BuildContext context, AuthProvider authProvider, Widget? child) {
        authProvider.profilePageContext = context;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldBackground,
            automaticallyImplyLeading: false,
            title: const Text(
              'Profile',
              style: TextStyle(
                color: AppColors.fontColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      prefModel.userData!.profileImgArray!.isNotEmpty
                          ? CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey.shade400,
                              backgroundImage: NetworkImage(
                                  '${UrlConstant.imageBaseUrl}${prefModel.userData!.profileImgArray![0].imageUrl}?v=${Random().nextInt(100)}'),
                            )
                          : const SizedBox.shrink(),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenSize.width / 1.75,
                            child: Text(
                              '${prefModel.userData!.firstName}',
                              style: const TextStyle(
                                color: Color(0xFF3E3E3E),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            '+91 ${prefModel.userData!.mobile}',
                            style: const TextStyle(
                              color: Color(0xFF545454),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              height: 1.53,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    height: 1,
                  ),
                  for (int i = 0; i < options.length; i++)
                    InkWell(
                      onTap: () async {
                        switch (options[i]['clickType']) {
                          case 'edit_profile':
                            authProvider.setEditProfile();
                            break;
                          case 'my_address':
                            Navigator.pushNamed(
                                context, Routes.selectAddressRoute);
                            break;
                          case 'my_orders':
                            widget.changeScreen(1); // Change to the second item
                            break;
                          case 'about':
                            Navigator.pushNamed(context, Routes.webViewRoute,
                                arguments: {
                                  'url': UrlConstant.about,
                                  'title': "About",
                                });
                            break;
                          case 'faq':
                            Navigator.pushNamed(context, Routes.webViewRoute,
                                arguments: {
                                  'url': UrlConstant.faq,
                                  'title': "FAQ'S",
                                });
                            break;
                          case 'privacy':
                            Navigator.pushNamed(context, Routes.webViewRoute,
                                arguments: {
                                  'url': UrlConstant.privacyPolicy,
                                  'title': "Privacy Policy",
                                });
                            break;
                          case 'mail':
                            if (!await launchUrl(
                              Uri.parse("mailto:support@thebuysapp.com"),
                              mode: LaunchMode.externalApplication,
                            )) {
                              throw Exception('Could not launch');
                            }
                            break;
                          case 'tc':
                            Navigator.pushNamed(context, Routes.webViewRoute,
                                arguments: {
                                  'url': UrlConstant.termsOfUse,
                                  'title': "Terms of use",
                                });
                            break;
                          case 'logout':
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const LogoutConfirmationDialog();
                              },
                            ).then((confirmed) async {
                              if (confirmed == true) {
                                prefModel.userData = null;
                                prefModel.selectedAddress = null;
                                prefModel.cartItems = null;
                                prefModel.cartStore = null;
                                await AppPref.setPref(prefModel);
                                showSuccessToast(context, "Logout successful");
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    Routes.loginRoute, (route) => false);
                              }
                            });
                            break;
                          default:
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            width: screenSize.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  options[i]['icon'],
                                  color: AppColors.fontColor,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  options[i]['title'],
                                  style: const TextStyle(
                                    color: AppColors.fontColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text("v1.1.4"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LogoutConfirmationDialog extends StatelessWidget {
  const LogoutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pop(false); // Dismiss the dialog and return false
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pop(true); // Dismiss the dialog and return true
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
