import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/router/navigator_route.dart';
import 'package:food_delivery/features/auth/log_in/data/repository/firebase_log_in_repository.dart';
import 'package:food_delivery/features/auth/log_in/domain/use_case/login_google_usecase.dart';
import 'package:food_delivery/features/auth/log_in/domain/use_case/login_usecase.dart';
import 'package:food_delivery/features/auth/log_in/presentation/cubit/login/login_cubit.dart';
import 'package:food_delivery/features/auth/log_in/presentation/cubit/google_login/google_login_cubit.dart';
import 'package:food_delivery/features/onboarding/presentation/cubit/on_boarding_cubit.dart';

class MyApp extends StatelessWidget {
  final String start;
  const MyApp({super.key, required this.start});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnBoardingCubit()),
        BlocProvider(
          create:
              (context) => LoginCubit(
                logInUseCase: LogInInUseCase(FirebaseLogInRepository()),
              ),
        ),
        BlocProvider(
          create:
              (context) => GoogleLoginCubit(
                loginGoogleUsecase: LoginGoogleUsecase(
                  FirebaseLogInRepository(),
                ),
              ),
        ),
      ],

      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.grey.withAlpha(
            150,
          ), // Make status bar transparent
          statusBarIconBrightness: Brightness.light, // White icons on Android
          statusBarBrightness:
              Brightness
                  .dark, // Dark status bar for iOS (opposite of icon brightness)
        ),
        child: MaterialApp(
          title: "Food Delivery App",
          initialRoute: start,
          onGenerateRoute: NavigatorRoute.generateRoute,
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFffcfcfc),
            primaryColor: ColorManager.primary,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: ColorManager.primary, //cursor
              selectionHandleColor: ColorManager.primary, // pointer of cursor
              selectionColor: ColorManager.primary.withValues(
                alpha: 0.3,
              ), // shadow select
            ),
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
