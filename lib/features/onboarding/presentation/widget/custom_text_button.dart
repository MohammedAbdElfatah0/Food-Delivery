import 'package:flutter/widgets.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.onTap, required this.text});

  final void Function()? onTap;
  final Widget text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: text);
  }
}
