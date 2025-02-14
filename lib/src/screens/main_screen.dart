import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:module_a1/src/screens/auth/login/login_screen.dart';
import 'package:module_a1/src/screens/main/basket/basket_screen.dart';
import 'package:module_a1/src/screens/main/catalog/catalog_screen.dart';
import 'package:module_a1/src/screens/main/profile/profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'Каталог'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.gift), label: 'Корзина'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: 'Профиль'),
          ]),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CatalogScreen();
              case 1:
                return BasketScreen();
              case 2:
                return ProfileScreen();
              default:
                return LoginScreen();
            }
          }),
    );
  }
}
