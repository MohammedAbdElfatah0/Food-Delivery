import 'package:flutter/material.dart';
import 'package:food_delivery/core/style/app_text_style.dart';

class GenderDropDown extends StatelessWidget {
  const GenderDropDown({super.key, this.selectedGender, this.onChange});
  final String? selectedGender;
  final void Function(String?)? onChange;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Gender", style: AppTextStyle.bodyLarge),
        DropdownButtonFormField(
          items: [
            DropdownMenuItem(value: "Male", child: Text("Male")),
            DropdownMenuItem(value: "Female", child: Text("Female")),
          ],
          onChanged: onChange,
        ),
      ],
    );
  }
}
