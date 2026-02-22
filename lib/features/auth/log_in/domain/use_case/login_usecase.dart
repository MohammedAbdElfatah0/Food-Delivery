import 'package:dartz/dartz.dart';
import 'package:food_delivery/core/utils/error/failures.dart';

import '../entities/log_in_entity.dart';
import '../repository/log_in_repository.dart';

class LogInInUseCase {
  final LogInRepository repository;

  LogInInUseCase(this.repository);

  Future<Either<Failure, LogInEntity>> call(
    String email,
    String password,
  ) async {
    return await repository.logInEmail(email, password);
  }
}
