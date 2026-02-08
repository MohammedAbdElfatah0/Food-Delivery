import 'package:flutter/material.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, size: 32),
          ),

          SizedBox(width: MediaQuery.of(context).size.width * 0.25),
          Text(
            text,
            style: AppTextStyle.header5.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
