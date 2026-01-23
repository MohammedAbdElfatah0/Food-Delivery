import 'package:flutter/material.dart';
import 'package:food_delivery/core/contents/enum.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

import '../../../../core/Colors/color_manager.dart';

class GenderDropDown extends StatelessWidget {
  const GenderDropDown({super.key, this.selectedGender, this.onChange});
  final String? selectedGender;
  final void Function(String?)? onChange;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gender", style: AppTextStyle.bodyLarge),
        DropdownButtonFormField(
          items: [
            DropdownMenuItem(
              value: GENDER.male.name,
              child: Text(GENDER.male.name),
            ),
            DropdownMenuItem(
              value: GENDER.female.name,
              child: Text(GENDER.female.name),
            ),
          ],
          onChanged: onChange,
          decoration: InputDecoration(
            border: _buildBorder(),
            enabledBorder: _buildBorder(),
            focusedBorder: _buildBorder(isFocused: true),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  OutlineInputBorder _buildBorder({bool isFocused = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: isFocused ? ColorManager.primary : Colors.grey,
        width: 1.5,
      ),
    );
  }
}
