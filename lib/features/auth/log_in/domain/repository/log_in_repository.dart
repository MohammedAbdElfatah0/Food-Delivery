import 'package:dartz/dartz.dart';
import 'package:food_delivery/core/utils/error/failures.dart';
import '../entities/log_in_entity.dart';

abstract class LogInRepository {
  Future<Either<Failure, LogInEntity>> logIn(String email, String password);
  Future<Either<Failure, LogInEntity>> getCurrentUser();
}
