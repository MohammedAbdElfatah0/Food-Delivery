import 'package:flutter/widgets.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/features/onboarding/domain/entities_model.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, required this.data});

  final OnBoardingEntity data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          data.title,
          style: AppTextStyle.header4.copyWith(
            color: ColorManager.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          data.subtitle,
          style: AppTextStyle.bodySmall.copyWith(
            color: ColorManager.white,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
