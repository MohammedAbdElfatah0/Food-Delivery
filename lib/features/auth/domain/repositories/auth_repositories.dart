import '../entities/user_entity.dart';

abstract class AuthRepositories {
  // Add your repository methods here
  Future<void> logOut();
  Future<UserEntity?> getCurrentUser();
}
