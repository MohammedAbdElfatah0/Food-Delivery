import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  int _currentStep = 0;
  void next({required int index}) {
    _currentStep = index;
    emit(OnBoardingStep(_currentStep));
  }

  void skip(BuildContext context)async {
    //route
    final sharedPref = await SharedPreferences.getInstance();
    final seenOnBoarding = sharedPref.setBool("seenOnBoarding",true) ;
    Navigator.pushReplacementNamed(context, ContentsRouter.login);
  }
}
