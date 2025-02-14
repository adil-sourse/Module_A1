import 'package:flutter/cupertino.dart';
import 'package:module_a1/src/UI/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: Styles.buttonPadding,
      color: Styles.buttonColor,
      child: Text(
        text,
        style: Styles.buttonTextStyle,
      ),
    );
  }
}
