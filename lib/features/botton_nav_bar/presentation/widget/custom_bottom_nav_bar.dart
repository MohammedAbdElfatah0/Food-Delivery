import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      notchMargin: 4,
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          items:  [
            BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.houseChimney), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.bagShopping),
              label: 'Cart',
            ),
            BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.commentDots), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.user), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
