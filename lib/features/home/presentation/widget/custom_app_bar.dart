import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/features/home/presentation/widget/city_selection_screen.dart';
import 'package:food_delivery/features/home/presentation/widget/location_button.dart';
import '../../../../core/shared/shared_preference.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  String currentCity = 'Cairo';

  Widget searchAppBar() {
    return IconButton(
      onPressed: () {
        //todo::navagate to search screen
      },
      icon: Icon(Icons.search_rounded, color: ColorManager.white, size: 32),
    );
  }

  Widget notificationAppBar() {
    return IconButton(
      onPressed: () {
        //todo::navagate to notification screen
      },
      icon: Icon(Icons.notifications, color: ColorManager.white, size: 32),
    );
  }

  @override
  void initState() {
    super.initState();
    currentCity = AppPreferences.instance.selectedCity;
  }

  void _openCityPicker() async {
    final newCity = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CitySelectionScreen()),
    );

    if (newCity != null && newCity is String) {
      setState(() => currentCity = newCity);
      
      // حفظها مرة واحدة بس وخلاص
      await AppPreferences.instance.setSelectedCity(newCity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LocationButton(
          city: currentCity,
          onTap: () async {
            _openCityPicker();
          },
        ), //colum search
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
