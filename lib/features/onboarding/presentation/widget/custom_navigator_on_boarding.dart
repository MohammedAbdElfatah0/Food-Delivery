import 'package:flutter/widgets.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/features/onboarding/domain/entities_model.dart';
import 'package:food_delivery/features/onboarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:food_delivery/features/onboarding/presentation/widget/custom_dot_index.dart';
import 'package:food_delivery/features/onboarding/presentation/widget/custom_text_button.dart';

class CustomNavigatorOnBoarding extends StatelessWidget {
  const CustomNavigatorOnBoarding({
    super.key,
    required this.cubit,
    required this.onboardingData,
    required this.currentStep,
    required this.index,
  });

  final OnBoardingCubit cubit;
  final List<OnBoardingEntity> onboardingData;
  final int currentStep;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextButton(
          text: Text(
            TextString.skip,
            style: AppTextStyle.header6.copyWith(
              color: ColorManager.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => cubit.skip(context),
        ),
        // Page Indicators
        CustomDotIndex(
          onboardingData: onboardingData,
          currentStep: currentStep,
        ),
        CustomTextButton(
          onTap: () {
            if (index < onboardingData.length - 1) {
              cubit.next(index: index + 1);
            } else {
              cubit.skip(context);
            }
          },
          text: Text(
            index < onboardingData.length - 1 ? TextString.next : TextString.getStart,
            style: AppTextStyle.header6.copyWith(
              color: ColorManager.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
