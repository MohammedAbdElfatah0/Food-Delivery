import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/core/utils/helper/format_price.dart';

class BottonBarDetailCard extends StatelessWidget {
  const BottonBarDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 125,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      // color: ColorManager.secondary,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_addNewEntry(), _totalPrice(price: 24000)],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              elevation: WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(ColorManager.primary),
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.3,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 20,
              children: [
                Icon(FontAwesomeIcons.cartShopping, color: ColorManager.white),
                Text(
                  'Add to Cart',
                  style: AppTextStyle.bodyLarge.copyWith(
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _addNewEntry() {
    return Row(
      children: [
        //
        IconButton(
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.minus),
          color: ColorManager.black,
        ),
        Text(
          '4',
          style: AppTextStyle.header6.copyWith(fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(FontAwesomeIcons.plus),
          color: ColorManager.black,
        ),
      ],
    );
  }

  Widget _totalPrice({int count = 1, required int price}) {
    int totalprice = count * price;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(
        '\$ ${totalprice.withComma}',
        style: AppTextStyle.header5.copyWith(
          color: ColorManager.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
