import 'package:flutter/material.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/features/home/presentation/home_page.dart';
import 'package:food_delivery/features/onboarding/presentation/views/on_boarding_page.dart';

class NavigatorRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ContentsRouter.onBoarding:
        return MaterialPageRoute(
          builder: (_) => OnBoardingPage(),
          settings: settings,
        );
      case ContentsRouter.home:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
