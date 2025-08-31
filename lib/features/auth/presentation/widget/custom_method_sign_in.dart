import 'package:flutter/material.dart';

class CustomMethodSignIn extends StatelessWidget {
  const CustomMethodSignIn({super.key});
  Widget customIcon({required IconData icon}) {
    return GestureDetector(onTap: () {}, child: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 30,
      children: [
        customIcon(icon: Icons.apple_sharp),
        customIcon(icon: Icons.facebook_sharp),
        //TODO::change icon
        customIcon(icon: Icons.facebook),
      ],
    );
  }
}
