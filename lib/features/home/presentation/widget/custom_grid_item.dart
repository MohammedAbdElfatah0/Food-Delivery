import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/core/utils/helper/format_price.dart';
import 'package:food_delivery/features/home/presentation/widget/food_item_image.dart';

import '../../../../core/model/product_model.dart';

class CustomGridItem extends StatelessWidget {
  const CustomGridItem({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _buildContainerDecoration(),
      child: Column(
        spacing: MediaQuery.sizeOf(context).height * 0.005,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FoodItemImage(imagePath: product.urlImage ?? ""),
          _buildTitle(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: _buildPrice(),
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() => BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: ColorManager.grey.withAlpha(45),
        blurRadius: 15,
        offset: const Offset(0, 5),
      ),
    ],
    color: ColorManager.white,
    borderRadius: BorderRadius.circular(25),
  );

  Widget _buildTitle() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Text(
      product.title,
      style: AppTextStyle.bodyMedium.copyWith(
        color: ColorManager.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  );

  Widget _buildRating() => Row(
    children: [
      Spacer(),
      Icon(Icons.star, color: ColorManager.primary, size: 21),
      Text(
        product.rating.toString(),
        style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600),
      ),
    ],
  );

  Widget _buildPrice() => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        '\$${product.price.withComma}',
        style: AppTextStyle.bodyLarge.copyWith(
          color: ColorManager.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      Spacer(),
      IconButton(
        onPressed: () {
          //todo add list of shopping items
        },
        icon: const Icon(
          FontAwesomeIcons.cartShopping,
          size: 18,
          color: ColorManager.primary,
        ),
      ),
    ],
  );
}
