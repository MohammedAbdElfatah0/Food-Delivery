import 'package:equatable/equatable.dart';
import 'package:food_delivery/features/auth/log_in/data/model/user_google.dart';

abstract class GoogleLoginState extends Equatable {
  const GoogleLoginState();

  @override
  List<Object?> get props => [];
}

class GoogleLoginInitial extends GoogleLoginState {
  const GoogleLoginInitial();
}

class GoogleLoginLoading extends GoogleLoginState {
  const GoogleLoginLoading();
}

class GoogleLoginSuccess extends GoogleLoginState {
  final UserGoogle user;

  const GoogleLoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class GoogleLoginFailure extends GoogleLoginState {
  final String errorMessage;

  const GoogleLoginFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
