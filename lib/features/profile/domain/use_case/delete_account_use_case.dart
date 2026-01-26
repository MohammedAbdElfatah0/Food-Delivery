import 'package:dartz/dartz.dart';

import '../repository/profile_repository.dart';

class DeleteAccountUseCase {
  final ProfileRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<Either<String, void>> call({required String password}) {
    return repository.deleteAccount(password: password);
  }
}
