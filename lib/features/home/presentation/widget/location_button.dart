import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';

import '../../../../core/style/app_text_style.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8), // تأثير الضغط دائري
      onTap: () {
        // هنا تكتب الكود اللي يحصل لما يضغط الزر
        print('Location button pressed');
        // ممكن تفتح BottomSheet أو PopupMenu لاختيار المدينة
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your Location',
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: ColorManager.white,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_drop_down,
                  size: 16,
                  color: ColorManager.white,
                ),
              ],
            ),

            const SizedBox(height: 4),

            // السطر الثاني: أيقونة الموقع + اسم المدينة
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: ColorManager.white,
                  size: 18,
                ),
                SizedBox(width: 4),
                Text(
                  'New York City',
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
