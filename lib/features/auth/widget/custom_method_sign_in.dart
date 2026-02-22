import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/features/auth/log_in/presentation/cubit/google_login/google_login_cubit.dart';

class CustomMethodSignIn extends StatelessWidget {
  const CustomMethodSignIn({super.key});
  Widget customIcon({required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(onTap: onTap, child: Icon(icon));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 30,
      children: [
        //TODO : logic sign in with apple
        customIcon(icon: FontAwesomeIcons.apple),
        //TODO : logic sign in with facebook
        customIcon(icon: FontAwesomeIcons.facebook),
        //TODO : logic sign in with google
        customIcon(
          icon: FontAwesomeIcons.google,
          onTap: () {
            context.read<GoogleLoginCubit>().logInWithGoogle();
          },
        ),
      ],
    );
  }
}
