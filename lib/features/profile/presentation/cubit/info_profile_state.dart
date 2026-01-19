part of 'info_profile_cubit.dart';

sealed class InfoProfileState extends Equatable {
  const InfoProfileState();

  @override
  List<Object> get props => [];
}

final class InfoProfileInitial extends InfoProfileState {}

final class InfoProfileLoading extends InfoProfileState {}

final class InfoProfileSuccess extends InfoProfileState {
  final UserModel userModel;
  const InfoProfileSuccess(this.userModel);
  @override
  List<Object> get props => [userModel];
}

final class InfoProfileFialure extends InfoProfileState {
  final String message;
  const InfoProfileFialure(this.message);
  @override
  List<Object> get props => [message];
}

//cache??