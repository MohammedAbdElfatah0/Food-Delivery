import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/features/home/presentation/home_page.dart';
import 'package:food_delivery/features/onboarding/presentation/views/on_boarding_page.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Something went wrong: ${snapshot.error}'));
        } else {
          if (snapshot.data?.uid != null) {
            return const HomePage();
          } else {
            return const OnBoardingPage();
          }
        }
      },
    );
  }
}
