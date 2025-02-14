import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:module_a1/src/router/router_const.dart';
import 'package:module_a1/src/screens/auth/register/register_screen.dart';

void registerValid(BuildContext context) async {
  String login = loginController.text;
  String email = emailController.text;
  String password = passwordController.text;

  Dio dio = Dio();
  String baseUrl = 'http://10.0.2.2:53000';

  try {
    Response response = await dio.post('$baseUrl/register', data: {
      'login': login,
      'mail': email,
      'password': password,
    });

    if (response.statusCode == 201) {
      Navigator.pushNamed(context, LoginRoute);
    } else {
      _showErrorDialog(context, 'Ошибка регистрации');
    }
  } on DioException {
    _showErrorDialog(context, 'Такой аккаунт уже существует');
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
              child: const Text('Ok'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      });
}
