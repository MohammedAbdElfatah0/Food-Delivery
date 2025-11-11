import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/router/contents_router.dart';

import '../../../../core/shared/shared_preference.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  int _currentStep = 0;
  void next({required int index}) {
    _currentStep = index;
    emit(OnBoardingStep(_currentStep));
  }

  void skip(BuildContext context) async {
    //route

    await AppPreferences.instance.setSeenOnBoarding(true);
    Navigator.pushReplacementNamed(context, ContentsRouter.login);
  }
}
