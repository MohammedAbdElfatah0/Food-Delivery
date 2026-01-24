import 'package:dartz/dartz.dart';

import '../../../../core/model/user_model.dart';
import '../repository/profile_repository.dart';

class UpdateProfile {
  final ProfileRepository repository;

  UpdateProfile(this.repository);

  Future<Either<String, Unit>> call(UserModel user) {
    return repository.updateProfile(user);
  }
}