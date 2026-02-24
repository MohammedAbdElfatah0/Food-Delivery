import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/colors/color_manager.dart';
import 'package:food_delivery/core/contents/enum.dart';
import 'package:food_delivery/core/contents/images.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/core/style/app_text_style.dart';
import 'package:food_delivery/core/di/servier_locator.dart';
import 'package:food_delivery/features/home/presentation/cubit/product/product.cubit.dart';
import 'package:food_delivery/features/home/presentation/cubit/product/product.status.dart';
import 'package:food_delivery/features/home/presentation/widget/food_delivery_app_bar.dart';

import '../../domain/entity/entity_category.dart';
import '../widget/custom_grid_item.dart';

// Category model for better data management

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Centralized category data
  //todo go file domain and check entity_category
  static List<Category> categories = [
    Category(
      name: CategoryKey.burger.name,
      imagePath: ImageResources.foodImages[0],
    ),
    Category(
      name: CategoryKey.pizza.name,
      imagePath: ImageResources.foodImages[1],
    ),
    Category(
      name: CategoryKey.drink.name,
      imagePath: ImageResources.foodImages[2],
    ),
    Category(
      name: CategoryKey.taco.name,
      imagePath: ImageResources.foodImages[3],
    ),
  ];

  int _selectedCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductCubit>(),
      child: Scaffold(
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
              const SizedBox(height: 20),
            ],
          ),
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

  //todo when buttom of ant item the category change with using bloc it's best
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
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });

                    context.read<ProductCubit>().getProductsByCategory(
                      category.name,
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: 100,
                    height: 90,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.grey.withAlpha(35),
                          blurRadius: 10,
                          offset: const Offset(4, 4),
                        ),
                      ],
                      color:
                          index == _selectedCategoryIndex
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  //todo give detials of category
  Widget _buildGridView(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductStatus>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProductSuccess) {
          final products = state.products;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 25,
              crossAxisSpacing: 15,
              childAspectRatio: 1 / 1.5,
            ),
            itemBuilder: (context, index) {
              final product = products[index];

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ContentsRouter.detailsCard,
                    arguments: product,
                  );
                },
                child: CustomGridItem(product: product),
              );
            },
          );
        }

        if (state is ProductError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}
