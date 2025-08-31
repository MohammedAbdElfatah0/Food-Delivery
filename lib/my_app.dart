import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/core/router/navigator_route.dart';
import 'package:food_delivery/features/onboarding/presentation/cubit/on_boarding_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: MaterialApp(
        title: "Food Delivery App",
        initialRoute: ContentsRouter.onBoarding,
        onGenerateRoute: NavigatorRoute.generateRoute,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorManager.white,
          primaryColor: ColorManager.primary, // Assuming you have ColorManager
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
