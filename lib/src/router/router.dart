import 'package:flutter/cupertino.dart';
import 'package:module_a1/src/router/router_const.dart';
import 'package:module_a1/src/screens/auth/login/login_screen.dart';
import 'package:module_a1/src/screens/auth/register/register_screen.dart';
import 'package:module_a1/src/screens/main/catalog/product_detail_screen.dart';
import 'package:module_a1/src/screens/main_screen.dart';

class Approuter {
  static Route generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case MainRoute:
        return CupertinoPageRoute(builder: (context) => MainScreen());
      case LoginRoute:
        return CupertinoPageRoute(builder: (context) => LoginScreen());
      case RegisterRoute:
        return CupertinoPageRoute(builder: (context) => RegisterScreen());
      case ProductDetailRoute:
        return CupertinoPageRoute(
            builder: (context) => ProductDetailScreen(
                  product: {},
                ));
      default:
        return CupertinoPageRoute(builder: (context) => MainScreen());
    }
  }
}
