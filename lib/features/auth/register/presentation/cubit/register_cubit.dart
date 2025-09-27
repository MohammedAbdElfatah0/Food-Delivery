import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/features/auth/register/domain/entity/register_entity.dart';
import '../../domain/use_case/register_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUserUseCase _useCase;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  DateTime? birthday;
  String? gender;

  RegisterCubit(this._useCase) : super(RegisterInitial());

  Future<void> register(BuildContext context) async {
    if (birthday == null || gender == null) {
      emit(RegisterFailure('Please select birthday and gender'));
      return;
    }
    emit(RegisterLoading());
    try {
      final user = await _useCase.execute(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        birthday: birthday!,
        gender: gender!,
      );
      if (user != null) {
        Navigator.of(context).pop();
        user.fold(
          (failure) => emit(RegisterFailure('Registration failed:${failure.message}')),
          (user) => emit(RegisterSuccess(user!)),
        );
      } else {
        emit(RegisterFailure('Registration failed'));
      }
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }

  void updateBirthday(DateTime? newBirthday) {
    birthday = newBirthday;
    emit(RegisterUpdated()); // Trigger rebuild if needed
  }

  void updateGender(String? newGender) {
    gender = newGender;
    emit(RegisterUpdated());
  }

  @override
  Future<void> close() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    return super.close();
  }
}
