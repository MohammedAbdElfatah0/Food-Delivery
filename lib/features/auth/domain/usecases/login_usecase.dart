import 'package:food_delivery/features/auth/domain/entities/user_entity.dart';

import '../repositories/auth_repositories.dart';

class SignInUseCase {
  final AuthRepositories repository;

  SignInUseCase(this.repository);

  Future<UserEntity> call(String email, String password) async {
    return await repository.signIn(email, password);
  }
}