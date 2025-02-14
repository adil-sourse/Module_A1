import 'package:flutter/cupertino.dart';
import 'package:module_a1/src/UI/styles.dart';
import 'package:module_a1/src/common/widgets/custom_button.dart';
import 'package:module_a1/src/common/widgets/custom_field.dart';
import 'package:module_a1/src/router/router_const.dart';
import 'package:module_a1/src/screens/auth/login/valid/login_valid.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Styles.backgroundColor,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.white,
          middle: Text('Авторизация'),
        ),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomField(
              placeholder: 'Почта',
              obscureText: false,
              controller: emailController,
            ),
            Container(
              height: 1,
              padding: Styles.pagePadding,
              color: Styles.borderColor,
            ),
            CupertinoTextField(
              placeholder: 'Пароль',
              controller: passwordController,
              padding: Styles.textFieldPadding,
              obscureText: _isPasswordVisible,
              suffix: CupertinoButton(
                  child: Icon(_isPasswordVisible
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  }),
            ),
            Container(
              height: 1,
              padding: Styles.pagePadding,
              color: Styles.borderColor,
            ),
            SizedBox(
              height: 19,
            ),
            Padding(
              padding: Styles.pagePadding,
              child: CustomButton(
                text: 'Вход',
                onPressed: () {
                  loginValid(context);
                },
              ),
            ),
            SizedBox(
              height: 19,
            ),
            Padding(
              padding: Styles.pagePadding,
              child: CustomButton(
                text: 'Регистрация',
                onPressed: () {
                  Navigator.pushNamed(context, RegisterRoute);
                },
              ),
            ),
          ],
        )));
  }
}
