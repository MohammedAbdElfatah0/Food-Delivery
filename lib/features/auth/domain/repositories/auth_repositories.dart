import '../entities/user_entity.dart';

abstract class AuthRepositories {
  // Add your repository methods here
  Future<UserEntity> signIn(String email, String password);
  Future<void> logOut();
  Future<UserEntity?> getCurrentUser();
  Future<UserEntity?> register(String name, String email, String password);
   isLogIn();
}
