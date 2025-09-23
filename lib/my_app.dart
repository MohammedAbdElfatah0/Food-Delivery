import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/core/router/navigator_route.dart';
import 'package:food_delivery/features/auth/data/repositories/firebase_auth_repositories.dart';
import 'package:food_delivery/features/auth/domain/usecases/login_usecase.dart';
import 'package:food_delivery/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:food_delivery/features/onboarding/presentation/cubit/on_boarding_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnBoardingCubit()),
        BlocProvider(
          create:
              (context) => LoginCubit(
                signInUseCase: SignInUseCase(FirebaseAuthRepositories()),
              ),
        ),
      ],

      child: MaterialApp(
        title: "Food Delivery App",
        initialRoute: ContentsRouter.auth,
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
