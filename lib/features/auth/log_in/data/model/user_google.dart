import 'package:food_delivery/features/auth/domain/entities/user_entity.dart';

class UserGoogle extends UserEntity {
    UserGoogle({
    required super.id,
    required super.name,
    required super.email,
    required super.photoUrl,
    required super.gender,
    required super.birthday,
    required super.createdAt,
    required super.phone,
    required super.provider,
  });
}
