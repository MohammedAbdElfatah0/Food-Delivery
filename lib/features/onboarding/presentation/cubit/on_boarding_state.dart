part of 'on_boarding_cubit.dart';

@immutable
sealed class OnBoardingState {}

final class OnBoardingInitial extends OnBoardingState {}

final class OnBoardingStep extends OnBoardingState {
  final int step;
  OnBoardingStep(this.step);
}
final class OnBoardingFinished extends OnBoardingState {}

