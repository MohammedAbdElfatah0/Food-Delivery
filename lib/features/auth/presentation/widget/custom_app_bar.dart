import 'package:flutter/material.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        Spacer(),
        Text(
          text,
          style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.w600),
        ),
        Spacer(flex: 2),
      ],
    );
  }
}
