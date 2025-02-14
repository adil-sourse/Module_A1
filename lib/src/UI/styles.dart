import 'package:flutter/cupertino.dart';

class Styles {
  static Color backgroundColor = CupertinoColors.white;
  static Color textFieldColor = CupertinoColors.white;
  static Color buttonColor = Color.fromRGBO(54, 2, 243, 1);
  static Color borderColor =
      Color.from(alpha: 1, red: 0.812, green: 0.812, blue: 0.812);

  static TextStyle buttonTextStyle =
      TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.white);
  static TextStyle profileTextStyle =
      TextStyle(fontWeight: FontWeight.bold, color: CupertinoColors.black);

  static EdgeInsetsGeometry textFieldPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 19);
  static EdgeInsetsGeometry buttonPadding = EdgeInsets.symmetric(vertical: 20);
  static EdgeInsetsGeometry pagePadding = EdgeInsets.symmetric(horizontal: 16);
}
