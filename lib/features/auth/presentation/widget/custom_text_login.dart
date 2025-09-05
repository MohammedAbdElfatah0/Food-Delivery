import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

class CustomTextLogin extends StatelessWidget {
  const CustomTextLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyle.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: TextString.headerDoNotHaveAccount,
                style: TextStyle(color: ColorManager.black),
              ),
              TextSpan(
                text: TextString.login,
                style: TextStyle(color: ColorManager.primary),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pop(context);
                      },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
