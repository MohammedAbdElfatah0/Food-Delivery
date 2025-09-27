import 'package:dartz/dartz.dart';

import '../../../../../core/utils/error/failures.dart';
import '../entities/log_in_entity.dart';
import '../repository/log_in_repository.dart';

class GetCurrentUserUseCase {
  final LogInRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, LogInEntity>> call() async {
    return await repository.getCurrentUser();
  }
}
