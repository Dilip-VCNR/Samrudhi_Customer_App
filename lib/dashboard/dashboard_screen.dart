import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:samruddhi/dashboard/profile/ui/profile_screen.dart';
import 'package:samruddhi/dashboard/wallet/ui/wallet_screen.dart';
import 'package:samruddhi/utils/app_colors.dart';

import 'home/ui/home_screen.dart';
import 'orders/ui/orders_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  int selectedItemPosition = 0;

  List screens = [];

  @override
  void initState() {
    super.initState();
    screens = [
      const HomeScreen(),
      const OrdersScreen(),
      WalletScreen(changeScreen: changeScreen),
      ProfileScreen(changeScreen: changeScreen),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: screens[selectedItemPosition],
        bottomNavigationBar: SnakeNavigationBar.color(
          height: screenSize.height / 12,
          backgroundColor: Colors.white,
          elevation: 1,
          behaviour: SnakeBarBehaviour.pinned,
          snakeShape: SnakeShape.circle,
          shape: RoundedRectangleBorder(borderRadius: _borderRadius),
          padding: EdgeInsets.zero,
          snakeViewColor: AppColors.secondaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: selectedItemPosition,
          onTap: (index) => setState(() => selectedItemPosition = index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined), label: 'orders'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                label: 'wallet'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined), label: 'profile')
          ],
          selectedLabelStyle: const TextStyle(fontSize: 14),
          unselectedLabelStyle: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }

  void changeScreen(int index) {
    setState(() {
      selectedItemPosition = index;
    });
  }
}
