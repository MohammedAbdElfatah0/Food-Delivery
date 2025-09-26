import '../entities/log_in_entity.dart';
import '../repository/log_in_repository.dart';

class LogInInUseCase {
  final LogInRepository repository;

  LogInInUseCase(this.repository);

  Future<LogInEntity> call(String email, String password) async {
    return await repository.signIn(email, password);
  }
}
