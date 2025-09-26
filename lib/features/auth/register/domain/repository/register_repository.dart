import 'package:food_delivery/features/auth/register/domain/entity/register_entity.dart';

abstract class RegisterRepository {
  Future<RegisterEntity?> register({
    required String name,
    required String email,
    required String password,
    required DateTime birthday,
    required String gender,
  });
}
