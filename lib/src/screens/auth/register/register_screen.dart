import 'package:flutter/cupertino.dart';
import 'package:module_a1/src/UI/styles.dart';
import 'package:module_a1/src/common/widgets/custom_button.dart';
import 'package:module_a1/src/common/widgets/custom_field.dart';
import 'package:module_a1/src/screens/auth/register/valid/register_valid.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController loginController = TextEditingController();

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordHiden = true;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Styles.backgroundColor,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.white,
          middle: Text('Регистрация'),
        ),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomField(
              placeholder: 'Логин',
              obscureText: false,
              controller: loginController,
            ),
            Container(
              height: 1,
              padding: Styles.pagePadding,
              color: Styles.borderColor,
            ),
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
              obscureText: _isPasswordHiden,
              controller: passwordController,
              padding: Styles.textFieldPadding,
              suffix: CupertinoButton(
                  child: Icon(_isPasswordHiden
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash),
                  onPressed: () {
                    setState(() {
                      _isPasswordHiden = !_isPasswordHiden;
                    });
                  }),
            ),
            Container(
              height: 1,
              padding: Styles.pagePadding,
              color: Styles.borderColor,
            ),
            SizedBox(
              height: 25,
            ),
            Spacer(),
            Padding(
              padding: Styles.pagePadding,
              child: CustomButton(
                text: 'Создать аккаунт',
                onPressed: () {
                  registerValid(context);
                },
              ),
            ),
          ],
        )));
  }
}
