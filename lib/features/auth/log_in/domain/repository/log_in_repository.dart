import '../entities/log_in_entity.dart';

abstract class LogInRepository {
  Future<LogInEntity> signIn(String email, String password);
}
