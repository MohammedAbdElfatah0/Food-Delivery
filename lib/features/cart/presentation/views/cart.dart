import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/contents/images.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/features/botton_nav_bar/presentation/cubit/change_page_cubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            // header title
            _headerTitle(),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
            _buildCartEmpty(context),
            // body condtion
          ],
        ),
      ),
    );
  }

  Widget _headerTitle() {
    return Text(
      "My Cart ",
      style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildCartEmpty(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
        //image
        Image.asset(ImageResources.emptyCart, fit: BoxFit.cover),
        //text header
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
        Text(
          "Ouch! Hungry",
          style: AppTextStyle.header5.copyWith(fontWeight: FontWeight.bold),
        ),
        //subtext header
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.025),
        Text(
          "Seems like you have not ordered any food yet",
          textAlign: TextAlign.center,
          style: AppTextStyle.bodyLarge.copyWith(
            fontWeight: FontWeight.w400,
            color: ColorManager.grey,
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
        //serach button /=> back to home ^_^
        ElevatedButton(
          onPressed: () {
            context.read<ChangePageCubit>().changePage(0);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorManager.primary,
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width *0.25),
            elevation: 0
            
          ),
          child: Text(
            'Find Foods',
            style: AppTextStyle.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorManager.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildbodyhasCart() {
    return Column(
      children: [
        //location

        //textfield  promo code

        //list of cart items
        //total price + details
        //botton order now
      ],
    );
  }
}
