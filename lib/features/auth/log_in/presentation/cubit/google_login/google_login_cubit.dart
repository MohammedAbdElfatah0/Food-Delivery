import 'package:bloc/bloc.dart';
import 'package:food_delivery/features/auth/log_in/domain/use_case/login_google_usecase.dart';

import 'google_login_state.dart';

class GoogleLoginCubit extends Cubit<GoogleLoginState> {
  final LoginGoogleUsecase loginGoogleUsecase;

  GoogleLoginCubit({required this.loginGoogleUsecase})
    : super(const GoogleLoginInitial());

  Future<void> logInWithGoogle() async {
    emit(const GoogleLoginLoading());

    final result = await loginGoogleUsecase();
    result.fold(
      (failure) => emit(GoogleLoginFailure(errorMessage: failure.message)),
      (user) => emit(GoogleLoginSuccess(user)),
    );
  }
}
