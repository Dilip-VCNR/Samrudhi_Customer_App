import 'package:flutter/material.dart';
import 'package:samruddhi/api_calls.dart';
import 'package:samruddhi/database/app_pref.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/routes.dart';
import '../../../utils/url_constants.dart';

class ProfileScreen extends StatefulWidget {
  final Function(int) changeScreen;

  const ProfileScreen({Key? key, required this.changeScreen}) : super(key: key);

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
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        '${UrlConstant.imageBaseUrl}${prefModel.userData!.profileImgArray![0].imageUrl}'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${prefModel.userData!.firstName}',
                        style: const TextStyle(
                          color: Color(0xFF3E3E3E),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Text(
                        '+91 8660225160',
                        style: TextStyle(
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
                        Navigator.pushNamed(context, Routes.editProfileRoute)
                            .then((value) {
                          setState(() {});
                          return null;
                        });
                        break;
                      case 'my_address':
                        Navigator.pushNamed(context, Routes.selectAddressRoute);
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
                        AppPref.clearPref();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.loginRoute, (route) => false);
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
                )
            ],
          ),
        ),
      ),
    );
  }
}
