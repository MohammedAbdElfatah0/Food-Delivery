import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/router/navigator_route.dart';
import 'package:food_delivery/features/auth/log_in/data/repository/firebase_log_in_repository.dart';
import 'package:food_delivery/features/auth/log_in/domain/use_case/login_usecase.dart';
import 'package:food_delivery/features/auth/log_in/presentation/cubit/login/login_cubit.dart';
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
      ],

      child: MaterialApp(
        title: "Food Delivery App",
        initialRoute: start,
        onGenerateRoute: NavigatorRoute.generateRoute,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorManager.white,
          primaryColor: ColorManager.primary,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
