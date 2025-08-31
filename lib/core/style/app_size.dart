import 'package:flutter/material.dart';

class AppSize {
  static double getWidth({context, value}) {
    return MediaQuery.of(context).size.width * value;
  }

  static double getHeight({BuildContext? context, double value = 20}) {
    return MediaQuery.of(context!).size.width * value;
  }

  static Widget applyPadding({double width = 0, double height = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width, vertical: height),
    );
  }
}
