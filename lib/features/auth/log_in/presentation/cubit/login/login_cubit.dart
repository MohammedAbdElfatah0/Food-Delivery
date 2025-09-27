import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/log_in_entity.dart';
import '../../../domain/use_case/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LogInInUseCase logInUseCase;

  LoginCubit({required this.logInUseCase}) : super(LoginInitial());

  Future<void> logIn(String email, String password) async {
    emit(LoginLoading());
    try {
      final user = await logInUseCase(email, password);
       user.fold(
      (failure) => emit(LoginFailure(errorMessage:  failure.message)), // هتوصل الرسالة للـ UI
      (user) => emit(LoginSuccess(user)),
    );
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}
