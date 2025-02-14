import 'package:flutter/cupertino.dart';
import 'package:module_a1/src/UI/styles.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.placeholder,
    required this.obscureText,
    required this.controller,
  });

  final String placeholder;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      placeholder: placeholder,
      controller: controller,
      obscureText: obscureText,
      padding: Styles.textFieldPadding,
    );
  }
}
