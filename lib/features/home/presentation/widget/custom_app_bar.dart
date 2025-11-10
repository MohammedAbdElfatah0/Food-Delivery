import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/features/home/presentation/widget/location_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});
  Widget searchAppBar() {
    return Icon(Icons.search_rounded, color: ColorManager.white, size: 32);
  }

  Widget notificationAppBar() {
    return Icon(Icons.notifications, color: ColorManager.white, size: 32);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LocationButton(), //colum search
        //search
        Spacer(),
        searchAppBar(),
        //notification
        SizedBox(width: 16),
        notificationAppBar(),
      ],
    );
  }
}
