import 'package:flutter/material.dart';
import 'package:food_delivery/features/auth/data/repositories/firebase_auth_repositories.dart';
import 'package:food_delivery/features/home/presentation/home_page.dart';
import 'package:food_delivery/features/onboarding/presentation/views/on_boarding_page.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuthRepositories firebaseAuthRepositories =
        FirebaseAuthRepositories();
    return StreamBuilder(
      stream: firebaseAuthRepositories.isLogIn(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return HomePage();
        } else if (snapshot.hasError) {
          return Center(child: Text('Something went wrong ${snapshot.error}'));
        } else {
          return OnBoardingPage();
        }
      }),
    );
  }
}
