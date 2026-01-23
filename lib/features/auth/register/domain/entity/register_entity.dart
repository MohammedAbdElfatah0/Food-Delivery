import 'package:food_delivery/core/contents/enum.dart';

class RegisterEntity {
  final String id;
  final String name;
  final String email;
  final DateTime birthday;
  final GENDER gender;
  final int age;

  RegisterEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.birthday,
    required this.gender,
    required this.age,
  });
}