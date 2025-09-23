import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery/features/auth/domain/entities/user_entity.dart';

import '../../../domain/usecases/login_usecase.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SignInUseCase signInUseCase;

  LoginCubit({required this.signInUseCase}) : super(LoginInitial());

  Future<void> signIn(String email, String password) async {
    emit(LoginLoading());
    try {
      final user = await signInUseCase(email, password);
      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}