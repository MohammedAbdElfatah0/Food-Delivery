import 'package:flutter/material.dart';
import 'package:food_delivery/core/colors/color_manager.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: ColorManager.primary,
        valueColor: AlwaysStoppedAnimation<Color>(ColorManager.white),
        strokeWidth: 3,
      ),
    );
  }
}
