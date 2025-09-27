import 'package:dartz/dartz.dart';
import 'package:food_delivery/core/utils/error/failures.dart';
import 'package:food_delivery/features/auth/register/domain/entity/register_entity.dart';
import 'package:food_delivery/features/auth/register/domain/repository/register_repository.dart';

class RegisterUserUseCase {
  final RegisterRepository _repository;

  RegisterUserUseCase(this._repository);

  Future<Either<Failure, RegisterEntity?>> execute({
    required String name,
    required String email,
    required String password,
    required DateTime birthday,
    required String gender,
  }) async {
    final age = _calculateAge(birthday);
    if (age < 12) {
      Left(FirebaseFailure("User must be at least 12 years old"));
    }
    return Right(
      _repository.register(
            name: name,
            email: email,
            password: password,
            birthday: birthday,
            gender: gender,
          )
          as RegisterEntity?,
    );
  }

  int _calculateAge(DateTime birthday) {
    final now = DateTime.now();
    int age = now.year - birthday.year;
    if (now.month < birthday.month ||
        (now.month == birthday.month && now.day < birthday.day)) {
      age--;
    }
    return age;
  }
}
