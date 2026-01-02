import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/contents/images.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/core/utils/helper/format_price.dart';
import 'package:food_delivery/features/home/presentation/cubit/cart/cart.cubit.dart';
import 'package:food_delivery/features/home/presentation/widget/botton_bar_detail_card.dart';

class DetailsCard extends StatefulWidget {
  const DetailsCard({super.key});

  @override
  State<DetailsCard> createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  bool islove = false;
  @override
  Widget build(BuildContext context) {
    //it's model of cart todo:::
    final Map<String, dynamic> arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return BlocProvider(
      create: (context) => CartCubit(price: arg['price']),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            //app bar
            SliverAppBar(
              expandedHeight: MediaQuery.sizeOf(context).height * 0.36,
              pinned: true,
              backgroundColor: ColorManager.white,
              leading: BackButton(
                onPressed: () => Navigator.pop(context),
                color: ColorManager.white,
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      //make it red or white
                      islove = !islove;
                      setState(() {});
                    },
                    child: Icon(
                      FontAwesomeIcons.solidHeart,
                      color: islove ? ColorManager.error : ColorManager.white,
                    ),
                  ),
                ),
              ],
              //add animation hero
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  ImageResources.ordinaryBurgers,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.008),
                    _header(),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.008),
                    _price(price: arg['price']),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.016),
                    _detailsWork(context),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.032),
                    _description(),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.032),

                    // Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottonBarDetailCard(),
      ),
    );
  }

  Widget _header() {
    return Text(
      'Burger With Meat ',
      style: AppTextStyle.header4,
      textAlign: TextAlign.start,
    );
  }

  Widget _price({required int price}) {
    //todo change state price
    return Text(
      "\$ ${price.withComma}",
      style: AppTextStyle.header5.copyWith(
        color: ColorManager.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _detailsWork(BuildContext context) {
    final double iconSize = 18;
    final Color iconColor = ColorManager.primary;
    final TextStyle textStyle = TextStyle(
      color: ColorManager.grey,
      fontSize: AppTextStyle.bodyMedium.fontSize, // reuse font size if needed
      fontWeight: AppTextStyle.bodyMedium.fontWeight,
    );

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.04,
      decoration: BoxDecoration(
        color: ColorManager.primary.withAlpha(25),
        borderRadius: BorderRadius.circular(22.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          // Free Delivery
          Icon(FontAwesomeIcons.dollarSign, size: iconSize, color: iconColor),
          const SizedBox(width: 6), // small consistent spacing
          Text("Free Delivery", style: textStyle),

          const Spacer(), // pushes next section to center/right
          // Delivery Time
          Icon(FontAwesomeIcons.solidClock, size: iconSize, color: iconColor),
          const SizedBox(width: 6),
          Text("20 - 40", style: textStyle),

          const Spacer(), // pushes rating to the end
          // Rating
          Icon(FontAwesomeIcons.solidStar, size: iconSize, color: iconColor),
          const SizedBox(width: 6),
          Text("4.5", style: textStyle),
        ],
      ),
    );
  }

  Widget _description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          "Burger With Meat is a typical food from our restaurant that is much in demand by many people, this is very recommended for you.",
          style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
