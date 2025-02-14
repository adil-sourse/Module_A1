import 'package:dio/dio.dart ';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:module_a1/src/screens/auth/login/login_screen.dart';
import 'package:module_a1/src/screens/main_screen.dart';

void loginValid(BuildContext context) async {
  final email = emailController.text;
  final password = passwordController.text;

  Box tokensBox = await Hive.openBox('tokens');

  Dio dio = Dio();
  String baseUrl = 'http://10.0.2.2:53000';

  try {
    Response response = await dio.post('$baseUrl/login', data: {
      'mail': email,
      'password': password,
    });

    if (response.data != null && response.data['token'] != null) {
      tokensBox.put('access', response.data['token']);
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => MainScreen()),
          (route) => false);
    } else {
      _showErrorDialog(context, 'Ответ от сервера пуст');
    }
  } on DioException {
    _showErrorDialog(context, 'Неверный логин или пароль');
  }
}

void _showErrorDialog(BuildContext context, String message) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Ошибка'),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}
