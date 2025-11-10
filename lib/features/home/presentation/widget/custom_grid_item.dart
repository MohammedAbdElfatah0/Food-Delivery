import 'package:flutter/material.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/features/home/presentation/widget/food_item_image.dart';

class CustomGridItem extends StatelessWidget {
  const CustomGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildContainerDecoration(),

      child: Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FoodItemImage(),
          _buildTitle(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21.0),
            child: _buildRating(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21.0),
            child: _buildPrice(),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() => BoxDecoration(
    color: ColorManager.white,
    borderRadius: BorderRadius.circular(25),
  );

  Widget _buildTitle() => Text(
    'Ordinary Burgers',
    style: TextStyle(
      color: ColorManager.black,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );

  Widget _buildRating() => Row(
    children: [
      Spacer(),
      Icon(Icons.star, color: ColorManager.primary, size: 21),
      Text(
        '4.5',
        style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600),
      ),
    ],
  );

  Widget _buildPrice() => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        '\$15.99',
        style: AppTextStyle.bodyLarge.copyWith(
          color: ColorManager.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
