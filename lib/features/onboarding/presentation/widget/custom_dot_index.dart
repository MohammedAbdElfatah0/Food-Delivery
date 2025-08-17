import 'package:flutter/widgets.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/features/onboarding/domain/entities_model.dart';

class CustomDotIndex extends StatelessWidget {
  const CustomDotIndex({
    super.key,
    required this.onboardingData,
    required this.currentStep,
  });

  final List<OnBoardingEntity> onboardingData;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onboardingData.length,
        (dotIndex) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: dotIndex == currentStep ? 14 : 8,
          height: dotIndex == currentStep ? 14 : 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                dotIndex == currentStep
                    ? ColorManager.white
                    : ColorManager.grey,
          ),
        ),
      ),
    );
  }
}
