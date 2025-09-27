import 'package:flutter/material.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/features/auth/presentation/views/auth.dart';
import 'package:food_delivery/features/auth/forget_password/presentation/forget_password.dart';
import 'package:food_delivery/features/auth/log_in/presentation/view/login.dart';
import 'package:food_delivery/features/auth/otp/presentation/otp_view.dart';
import 'package:food_delivery/features/auth/reset_password/presentation/reset_password.dart';
import 'package:food_delivery/features/auth/register/presentation/view/register_screen.dart';
import 'package:food_delivery/features/home/presentation/home_page.dart';
import 'package:food_delivery/features/onboarding/presentation/views/on_boarding_page.dart';

class NavigatorRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ContentsRouter.auth:
        return MaterialPageRoute(builder: (_) => Auth(), settings: settings);
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
      case ContentsRouter.login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
          settings: settings,
        );
      case ContentsRouter.register:
        return MaterialPageRoute(
          builder: (_) => RegisterPage(),
          settings: settings,
        );
      case ContentsRouter.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => ForgetPassword(),
          settings: settings,
        );
      case ContentsRouter.otpView:
        return MaterialPageRoute(builder: (_) => OtpView(), settings: settings);
      case ContentsRouter.resetPassword:
        return MaterialPageRoute(
          builder: (_) => ResetPassword(),
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
