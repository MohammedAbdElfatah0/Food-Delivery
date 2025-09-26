part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}
class RegisterUpdated extends RegisterState {}  // For field changes
class RegisterLoading extends RegisterState {}
class RegisterSuccess extends RegisterState {
  final RegisterEntity user;
  RegisterSuccess(this.user);
  @override
  List<Object> get props => [user];
}
class RegisterFailure extends RegisterState {
  final String error;
  RegisterFailure(this.error);
  @override
  List<Object> get props => [error];
}