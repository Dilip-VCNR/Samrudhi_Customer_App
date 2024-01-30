import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samruddhi/dashboard/orders/provider/orders_provider.dart';
import 'package:samruddhi/dashboard/orders/ui/order_details.dart';
import 'package:samruddhi/dashboard/profile/ui/edit_profile.dart';
import 'package:samruddhi/dashboard/wallet/provider/wallet_provider.dart';
import 'package:samruddhi/splash/ui/splash_screen.dart';
import 'package:samruddhi/utils/app_colors.dart';
import 'package:samruddhi/utils/routes.dart';

import 'address/ui/mark_location.dart';
import 'address/ui/primary_location.dart';
import 'address/ui/select_address.dart';
import 'auth/provider/auth_provider.dart';
import 'auth/ui/login_screen.dart';
import 'auth/ui/otp_screen.dart';
import 'auth/ui/register_screen.dart';
import 'dashboard/dashboard_screen.dart';
import 'dashboard/home/ui/notifications_screen.dart';
import 'dashboard/home/ui/search_screen.dart';
import 'dashboard/orders/ui/place_order.dart';
import 'dashboard/profile/web_view_screen.dart';
import 'dashboard/providers/dashboard_provider.dart';
import 'dashboard/store/ui/store_screen.dart';
import 'dashboard/store/ui/store_search.dart';
import 'dashboard/wallet/ui/redeem_points_operator.dart';
import 'database/app_pref.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPref.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
        ChangeNotifierProvider(create: (context) => WalletProvider()),
        ChangeNotifierProvider(create: (context) => OrdersProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Samruddhi',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            scrolledUnderElevation: 0
          ),
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
          Routes.editProfileRoute: (context) => const EditProfile(),
          Routes.dashboardRoute: (context) => const DashboardScreen(),
          Routes.orderDetailsRoute: (context) => const OrderDetails(),
          Routes.redeemPointsOperatorRoute: (context) => const RedeemPointsOperator(),
          Routes.notificationsRoute: (context) => const NotificationsScreen(),
          Routes.searchScreenRoute: (context) => const SearchScreen(),
          Routes.storeInRoute: (context) => const StoreScreen(),
          Routes.storeSearchRoute: (context) => const StoreSearch(),
          Routes.placeOrderRoute: (context) => const PlaceOrder(),
          Routes.selectAddressRoute: (context) => const SelectAddress(),
          Routes.markLocationRoute: (context) => const MarkLocation(),
          Routes.primaryLocationRoute: (context) => const PrimaryLocation(),
          Routes.webViewRoute: (context) => const WebViewScreen(),
        },
      ),
    );
  }
}
