import 'package:flutter/material.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/contents/images.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/features/home/presentation/widget/food_delivery_app_bar.dart';

import '../../domain/entity/entity_category.dart';
import '../widget/custom_grid_item.dart';

// Category model for better data management

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Centralized category data
  static List<Category> categories = [
    Category(name: 'Burger', imagePath: ImageResources.foodImages[0]),
    Category(name: 'Pizza', imagePath: ImageResources.foodImages[1]),
    Category(name: 'Drink', imagePath: ImageResources.foodImages[2]),
    Category(name: 'Taco', imagePath: ImageResources.foodImages[3]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white.withAlpha(249),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const FoodDeliveryAppBar(),
            const SizedBox(height: 20),
            _buildCategoryHeader(context),
            const SizedBox(height: 10),
            _buildCategoryList(),
            const SizedBox(height: 20),
            _buildGridView(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Find by Category',
            style: AppTextStyle.header5.copyWith(fontWeight: FontWeight.w600),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implement show all functionality
              print('Show all categories');
            },
            child: Text(
              'Show all',
              style: AppTextStyle.bodyMedium.copyWith(
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 90,
                  decoration: BoxDecoration(
                    color:
                        index == 1
                            ? ColorManager.white
                            : ColorManager.primary.withAlpha(50),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        category.imagePath,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                      Text(category.name),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 25,
        crossAxisSpacing: 15,
        childAspectRatio: 1 / 1.5,
      ),
      itemBuilder: (context, index) {
        // return CustomGridItem(category: categories[index]);
        return const CustomGridItem();
      },
    );
  }
}
