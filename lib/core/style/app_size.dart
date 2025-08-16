import 'package:flutter/material.dart';

class AppSize {
 static double getWidth({context, value}) {
    return MediaQuery.of(context).size.width * value;
  }

  static double getHeight({BuildContext ?context,double value=20}) {
    return MediaQuery.of(context!).size.width * value;
  }
}
