// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:food_delivery/core/colors/color_manager.dart';
// import 'package:food_delivery/core/style/app_text_style.dart';
// import 'package:food_delivery/core/utils/helper/format_price.dart';

// import '../../../home/presentation/cubit/cart/cart.cubit.dart';
// import '../../domain/entities/product_entity.dart';

// class CustomCartItem extends StatelessWidget {
//   final int index;
//   const CustomCartItem({super.key, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CartCubit, CartStatus>(
//       builder: (context, state) {
//         final product = state.products[index];
//         return Container(
//           child: Row(
//             children: [
//               Image.asset(product.image),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     style: AppTextStyle.bodyLarge.copyWith(
//                       color: ColorManager.black,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Text(
//                     (product.price.toInt() * product.quantity).withComma,
//                     style: AppTextStyle.bodyLarge.copyWith(
//                       color: ColorManager.primary,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   _buttonPlusOrMuns(context, product),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buttonPlusOrMuns(BuildContext context, ProductEntity product) {
//     return Row(
//       children: [
//         IconButton(
//           onPressed: () {
//             context.read<CartCubit>().decrementPrice();
//           },
//           icon: const Icon(FontAwesomeIcons.minus, size: 24),
//           color: ColorManager.black,
//         ),
//         Text(
//           product.quantity.toString(),
//           style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold),
//         ),
//         IconButton(
//           onPressed: () {
//             context.read<CartCubit>().incrementPrice();
//           },
//           icon: const Icon(FontAwesomeIcons.plus, size: 24),
//           color: ColorManager.black,
//         ),
//       ],
//     );
//   }
// }
