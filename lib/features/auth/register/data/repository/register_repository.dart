import 'package:food_delivery/features/auth/register/data/firebase/register_firebase_data_source.dart';
import 'package:food_delivery/features/auth/register/domain/entity/register_entity.dart';
import 'package:food_delivery/features/auth/register/domain/repository/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  final FirebaseRegisterDataSource _dataSource;

  RegisterRepositoryImpl(this._dataSource);

  @override
  Future<RegisterEntity?> register({
    required String name,
    required String email,
    required String password,
    required DateTime birthday,
    required String gender,
  }) async {
    try {
      // Age calculated in use case, but passed if needed; here we assume use case handles it
      final age = _calculateAge(
        birthday,
      ); // Placeholder; compute in use case and pass if repo needs it
      return await _dataSource.register(
        name: name,
        email: email,
        password: password,
        birthday: birthday,
        gender: gender,
        age: age,
      );
    } catch (e) {
      rethrow;
    }
  }
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
