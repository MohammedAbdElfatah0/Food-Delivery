import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/contents/images.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/core/style/app_size.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              ImageResources.imageOnBoarding[0],
            ), ////todo  0 ->  change
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 50,
              right: 40,
              height: AppSize.getHeight(context: context, value: 0.75),
              width: AppSize.getWidth(context: context, value: 0.8),
              child: Container(
                padding: EdgeInsets.all(8),
                height: 100,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(25),
                ),
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      spacing: 12,
                      children: [
                        Text(
                          "We serve incomparable delicacies",
                          style: AppTextStyle.header4.copyWith(
                            color: ColorManager.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        Text(
                          "All the best restaurants with their top menu waiting for you, they cant’t wait for your order!!",
                          style: AppTextStyle.bodySmall.copyWith(
                            color: ColorManager.white,
                            fontWeight: FontWeight.bold,
                            height: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        //todo:: implement
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.maximize_outlined,
                              size: 40,
                              color: ColorManager.grey,
                            ),
                            Icon(
                              Icons.maximize_outlined,
                              size: 40,
                              color: ColorManager.white,
                            ),
                            Icon(
                              Icons.maximize_outlined,
                              size: 40,
                              color: ColorManager.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "skip",
                          style: AppTextStyle.header6.copyWith(
                            color: ColorManager.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "next",
                          style: AppTextStyle.header6.copyWith(
                            color: ColorManager.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
