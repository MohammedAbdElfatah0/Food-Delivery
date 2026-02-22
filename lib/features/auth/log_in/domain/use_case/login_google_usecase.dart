import 'package:dartz/dartz.dart';
import 'package:food_delivery/core/utils/error/failures.dart';
import 'package:food_delivery/features/auth/log_in/data/model/user_google.dart';
import 'package:food_delivery/features/auth/log_in/domain/repository/log_in_repository.dart';

class LoginGoogleUsecase {
  final LogInRepository repository;

  LoginGoogleUsecase(this.repository);

  Future<Either<Failure, UserGoogle>> call() async {
    return await repository.logInGoogle();
  }
}
