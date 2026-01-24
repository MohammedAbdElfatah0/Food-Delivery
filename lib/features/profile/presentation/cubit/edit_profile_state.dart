part of 'edit_profile_cubit.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class EditProfileSuccess extends EditProfileState {
  final String message;
  const EditProfileSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

final class EditProfileError extends EditProfileState {
  final String message;
  const EditProfileError({required this.message});
  @override
  List<Object> get props => [message];
}
