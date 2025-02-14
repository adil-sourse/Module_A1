import 'package:flutter/cupertino.dart';
import 'package:module_a1/src/router/router.dart';
import 'package:module_a1/src/screens/auth/login/login_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:module_a1/src/screens/main/basket/basket_model.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('tokens');

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => BasketModel()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Approuter.generateRoute,
      home: LoginScreen(),
    );
  }
}
