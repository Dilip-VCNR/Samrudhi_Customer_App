import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samruddhi/dashboard/orders/ui/order_details.dart';
import 'package:samruddhi/splash/ui/splash_screen.dart';
import 'package:samruddhi/utils/app_colors.dart';
import 'package:samruddhi/utils/routes.dart';

import 'address/ui/mark_location.dart';
import 'address/ui/primary_location.dart';
import 'address/ui/select_address.dart';
import 'auth/ui/login_screen.dart';
import 'auth/ui/otp_screen.dart';
import 'auth/ui/register_screen.dart';
import 'dashboard/dashboard_screen.dart';
import 'dashboard/home/ui/notifications_screen.dart';
import 'dashboard/home/ui/search_screen.dart';
import 'dashboard/orders/ui/place_order.dart';
import 'dashboard/profile/web_view_screen.dart';
import 'dashboard/store/ui/store_screen.dart';
import 'dashboard/wallet/ui/redeem_points_operator.dart';
import 'database/app_pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPref.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Samruddhi',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primaryColor: AppColors.primaryColor,
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
      ),
      initialRoute: Routes.splashRoute,
      routes: {
        Routes.splashRoute: (context) => const SplashScreen(),
        Routes.loginRoute: (context) => const LoginScreen(),
        Routes.otpScreenRoute: (context) => const OtpScreen(),
        Routes.registerRoute: (context) => const RegisterScreen(),
        Routes.dashboardRoute: (context) => const DashboardScreen(),
        Routes.orderDetailsRoute: (context) => const OrderDetails(),
        Routes.redeemPointsOperatorRoute: (context) =>
            const RedeemPointsOperator(),
        Routes.notificationsRoute: (context) => const NotificationsScreen(),
        Routes.searchScreenRoute: (context) => const SearchScreen(),
        Routes.storeInRoute: (context) => const StoreScreen(),
        Routes.placeOrderRoute: (context) => const PlaceOrder(),
        Routes.selectAddressRoute: (context) => const SelectAddress(),
        Routes.markLocationRoute: (context) => const MarkLocation(),
        Routes.primaryLocationRoute: (context) => const PrimaryLocation(),
        Routes.webViewRoute: (context) => const WebViewScreen(),
      },
    );
  }
}
